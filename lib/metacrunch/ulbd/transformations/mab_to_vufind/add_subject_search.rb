require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_vufind"
require_relative "./add_subject"

class Metacrunch::ULBD::Transformations::MabToVufind::AddSubjectSearch < Metacrunch::Transformator::Transformation::Step
  def call
    target ? Metacrunch::Hash.add(target, "subject_search_txt_mv", subject_search) : subject_search
  end

  private

  def subject_search
    subjects = []

    # Alles Display subjects
    subjects << subject

    # + Index Felder für weitere Schlagworte
    subjects << source.datafields('PSW').subfields(['a','p','k','s','g','e','b','c','d','h','t','z','f']).values
    subjects << source.datafields('IDX').subfields(['a','p','k','s','g','e','b','c','d','h','t','z','f']).values

    subjects.flatten.map(&:presence).compact.map{|f| f.delete('<').delete('>')}.uniq
  end

  private

  def subject
    target.try(:[], "subject") || self.class.parent::AddSubject.new(source: source).call
  end
end
