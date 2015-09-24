require_relative "../helpers"

module Metacrunch::UBPB::Transformations::MabToPrimo::Helpers::IsSuperorder
  def is_superorder?(_source = source)
    f051 = _source.controlfield("051") || []
    f052 = _source.controlfield("052") || []

    f051.at(0) == "n" ||
    f051.at(0) == "t" ||
    f052.at(0) == "p" ||
    f052.at(0) == "r" ||
    f052.at(0) == "z"
  end
end
