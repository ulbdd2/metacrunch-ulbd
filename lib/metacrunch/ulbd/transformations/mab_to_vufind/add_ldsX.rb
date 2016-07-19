require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_vufind"
require_relative "./helpers/merge"

class Metacrunch::ULBD::Transformations::MabToVufind::AddLdsX < Metacrunch::Transformator::Transformation::Step
  include parent::Helpers::Merge

  def call
    target ? Metacrunch::Hash.add(target, "ldsX", ldsX) : ldsX
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
    r = []

    source.datafields('200', ind2: '9').each do |field|
      field_0 = field.subfields('0')
      field_a = field.subfields('a')
      field_b = field.subfields('b')
      field_c = field.subfields('c')
      field_e = field.subfields('e')
      field_f = field.subfields('f')
      field_g = field.subfields('g')

      s = ""
      s = merge(s, field_a.value, delimiter: ' ')
      s = merge(s, field_b.value, delimiter: ': ')
      s = merge(s, field_c.value, delimiter: ' ')
      s = merge(s, field_e.value, delimiter: '. ')
      s = merge(s, field_g.value, delimiter: ' <strong>Zeitschriftensignatur</strong>: ')
      s = merge(s, field_f.value, delimiter: ': ')

      # Cleanup
      s = s.gsub(/^\- /, '') # Z.b. "- Index: Foo Bar"

      # Sort
      position = nil
      if field_0.present?
        position = ((field_0.value || "").match(/^(\d+)$/) && $1.to_i) || nil
      end

      if position && position.is_a?(Fixnum)
        r[position] = s
      else
        r << s
      end
    end

    r.map(&:presence).compact.uniq
  end
end
