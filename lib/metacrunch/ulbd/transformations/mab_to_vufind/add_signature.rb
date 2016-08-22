require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_vufind"
require_relative "./helpers/merge"

class Metacrunch::ULBD::Transformations::MabToVufind::AddSignature < Metacrunch::Transformator::Transformation::Step
  include parent::Helpers::Merge

  def call
    target ? Metacrunch::Hash.add(target, "callnumber-raw", signature) : signature
  end

  private

  def signature

    r = []
    
    source.datafields('LOC').each do |field|
      field_b = field.subfields('b')
      field_d = field.subfields('d')
      field_f = field.subfields('f')
      field_p = field.subfields('p')
      field_n = field.subfields('n')
                           
      s = ""
      s = merge(s, field_b.value, delimiter: ': ')
      s = merge(s, field_d.value, delimiter: ': ')
      s = merge(s, field_f.value, delimiter: ' ')
     

      # Cleanup
      s = s.gsub(/^\- /, '') # Z.b. "- Index: Foo Bar"
      s = s.gsub(/\\[0-9][0-9][0-9][0-9]/, '')

      s = nil if field_p.present? 
      s = nil if field_n.value == 'kA'
        
            # Sort
      #position = nil
      #if field_b.present?
       # position = ((field_b.value || "").match(/^(\d+)$/) && $1.to_i) || nil
      #end

      #if position && position.is_a?(Fixnum)
      #  r[position] = s
      #else
        r << s
      #end
    end

    r.map(&:presence).compact.uniq
  end
end
