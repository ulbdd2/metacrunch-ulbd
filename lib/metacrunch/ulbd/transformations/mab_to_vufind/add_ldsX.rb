require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_vufind"
require_relative "./helpers/merge"
require_relative "./helpers/locationname"

class Metacrunch::ULBD::Transformations::MabToVufind::AddLdsX < Metacrunch::Transformator::Transformation::Step
  include parent::Helpers::Merge
  include parent::Helpers::Locationname

  def call
    target ? Metacrunch::Hash.add(target, "ldsX_str_mv", ldsX) : ldsX
  end

  private

  def ldsX
    # Feld 200 mit ind1 = ' ', ind2 = ' '
    # Unterfelder:
    #   0 - Sortierindikator
    #   a - Einleitende Wendung
    #   b - Verlauf
    #   c - Lücke im Bestand / Verlauf
    #   e - Kommentar
    #   f - Signatur
    #   g - lokales Sigel
    r = []

    source.datafields('200', ind2: '9').each do |field|
      
      field_0 = field.subfields('0')
      field_a = field.subfields('a')
      field_b = field.subfields('b')
      field_c = field.subfields('c')
      field_e = field.subfields('e')
      field_f = field.subfields('f')
      field_g = field.subfields('g').present? ? '<strong>' + locationname(field.subfields('g').value) + '</strong>' :''
      field_h = field.subfields('h')

      s = ""
      s = merge(s, field_a.value, delimiter: ' ')
      s = merge(s, field_b.value, delimiter: ': ')
      s = merge(s, field_c.value, delimiter: ' ')
      s = merge(s, field_e.value, delimiter: '. ')
      s = merge(s, field_g, delimiter: ': ')
      s = merge(s, field_h.value, delimiter: ' ')
      s = merge(s, field_f.value, delimiter: ': ')
      

      # Cleanup
      s = s.gsub(/^\- /, '') # Z.b. "- Index: Foo Bar"

      r << s
      
      # Sort
      # auskommentiert, weil durch gleiche field_0-Werte Array-Elemente
      # verloren gehen würden
=begin
     position = nil
      if field_0.present?
        position = ((field_0.value || "").match(/^(\d+)$/) && $1.to_i) || nil
      end

      if position && position.is_a?(Fixnum)
        r[position] = s
      else
        r << s
      end
=end


    end
    r.map(&:presence).compact.uniq
    
  end
end
