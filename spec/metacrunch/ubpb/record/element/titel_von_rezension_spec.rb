require "metacrunch/ubpb/record/element/titel_von_rezension"

describe Metacrunch::UBPB::Record::Element::TitelVonRezension do
  describe "#get" do
    let(:document) do
      Metacrunch::Mab2::Document.from_aleph_mab_xml xml_factory <<-xml.strip_heredoc
        <datafield tag="528" ind1="z" ind2="1">
          <subfield code="p">Rezension siehe</subfield>
          <subfield code="a">Becker-Willhardt, Hannelore: Thomas Mann und die Italiener</subfield>
          <subfield code="9">HT016029253</subfield>
        </datafield>
      xml
    end
    let(:element) { described_class.new(document.datafields.first) }

    subject { element.get }

    it { is_expected.to eq("Rezension siehe Becker-Willhardt, Hannelore: Thomas Mann und die Italiener") }
  end
end
