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
    document = Metacrunch::Mab2::Document.from_mab_xml(source)
    record = Metacrunch::ULBD::Record.new(document)
    options[:target] ||= {}

    super(record, options)
  end

  sequence [ 
    AddBarcode,
    AddId,
    AddRecordtype,
    AddSysNo,
    AddSublib,
    AddLocation,
    #AddStatus, diese Regel wird nicht gebraucht! (Jour Fixe 15.7.16)
    AddHtNumber,
    AddMaterialtyp,
    AddInhaltstyp,
    AddTitle,
    AddTitleOs,
    #AddTitleDisplay,
    #AddTitleSimple,  nur ergänzt als Test für TitleSort, Problem mit NSZ im EST
    AddTitleSort,
    #AddShortTitle,
    AddShortTitleDisplay,
    #AddShortTitleEst,
    #AddShortTitleSort,
    AddTitleSearch,
    AddCreatorContributorDisplay2,
    AddCreatorContributorDisplayOs,
    AddCreatorContributorLink2,
    AddCreatorContributorFacet,
    #AddCreatorContributorFacet,  // author_facet first used in vuFind 3.0
    AddCreatorContributorSearch,
    AddCreatorContributorSort,
    AddEdition,
    AddEditionOs,
    AddPublisherPlace,
    AddPublisher,
    AddPublisherOs,
    AddCreationdate,
    AddCreationdateOs,
    AddCreationdateSearch,
    #AddCreationdateSimple,
    AddCreationdateSort,
    AddFormat,
    AddIsPartOf,
    AddIsPartOfNo,
    AddIsbn,
    AddIssn,
    AddZdbId,
    AddSubject,
    AddSubjectExtra,
    AddSubjectSearch,
    #AddDDC,
    AddAbstract,
    AddLanguage,
    AddRelation,
    AddRelationLink,
    AddSuperorderDisplay,
    AddSuperorderDisplayOs,
    AddSuperorder,
    AddIsSuperorder,
    AddIsSuborder,
    AddErscheinungsform,
    AddDescription,
    AddDescriptionOs,
    #AddDescription, # <- Not Multivalue 
    AddProvenienz,
    AddFingerprint,
    AddDeliveryCategory,
    AddVolumeCountSort,
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
    AddPlk,
    AddPlkIpo,
    AddIsSecondaryForm,
    AddSecondaryFormPreliminaryPhrase,
    AddSecondaryFormPublisher,
    AddSecondaryFormCreationdate,
    AddSecondaryFormIsbn,
    AddSecondaryFormPhysicalDescription,
    AddSecondaryFormSuperorder,
    AddLocalComment,
    AddAdditionalData,
    AddInventarisierungsdatum,
  ]
end
