require "metacrunch/ubpb/record/element/beilage"

describe Metacrunch::UBPB::Record::Element::Beilage do
  describe "#get" do
    let(:document) do
      Metacrunch::Mab2::Document.from_aleph_mab_xml xml_factory <<-xml.strip_heredoc
        <datafield tag="529" ind1="z" ind2="1">
          <subfield code="p">Supplement</subfield>
          <subfield code="n">2004-2010, Nr. 18</subfield>
          <subfield code="a">Dresdener Nachrichten</subfield>
        </datafield>
      xml
    end
    let(:element) { described_class.new(document.datafields.first) }

    subject { element.get }

    it { is_expected.to eq("Supplement 2004-2010, Nr. 18: Dresdener Nachrichten") }

    context "if \"sortierirrelevante Worte\" are present" do
      let(:document) do
        Metacrunch::Mab2::Document.from_aleph_mab_xml xml_factory <<-xml.strip_heredoc
          <datafield tag="529" ind1="z" ind2="2">
            <subfield code="p">1997 - 2005 Förderbeil.</subfield>
            <subfield code="a">&lt;&lt;Der&gt;&gt; Zettel</subfield>
            <subfield code="9">HT013041640</subfield>
          </datafield>
        xml
      end

      it { is_expected.to eq("1997 - 2005 Förderbeil.: Der Zettel") }
    end

    context "if \"Titel\" was given" do
      let(:document) do
        Metacrunch::Mab2::Document.from_aleph_mab_xml xml_factory <<-xml.strip_heredoc
          <datafield tag="529" ind1="z" ind2="2">
            <subfield code="p">1997 - 2005 Förderbeil.</subfield>
            <subfield code="a">&lt;&lt;Der&gt;&gt; Zettel</subfield>
            <subfield code="9">HT013041640</subfield>
          </datafield>
        xml
      end

      subject { element.get("Titel") }

      it { is_expected.to eq("Der Zettel") }

      context "if omit: \"sortierirrelevante Worte\" was given" do
        subject { element.get("Titel", omit: "sortierirrelevante Worte") }

        it { is_expected.to eq("Zettel")}
      end
    end
  end
end
