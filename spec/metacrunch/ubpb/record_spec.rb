require "metacrunch/ubpb/record"

describe Metacrunch::UBPB::Record do
  let(:document) { Metacrunch::Mab2::Document.new }
  let(:record) { described_class.new(document) }

  describe "#get" do
    context "if \"Bevorzugte Titel des Werkes\" was given" do
      let(:document) do
        Metacrunch::Mab2::Document.from_aleph_mab_xml xml_factory <<-xml.strip_heredoc
          <datafield tag="303" ind1="-" ind2="1">
            <subfield code="t">Werktitel</subfield>
          </datafield>
        xml
      end

      subject { record.get("Bevorzugte Titel des Werkes") }

      it { is_expected.to be_present }
    end

    context "if \"Körperschaften\" was given" do
      let(:document) do
        Metacrunch::Mab2::Document.from_aleph_mab_xml xml_factory <<-xml.strip_heredoc
          <datafield tag="200" ind1="-" ind2="1">
            <subfield code="k">Evangelische Auferstehungs-Kirchengemeinde</subfield>
          </datafield>
        xml
      end

      subject { record.get("Körperschaften") }

      it { is_expected.to be_present }
    end

    context "if \"Körperschaften Phrasenindex\" was given" do
      let(:document) do
        Metacrunch::Mab2::Document.from_aleph_mab_xml xml_factory <<-xml.strip_heredoc
          <datafield tag="PKO" ind1="-" ind2="1">
            <subfield code="k">Universität</subfield>
          </datafield>
        xml
      end

      subject { record.get("Körperschaften Phrasenindex") }

      it { is_expected.to be_present }
    end

    context "if \"Personen\" was given" do
      let(:document) do
        Metacrunch::Mab2::Document.from_aleph_mab_xml xml_factory <<-xml.strip_heredoc
          <datafield tag="100" ind1="b" ind2="1">
            <subfield code="a">Wegner, Jochen</subfield>
          </datafield>
        xml
      end

      subject { record.get("Personen") }

      it { is_expected.to be_present }
    end

    context "if \"Personen der Nebeneintragungen\" was given" do
      let(:document) do
        Metacrunch::Mab2::Document.from_aleph_mab_xml xml_factory <<-xml.strip_heredoc
          <datafield tag="800" ind1="-" ind2="1">
            <subfield code="p">Pius</subfield>
          </datafield>
        xml
      end

      subject { record.get("Personen der Nebeneintragungen") }

      it { is_expected.to be_present }
    end

    context "if \"Personen Phrasenindex\" was given" do
      let(:document) do
        Metacrunch::Mab2::Document.from_aleph_mab_xml xml_factory <<-xml.strip_heredoc
          <datafield tag="PPE" ind1="-" ind2="1">
            <subfield code="p">Murmellius, Iohannes</subfield>
          </datafield>
        xml
      end

      subject { record.get("Personen Phrasenindex") }

      it { is_expected.to be_present }
    end

    context "if \"Unaufgegliederte Anmerkungen\" was given" do
      let(:document) do
        Metacrunch::Mab2::Document.from_aleph_mab_xml xml_factory <<-xml.strip_heredoc
          <datafield tag="501" ind1="-" ind2="1">
            <subfield code="a">Einige Ex ohne ISBN</subfield>
          </datafield>
        xml
      end

      subject { record.get("Unaufgegliederte Anmerkungen") }

      it { is_expected.to be_present }
    end
  end
end
