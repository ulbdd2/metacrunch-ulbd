require "metacrunch/hash"
require "metacrunch/transformator/transformation/step"
require_relative "../mab_to_vufind"

class Metacrunch::ULBD::Transformations::MabToVufind::AddShortTitleEst < Metacrunch::Transformator::Transformation::Step

  def call
    target ? Metacrunch::Hash.add(target, "title_est_txtP", short_title_est) : short_title_est
  end

  private

  def short_title_est
    einheitssachtitel                             = source.datafields('304', ind2: '1').subfields('a').value
    werktitel                                     = source.datafields('303', ind1: '-', ind2: '1').subfields(['t', 'h', 'm', 'n', 'o', 'u', 'r', 's', 'x', 'v', 'z', 'f']).values.join(". ")
    
    est = einheitssachtitel || werktitel
    
    if est.present?
      est.gsub(/<<|>>/, '')
    else nil
    end
    
   #if einheitssachtitel.present?
   #   einheitssachtitel.gsub(/<<|>>/, '')
   #elsif werktitel.present?
   #  werktitel.gsub(/<<|>>/, '')
   end
   
  end
#end
