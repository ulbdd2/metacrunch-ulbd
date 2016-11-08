require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_vufind"

class Metacrunch::ULBD::Transformations::MabToVufind::AddCreatorContributorSort < Metacrunch::Transformator::Transformation::Step
 # include parent::Helpers::IsSuperorder

  def call
    target ? Metacrunch::Hash.add(target, "authorSort", creatorcontributorsort) : creatorcontributorsort
  end

  private

  def creatorcontributorsort
    #erster_geistiger_schoepfer  = source.datafields('100', ind1: '-', ind2: '1').subfields(['a', 'p']).value
    #erste_koerperschaft = source.datafields('200', ind1: '-', ind2: '1').subfields(['a', 'k']).value
    erste_koerperschaft         = source.datafields('200', ind1: '-', ind2: '1').subfields(['a','k','e','g','n','h','d','c']).values.flatten.join(', ')
    erster_geistiger_schoepfer  = source.datafields('100', ind1: '-', ind2: '1').subfields(['a','p','n','c']).values.flatten.join(', ')
    erste_koerperschaft_super         = source.datafields('200', ind1: '-', ind2: '2').subfields(['a','k','e','g','n','h','d','c']).values.flatten.join(', ')
    erster_geistiger_schoepfer_super  = source.datafields('100', ind1: '-', ind2: '2').subfields(['a','p','n','c']).values.flatten.join(', ')
    sonstige_koerperschaft      = source.datafields('200', ind1: 'b', ind2: '1').subfields(['a','k','e','g','n','h','d','c']).values.flatten.join(', ')
    erste_sonstige_person       = source.datafields('100', ind1: 'b', ind2: '1').subfields(['a','p','n','c']).values.flatten.join(', ')
    sonstige_koerperschaft_super      = source.datafields('200', ind1: 'b', ind2: '2').subfields(['a','k','e','g','n','h','d','c']).values.flatten.join(', ')
    erste_sonstige_person_super       = source.datafields('100', ind1: 'b', ind2: '2').subfields(['a','p','n','c']).values.flatten.join(', ')
    erste_sonstige_person_c     = source.datafields('100', ind1: 'c', ind2: '1').subfields(['a','p','n','c']).values.flatten.join(', ')
    erste_sonstige_person_e     = source.datafields('100', ind1: 'e', ind2: '1').subfields(['a','p','n','c']).values.flatten.join(', ')
    erste_sonstige_person_f     = source.datafields('100', ind1: 'f', ind2: '1').subfields(['a','p','n','c']).values.flatten.join(', ')
    
     
    
    ccs = erste_koerperschaft.presence || erster_geistiger_schoepfer.presence || erste_koerperschaft_super.presence || erster_geistiger_schoepfer_super.presence ||  sonstige_koerperschaft.presence || erste_sonstige_person.presence || sonstige_koerperschaft_super.presence || erste_sonstige_person_super.presence || erste_sonstige_person_c.presence || erste_sonstige_person_e.presence || erste_sonstige_person_f.presence
    
    if ccs.present?
    ccs.downcase  
    else nil
    end
    
  end
    
  end
  

