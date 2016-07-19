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
    #AddStatus !,
    AddHtNumber,
    AddCreationDate,
    #AddMaterialtyp !new,
    #AddInhaltstyp new,
    AddVolumeCount,
    #AddVolumeSort ???,
    AddTitle,
    #AddTitleDisplay new,
    AddTitleSort,
    AddShortTitle,
    #AddShortTitleDisplay new,
    #AddShortTitleSort new,
    #AddTitleSearch new,
    AddCreatorContributorDisplay,
    #AddCreatorContributorFacet new ,  // author_facet first used in vuFind 3.0
    #AddCreatorContributorSearch new, // => author_fuller: neccessary ?
    AddEdition,
    AddPublisher,
    AddCreationdate,
    #AddCreationdateSearch new,
    AddFormat,
    #AddIsPartOf new,
    AddIsbn,
    AddIssn,
    #AddZdbId new,
    AddSubject,
    #AddSubjectSearch new,
    #AddDDC,
    #AddAbstract new,
    AddLanguage,
    #AddRelation new,
    #AddSuperorderDisplay new,
    #AddSuperorder new,
    #AddIsSuperorder new,
    #AddIsSubordernew,
    AddErscheinungsform,
    #AddDescription new,  <- Not Multivalue 
    #AddDeliveryCategory new,
    #AddVolumeCountSort new,
    #AddVolumeCountSort2 new,
    AddNotation,
    AddNotationSort,
    AddToc,
    AddSignature,
    AddSignatureSearch,
    #AddResourceLink new,
    #AddLinkToToc new,
    #AddSelectionCode new,
    AddLdsX,
    #AddIsSecondaryForm new,
    #AddSecondaryFormPreliminaryPhrase new,
    #AddSecondaryFormPublisher new,
    #AddSecondaryFormCreationdate new,
    AddSecondaryFormIsbn,
    #AddSecondaryFormPhysicalDescription new,
    #AddSecondaryFormSuperorder new,
    #AddLocalComment,
    #AddAdditionalData,
    #AddSuperorderDisplayForSammlungSchmoll
  ]
end
