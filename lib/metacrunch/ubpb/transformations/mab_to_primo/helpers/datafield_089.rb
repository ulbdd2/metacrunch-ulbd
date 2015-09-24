require_relative "../helpers"

# 089 (Bandbezeichnung und -zählung)
#
# For RAK, there is only subfield a, which may occur multiple times. For RDA,
# there are subfields n and p, which have to be matched in a correct way if
# 089 occurs multple times. Therefor and because 089 is used quite often, to
# avoid code duplicationa, a helper is usefull.
#
# It is implicitly expected that 'source' is available to be called.
module Metacrunch::UBPB::Transformations::MabToPrimo::Helpers::Datafield089
  def datafield_089(options = {})
    options[:ind2] ||= [:blank, "1"]

    values =
    source.datafields("089", options).map do |_datafield| # also there should only be one 089
      # RAK
      bandangabe_in_vorlageform = _datafield.subfields("a").values
      .presence
      .try(:join, " ")
      .try(:gsub, /\A(\d{1,3})\Z/, "Bd. \\1") # Decimals with more than 3 digits are no volume counts

      # RDA
      bandzählungen = _datafield.subfields("n").values
      .map do |_bandzählung|
        _bandzählung.gsub(/\A(\d{1,3})\Z/, "Bd. \\1")
      end

      bandbezeichnungen = _datafield.subfields("p").values

      bandzählungen.push(nil) while bandzählungen.length < bandbezeichnungen.length
      bandbezeichnungen.push(nil) while bandbezeichnungen.length < bandzählungen.length

      if bandangabe_in_vorlageform.present?
        bandangabe_in_vorlageform
      elsif bandzählungen.present? || bandbezeichnungen.present?
        bandzählungen.zip(bandbezeichnungen)
        .map { |_pair| _pair.compact.join(". ") }
        .join(" / ")
      end
    end
    .reject do |_bandangabe| # bogus bandangaben such as "[Buch]"
      ["buch"].include?(_bandangabe.downcase.gsub(/\[|\]/, ""))
    end

    Struct.new(:values) do
      def value
        self.values.presence.try(:join, " ")
      end
    end
    .new(values)
  end
end
