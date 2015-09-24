require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_primo"
require_relative "./add_subject"

class Metacrunch::UBPB::Transformations::MabToPrimo::AddSubjectSearch < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "subject_search", subject_search) : subject_search
  end

  private

  def subject_search
    subjects = []

    # Alles Display subjects
    subjects << subject

    # + Index Felder für weitere Schlagworte
    subjects << source.datafields('PSW').subfields(['a','k','e','g','s','p','t','f','z']).values

    subjects.flatten.map(&:presence).compact.map{|f| f.delete('<').delete('>')}.uniq
  end

  private

  def subject
    target.try(:[], "subject") || self.class.parent::AddSubject.new(source: source).call
  end
end
