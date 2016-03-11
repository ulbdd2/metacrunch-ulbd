require "metacrunch/ubpb/record/collection/personen"

describe Metacrunch::UBPB::Record::Collection::Personen do
  let(:document) do
    Metacrunch::Mab2::Document.from_aleph_mab_xml xml_factory <<-xml.strip_heredoc
      <datafield tag="100" ind1="b" ind2="1">
        <subfield code="p">Wegner, Jochen</subfield>
        <subfield code="d">1969-</subfield>
        <subfield code="9">(DE-588)1077760159</subfield>
        <subfield code="4">edt</subfield>
        <subfield code="3">Herausgeber</subfield>
      </datafield>
      <datafield tag="104" ind1="b" ind2="1">
        <subfield code="p">Alama, Stanley</subfield>
        <subfield code="9">(DE-588)140086846</subfield>
        <subfield code="b">[Hrsg.]</subfield>
      </datafield>
      <datafield tag="100" ind1="b" ind2="2">
        <subfield code="p">Alexius</subfield>
        <subfield code="n">I.</subfield>
        <subfield code="c">Imperium Byzantinum, Imperator</subfield>
        <subfield code="d">1041-1118</subfield>
        <subfield code="9">(DE-588)173144152</subfield>
        <subfield code="b">[Angebl. Verf.]</subfield>
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
