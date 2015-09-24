require "mighty_hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_primo"

class Metacrunch::UBPB::Transformations::MabToPrimo::AddAdditionalData < Metacrunch::Transformator::Transformation::Step
  def call
    target ? MightyHash.add(target, "additional_data", additional_data) : additional_data
  end

  private

  def additional_data
    additional_data = {
      author_statement:                   [author_statement].flatten(1).compact.presence,
      corporate_body_contributor_display: [corporate_body_contributor_display].flatten(1).compact.presence,
      corporate_body_creator_display:     [corporate_body_creator_display].flatten(1).compact.presence,
      local_comment:                      [local_comment].flatten(1).compact.presence,
      person_contributor_display:         [person_contributor_display].flatten(1).compact.presence,
      person_creator_display:             [person_creator_display].flatten(1).compact.presence,
      redactional_remark:                 redactional_remark

    }
    .inject({}) { |hash, (key, value)| hash[key] = value if value.present?; hash }

    additional_data.to_json if additional_data.present?
  end

  private

  def author_statement
    target.try(:[], "author_statement") || self.class.parent::AddAuthorStatement.new(source: source).call
  end

  def corporate_body_contributor_display
    target.try(:[], "corporate_body_contributor_display") || self.class.parent::AddCorporateBodyContributorDisplay.new(source: source).call
  end

  def corporate_body_creator_display
    target.try(:[], "corporate_body_creator_display") || self.class.parent::AddCorporateBodyCreatorDisplay.new(source: source).call
  end

  def local_comment
    target.try(:[], "local_comment") || self.class.parent::AddLocalComment.new(source: source).call
  end

  def person_contributor_display
    target.try(:[], "person_contributor_display") || self.class.parent::AddPersonContributorDisplay.new(source: source).call
  end

  def person_creator_display
    target.try(:[], "person_creator_display") || self.class.parent::AddPersonCreatorDisplay.new(source: source).call
  end

  def redactional_remark
    target.try(:[], "redactional_remark") || self.class.parent::AddRedactionalRemark.new(source: source).call
  end
end
