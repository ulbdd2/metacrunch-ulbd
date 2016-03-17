require "metacrunch/ubpb/record/element/unaufgegliederte_anmerkung"

describe Metacrunch::UBPB::Record::Element::UnaufgegliederteAnmerkung do
  describe "#get" do
    let(:document) do
      Metacrunch::Mab2::Document.from_aleph_mab_xml xml_factory <<-xml.strip_heredoc
        <datafield tag="501" ind1="-" ind2="1">
          <subfield code="a">Einige Ex ohne ISBN</subfield>
        </datafield>
      xml
    end
    let(:datafields) { document.datafields("501") }
    let(:unaufgegliederte_anmerkung) { described_class.new(datafields.first) }

    subject { unaufgegliederte_anmerkung.get }

    it { is_expected.to eq("Einige Ex ohne ISBN") }
  end
end
