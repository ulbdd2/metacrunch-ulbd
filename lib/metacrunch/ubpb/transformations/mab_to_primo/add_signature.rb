require "mighty_hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_primo"

class Metacrunch::UBPB::Transformations::MabToPrimo::AddSignature < Metacrunch::Transformator::Transformation::Step
  def call
    target ? MightyHash.add(target, "signature", signature) : signature
  end

  private

  def signature
    signatures = []

    # Lade LOC Felder für Signaturen-Extraktion
    fields = source.datafields('LOC')
    # Lösche alle Felder die kein Unterfeld d haben (ausgesondert)
    fields = fields.reject{|f| f.subfields.find{|sf| sf.code == "d"}.blank?}
    # Prüfe ob alle Exemplare im Magazin stehen
    all_stack = fields.map{|f| f.subfields.find {|sf| sf.code == 'b' && sf.value.match(/02|03|04|07/)}.present?}.all?

    # Zeitschriftensignatur (haben Vorrgang, falls vorhanden)
    #
    # Achtung, bei Feld 200 handelt es sich um einen Aleph-Expand. Dieses Feld ist an den beiden leeren Indikatoren zu erkennen.
    # Darüber hinaus kann dieses Feld mehrfach vorkommen. Wir nehmen an, dass Subfeld 0 eine Art Zählung angibt, weshalb dort
    # ein Wert von '1' zu bevorzugen ist.
    #
    signatures << source.datafields('200', ind1: ' ', ind2: ' ')
    .select { |f| f.subfields('f').present?                  }
    .select { |f| (value = f.subfields('0').value) == '1' || value.nil? }
    .map    { |f| f.subfields('f').value.try(:gsub, ' ', '') }
    .first.presence

    # Wenn alle Exemplare im Magzin stehen, dann nimm nur die erste signatur
    if all_stack
      fields.each do |field|
        subfield = field.subfields.find{|f| f.code == "d"}
        if subfield.present? && subfield.value.present?
          signatures << subfield.value
          break
        end
      end
    # ansonsten extrahiere aus den normalen Signaturen eine Basis-Signatur
    else
      # Lösche alle Felder die als Standordkennziffer eine Magazinkennung haben
      fields = fields.reject{|f| f.subfields.find{|sf| sf.code == 'b' && sf.value.match(/02|03|04|07/)}.present?}

      # Sortiere die restlichen Felder nach Unterfeld 5 (Strichcode)
      fields = fields.sort do |x, y|
       x5 = x.subfields.find{|f| f.code == "5"}
       y5 = y.subfields.find{|f| f.code == "5"}
       if x5 && y5
         x5.value <=> y5.value
       else
         0
       end
      end

      # Extrahiere die Signaturen aus Unterfeld d und erzeuge eine Basis-Signatur
      fields.each do |field|
        subfield = field.subfields.find{|f| f.code == "d"}
        if subfield.present? && subfield.value.present?
          signature      = subfield.value
          index          = signature.index('+') || signature.length
          base_signature = signature[0..index-1]
          signatures << base_signature
        end
      end
    end

    # Stücktitel Signatur
    signatures << source.datafields('100', ind2: ' ').subfields('a').value

    # Some additional love for journal signatures
    signatures.map! do |signature|
      # if this is a journal signature
      if signature.try(:[], /\d+[A-Za-z]\d+$/).present?
        # unless there is a leading standortkennziffer
        unless signature.starts_with?('P')
          standort_kennziffer = if (loc_standort_kennziffer = source.datafields('LOC').subfields('b').value).present?
            loc_standort_kennziffer
          elsif (f105a = source.datafields('105').subfields('a').value).present?
            f105a
          end

          standort_kennziffer.present? ? "P#{standort_kennziffer}/#{signature}".gsub(/\/\//, '/') : signature
        else
          signature
        end.downcase.capitalize # last but not least make journal signatures like P10/34T24 to P10/34t24
      else
        signature
      end
    end

    # Fertig. Wir nehmen die erste Signatur zur Anzeige
    signatures.flatten.map(&:presence).compact.uniq.first
  end
end
