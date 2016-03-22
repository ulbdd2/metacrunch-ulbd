require "metacrunch/ubpb/record/element/andere_ausgabe"

describe Metacrunch::UBPB::Record::Element::AndereAusgabe do
  describe "#get" do
    let(:document) do
      Metacrunch::Mab2::Document.from_aleph_mab_xml xml_factory <<-xml.strip_heredoc
        <datafield tag="527" ind1="z" ind2="1">
          <subfield code="p">Übersetzung von</subfield>
          <subfield code="a">The photographic card deck of the elements / Theodore Gray</subfield>
        </datafield>
      xml
    end
    let(:element) { described_class.new(document.datafields.first) }

    subject { element.get }

    it { is_expected.to eq("Übersetzung von: The photographic card deck of the elements / Theodore Gray") }

    context "if datafield contains \"Bemerkung\"" do
      let(:document) do
        Metacrunch::Mab2::Document.from_aleph_mab_xml xml_factory <<-xml.strip_heredoc
          <datafield tag="527" ind1="z" ind2="1">
            <subfield code="p">Parallele Sprachausgabe</subfield>
            <subfield code="n">englisch</subfield>
            <subfield code="a">Annual report / Landesbank Berlin Holding</subfield>
          </datafield>
        xml
      end

      it { is_expected.to eq("Parallele Sprachausgabe englisch: Annual report / Landesbank Berlin Holding") } 
    end

    context "if \"sortierirrelevante Worte\" are present" do
      let(:document) do
        Metacrunch::Mab2::Document.from_aleph_mab_xml xml_factory <<-xml.strip_heredoc
          <datafield tag="527" ind1="-" ind2="1">
            <subfield code="p">Druckausg.</subfield>
            <subfield code="a">&lt;&lt;The&gt;&gt; trend management toolkit</subfield>
          </datafield>
        xml
      end

      it { is_expected.to eq("Druckausg.: The trend management toolkit") }
    end

    context "if \"Titel der in Beziehung stehenden Ressource\" was given" do
      let(:document) do
        Metacrunch::Mab2::Document.from_aleph_mab_xml xml_factory <<-xml.strip_heredoc
          <datafield tag="527" ind1="-" ind2="1">
            <subfield code="p">Druckausg.</subfield>
            <subfield code="a">&lt;&lt;The&gt;&gt; trend management toolkit</subfield>
          </datafield>
        xml
      end

      subject { element.get("Titel der in Beziehung stehenden Ressource") }

      it { is_expected.to eq("The trend management toolkit") }

      context "if omit: \"sortierirrelevante Worte\" was given" do
        subject { element.get("Titel der in Beziehung stehenden Ressource", omit: "sortierirrelevante Worte") }

        it { is_expected.to eq("trend management toolkit")}
      end
    end
  end
end
