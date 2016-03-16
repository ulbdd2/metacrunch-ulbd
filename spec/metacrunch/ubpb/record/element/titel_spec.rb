require "metacrunch/ubpb/record/element/titel"

describe Metacrunch::UBPB::Record::Element::Titel do
  describe "#get" do
    let(:document) do
      Metacrunch::Mab2::Document.from_aleph_mab_xml xml_factory <<-xml.strip_heredoc
        <datafield tag="303" ind1="-" ind2="1">
          <subfield code="p">Schumann, Robert</subfield>
          <subfield code="d">1810-1856</subfield>
          <subfield code="t">Dichterliebe</subfield>
          <subfield code="u">Ich grolle nicht</subfield>
          <subfield code="9">(DE-588)300144598</subfield>
        </datafield>
        <datafield tag="303" ind1="-" ind2="2">
          <subfield code="p">Schumann, Robert</subfield>
          <subfield code="d">1810-1856</subfield>
          <subfield code="t">Dichterliebe</subfield>
          <subfield code="9">(DE-588)300144571</subfield>
        </datafield>
      xml
    end
    let(:datafields) { document.datafields("303", ind2: "1") }
    let(:superorders) { document.datafields("303", ind2: "2") }
    let(:titel) { described_class.new(datafields.first, superorders: superorders) }

    it "foo" do
      binding.pry
    end
  end
end
