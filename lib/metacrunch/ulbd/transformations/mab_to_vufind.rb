require "active_support"
require "active_support/core_ext"
require "metacrunch/mab2/document"
require "metacrunch/transformator/transformation"
require_relative "../transformations"
require_relative "../record"

class Metacrunch::ULBD::Transformations::MabToVufind < Metacrunch::Transformator::Transformation
  require_directory "#{File.dirname(__FILE__)}/mab_to_vufind"

  # @param [String] source repesenting a MAB document in Aleph MAB XML format
  # @param [Hash] options
  # @option options [Hash] :target
  #
  # @return [Hash] transformation result
  def call(source, options = {})
    document = Metacrunch::Mab2::Document.from_aleph_mab_xml(source)
    record = Metacrunch::ULBD::Record.new(document)
    options[:target] ||= {}

    super(record, options)
  end

  sequence [    
    AddId,
    AddRecordtype,
    AddSysNo,
    AddSublib,
    AddLocation,
    #AddStatus, diese Regel wird nicht gebraucht! (Jour Fixe 15.7.16)
    AddHtNumber,
    AddMaterialtyp,
    AddInhaltstyp,
    AddVolumeCount,
    AddVolumeSort,
    AddTitle,
    #AddTitleDisplay,
    AddTitleSort,
    #AddShortTitle,
    AddShortTitleDisplay,
    #AddShortTitleSort,
    #AddTitleSearch,
    AddCreatorContributorDisplay,
    #AddCreatorContributorFacet,  // author_facet first used in vuFind 3.0
    #AddCreatorContributorSearch, // => author_fuller: neccessary ?
    AddEdition,
    AddPublisher,
    AddCreationdate,
    AddCreationdateSearch,
    AddFormat,
    AddIsPartOf,
    AddIsbn,
    AddIssn,
    #AddZdbId,
    AddSubject,
    #AddSubjectSearch,
    #AddDDC,
    AddAbstract,
    AddLanguage,
    AddRelation,
    #AddSuperorderDisplay,
    #AddSuperorder,
    AddIsSuperorder,
    AddIsSuborder,
    AddErscheinungsform,
    #AddDescription, # <- Not Multivalue 
    AddDeliveryCategory,
    #AddVolumeCountSort,
    #AddVolumeCountSort2,
    AddNotation,
    #AddNotationSort,
    AddToc,
    AddSignature,
    AddSignatureSearch,
    AddResourceLink,
    AddLinkToToc,
    AddSelectionCode,
    AddLdsX,
    AddIsSecondaryForm,
    AddSecondaryFormPreliminaryPhrase,
    AddSecondaryFormPublisher,
    AddSecondaryFormCreationdate,
    AddSecondaryFormIsbn,
    AddSecondaryFormPhysicalDescription,
    AddSecondaryFormSuperorder,
    AddLocalComment,
    AddAdditionalData,
    AddSuperorderDisplayForSammlungSchmoll
  ]
end
