require "metacrunch/ubpb/record/collection/unaufgegliederte_anmerkungen"

describe Metacrunch::UBPB::Record::Collection::UnaufgegliederteAnmerkungen do
  let(:document) do
    Metacrunch::Mab2::Document.from_aleph_mab_xml xml_factory <<-xml.strip_heredoc
      <datafield tag="501" ind1="-" ind2="1">
        <subfield code="a">BuchPlusWeb</subfield>
      </datafield>
      <datafield tag="501" ind1="-" ind2="2">
        <subfield code="a">Zusätzliches Online-Angebot unter www.bildungsverlag1.de</subfield>
      </datafield>
    xml
  end

  describe "#new" do
    let(:collection) { described_class.new(document) }

    describe "#count" do
      subject { collection.count }
      it { is_expected.to eq(1) }
    end

    context "if include: \"Überordnungen\" was given" do
      let(:collection) { described_class.new(document, include: "Überordnungen") }

      describe "#count" do
        subject { collection.count }
        it { is_expected.to eq(2) }
      end
    end
  end
end
