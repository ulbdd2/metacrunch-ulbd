require "metacrunch/ubpb/record/element/titel_von_rezensiertem_werk"

describe Metacrunch::UBPB::Record::Element::TitelVonRezensiertemWerk do
  describe "#get" do
    let(:document) do
      Metacrunch::Mab2::Document.from_aleph_mab_xml xml_factory <<-xml.strip_heredoc
        <datafield tag="526" ind1="z" ind2="1">
          <subfield code="p">Rezension von</subfield>
          <subfield code="a">Gegenbaur, Carl: Lehrbuch der Anatomie des Menschen</subfield>
          <subfield code="9">HT008761118</subfield>
        </datafield>
      xml
    end
    let(:element) { described_class.new(document.datafields.first) }

    subject { element.get }

    it { is_expected.to eq("Rezension von Gegenbaur, Carl: Lehrbuch der Anatomie des Menschen") }
  end
end
