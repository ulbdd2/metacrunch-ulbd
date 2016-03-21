require "metacrunch/ubpb/record/collection/bevorzugte_titel_des_werkes"

describe Metacrunch::UBPB::Record::Collection::ISBNs do
  let(:document) do
    Metacrunch::Mab2::Document.from_aleph_mab_xml xml_factory <<-xml.strip_heredoc
      <datafield tag="540" ind1="-" ind2="1">
        <subfield code="a">9781610691191</subfield>
      </datafield>
      <datafield tag="540" ind1="a" ind2="1">
        <subfield code="a">9781610691192</subfield>
      </datafield>
      <datafield tag="540" ind1="b" ind2="1">
        <subfield code="a">9781610691193</subfield>
      </datafield>
      <datafield tag="540" ind1="z" ind2="1">
        <subfield code="b">Gewebe : Rbl 10.50</subfield>
      </datafield>
    xml
  end

  let(:datafields) { document.datafields }

  describe "#new" do
    let(:collection) { described_class.new(datafields) }

    describe "#count" do
      subject { collection.count }
      it { is_expected.to eq(1) }
    end

    context "if include: \"formal falsch\" was given" do
      let(:collection) { described_class.new(datafields, include: ["formal falsch"]) }

      describe "#count" do
        subject { collection.count }
        it { is_expected.to eq(2) }
      end

      context "if include: \"formal nicht geprüft\" was given" do
        let(:collection) { described_class.new(datafields, include: ["formal nicht geprüft"]) }

        describe "#count" do
          subject { collection.count }
          it { is_expected.to eq(2) }
        end
      end
    end

    context "if include: [\"formal falsch\", \"formal nicht geprüft\"] was given" do
      let(:collection) { described_class.new(datafields, include: ["formal falsch", "formal nicht geprüft"]) }

      describe "#count" do
        subject { collection.count }
        it { is_expected.to eq(3) }
      end
    end
  end
end
