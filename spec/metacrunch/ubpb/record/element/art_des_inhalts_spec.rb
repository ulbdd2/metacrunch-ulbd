require "metacrunch/ubpb/record/element/art_des_inhalts"

describe Metacrunch::UBPB::Record::Element::ArtDesInhalts do
  describe "#get" do
    let(:document) do
      Metacrunch::Mab2::Document.from_aleph_mab_xml xml_factory <<-xml.strip_heredoc
        <datafield tag="064" ind1="a" ind2="1">
          <subfield code="a">Zeitschrift</subfield>
          <subfield code="9">(DE-588)4067488-5</subfield>
        </datafield>
      xml
    end
    let(:element) { described_class.new(document.datafields.first) }

    subject { element.get }

    it { is_expected.to eq("Zeitschrift") }
  end
end
