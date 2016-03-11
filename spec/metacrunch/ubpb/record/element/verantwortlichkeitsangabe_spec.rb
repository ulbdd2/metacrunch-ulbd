require "metacrunch/ubpb/record/element/verantwortlichkeitsangabe"

describe Metacrunch::UBPB::Record::Element::Verantwortlichkeitsangabe do
  describe "#get" do
    let(:document) do
      Metacrunch::Mab2::Document.from_aleph_mab_xml xml_factory <<-xml.strip_heredoc
        <datafield tag="359" ind1="-" ind2="1">
          <subfield code="a">bearb. von Kurt-Ulrich Jäschke und Peter Thorau</subfield>
        </datafield>
      xml
    end
    let(:datafields) { document.datafields("359") }
    let(:verantwortlichkeitsangabe) { described_class.new(datafields.first) }

    subject { verantwortlichkeitsangabe.get }

    it { is_expected.to eq("bearb. von Kurt-Ulrich Jäschke und Peter Thorau") }
  end
end
