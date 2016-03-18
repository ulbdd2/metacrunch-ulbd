require "metacrunch/ubpb/record/collection/bevorzugte_titel_des_werkes"

describe Metacrunch::UBPB::Record::Collection::BevorzugteTitelDesWerkes do
=begin
  let(:document) do
    Metacrunch::Mab2::Document.from_aleph_mab_xml xml_factory <<-xml.strip_heredoc
      <datafield tag="303" ind1="-" ind2="1">
        <subfield code="p">Scholz, Stephani</subfield>
        <subfield code="t">Werktitel</subfield>
        <subfield code="h">Zusatz</subfield>
        <subfield code="o">Musikarrangemang</subfield>
        <subfield code="s">neueste Version</subfield>
        <subfield code="h">Zusatz</subfield>
      </datafield>
      <datafield tag="303" ind1="t" ind2="1">
        <subfield code="t">Werktitel ALLE neuen RDA-Felder</subfield>
        <subfield code="m">volle Besetzung</subfield>
        <subfield code="r">Tonart laut</subfield>
      </datafield>
      <datafield tag="303" ind1="-" ind2="2">
        <subfield code="t">Werktitel ALLE neuen RDA-Felder</subfield>
        <subfield code="m">volle Besetzung</subfield>
        <subfield code="r">Tonart laut</subfield>
      </datafield>
      <datafield tag="303" ind1="t" ind2="2">
        <subfield code="t">Werktitel ALLE neuen RDA-Felder</subfield>
        <subfield code="m">volle Besetzung</subfield>
        <subfield code="r">Tonart laut</subfield>
      </datafield>
    xml
  end

  describe "#new" do
    let(:collection) { described_class.new(document) }

    describe "#count" do
      subject { collection.count }
      it { is_expected.to eq(1) }
    end

    context "if include: \"in Beziehung stehende Werke\" was given" do
      let(:collection) { described_class.new(document, include: "in Beziehung stehende Werke") }

      describe "#count" do
        subject { collection.count }
        it { is_expected.to eq(2) }
      end

      context "if include: \"Überordnungen\" was given" do
        let(:collection) { described_class.new(document, include: ["in Beziehung stehende Werke", "Überordnungen"]) }

        describe "#count" do
          subject { collection.count }
          it { is_expected.to eq(4) }
        end
      end
    end

    context "if include: \"in der Manifestation verkörperte Werke\" was given" do
      let(:collection) { described_class.new(document, include: "in der Manifestation verkörperte Werke") }

      describe "#count" do
        subject { collection.count }
        it { is_expected.to eq(2) }
      end

      context "if include: \"Überordnungen\" was given" do
        let(:collection) { described_class.new(document, include: ["in der Manifestation verkörperte Werke", "Überordnungen"]) }

        describe "#count" do
          subject { collection.count }
          it { is_expected.to eq(4) }
        end
      end
    end

    context "if include: \"Überordnungen\" was given" do
      let(:collection) { described_class.new(document, include: "Überordnungen") }

      describe "#count" do
        subject { collection.count }
        it { is_expected.to eq(2) }
      end
    end
  end
=end
end
