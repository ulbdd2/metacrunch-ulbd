require "metacrunch/ubpb/record/collection/körperschaften"

describe Metacrunch::UBPB::Record::Collection::Körperschaften do
  let(:document) do
    Metacrunch::Mab2::Document.from_aleph_mab_xml xml_factory <<-xml.strip_heredoc
      <datafield tag="200" ind1="-" ind2="1">
        <subfield code="k">Evangelische Auferstehungs-Kirchengemeinde</subfield>
        <subfield code="h">Völklingen</subfield>
        <subfield code="b">Evangelische Jugendtheater-AG</subfield>
        <subfield code="h">Wehrden-Geislautern</subfield>
        <subfield code="9">(DE-588)16014053-5</subfield>
      </datafield>
      <datafield tag="204" ind1="b" ind2="1">
        <subfield code="k">Deutscher Anwaltverein</subfield>
        <subfield code="b">Arbeitsgemeinschaft IT-Recht</subfield>
        <subfield code="9">(DE-588)1067272690</subfield>
        <subfield code="4">isb</subfield>
        <subfield code="3">Herausgebendes Organ</subfield>
      </datafield>
      <datafield tag="208" ind1="b" ind2="2">
        <subfield code="k">Centre de Recherches Mathématiques</subfield>
        <subfield code="9">(DE-588)1020069-1</subfield>
        <subfield code="4">isb</subfield>
        <subfield code="3">Herausgebendes Organ</subfield>
        <subfield code="4">orm</subfield>
        <subfield code="3">Veranstalter</subfield>
      </datafield>
    xml
  end

  describe "#new" do
    describe "result" do
      subject { described_class.new(document) }
      it { is_expected.to be_a(Metacrunch::UBPB::Record::Collection) }
    end

    describe "#count" do
      subject { described_class.new(document).count }
      it { is_expected.to eq(2) }
    end

    context "if the given document does not contain the needed datafields" do
      let(:document) { Metacrunch::Mab2::Document.new }
      subject { described_class.new(document) }

      it { is_expected.to be_empty }

      describe "#count" do
        subject { described_class.new(document).count }
        it { is_expected.to eq(0) }
      end
    end

    context "if superorders should be included"  do
      describe "#count" do
        subject { described_class.new(document, include: "Überordnungen").count }
        it { is_expected.to eq(3) }
      end
    end
  end
end
