require "mighty_hash"
require "transformator/transformation/step"
require_relative "../mab_to_primo"

class Metacrunch::UBPB::Transformations::MabToPrimo::AddSignatureSearch < Transformator::Transformation::Step
  def call
    target ? MightyHash.add(target, "signature_search", signature_search) : signature_search
  end

  private

  def signature_search
    signatures = []
    signatures = signatures + source.datafields('LOC').subfields('d').values
    # Stücktitel Signatur
    signatures << source.datafields('100', ind2: ' ').subfields('a').value
    # Zeitschriftensignatur
    signatures << source.datafields('200', ind1: ' ', ind2: ' ').subfields('f').values

    signatures = signatures.flatten.map(&:presence).compact
    .map do |signature|
      _signature = signature
        .gsub(/\A\//, '') # remove leading '/' for some journal signatures
        .gsub(/\s+/,  '') # remove spaces for some journal signatures (e.g. 'P 10/34 t 26')
        .upcase           # upcase signatures like 'P10/34t26' to 'P10/34T26' to detect duplicates like 34t26 and 34T26 (search engine should handle downcasing, primo does)

      # for signatures with volume count e.g. 'LKL2468-14/15', add all variants possible ['LKL2468-14/15', 'LKL2468-14', 'LKL2468']
      _signature_array = [_signature, _signature.gsub(/(\d+)\/\d+\Z/, '\1'), _signature.gsub(/\-\d+.*\Z/, '')]

      # for journals which only have one single signature with leading 'Pxx/' like 'P10/34M3' create 'Pxx/'-less version also
      _signature_array.push _signature.gsub(/\AP\d+\//, '')
    end.flatten

    # if any signature is a journal signature
    if (journal_signature = signatures.select { |signature| signature.try(:[], /\d+[A-Za-z]\d+$/).present? }.first).present?
      if signatures.none? { |signature| signature.starts_with? 'P' }
        # TODO: code duplication with :signature
        standort_kennziffer = if (loc_standort_kennziffer = source.datafields('LOC').subfields('b').value).present?
          loc_standort_kennziffer
        elsif (f105a = source.datafields('105').subfields('a').value).present?
          f105a
        end

        if standort_kennziffer.present?
          signatures << "P#{standort_kennziffer}/#{journal_signature}".gsub(/\/\//, '/')
        end
      end
    end

    signatures.map! do |signature|
      is_journal_signature = signature.match(/(P\d\d\/)?\d\d?[a-zA-Z]\d\d?/)
      spaced_journal_signature = signature.gsub(/\AP(\d\d)/, 'P \1').gsub(/(\d\d?)([a-zA-Z])(\d\d?)/, '\1 \2 \3') if is_journal_signature
      [signature, spaced_journal_signature]
    end.flatten!

    signatures.flatten.map(&:presence).compact.uniq
  end
end
