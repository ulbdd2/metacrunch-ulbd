require_relative "../helpers"

module Metacrunch::UBPB::Transformations::MabToPrimo::Helpers::CorporateBodyFromField
  def corporate_body_from_field(datafield)
    subfield_a = datafield.subfields('a').value # Körperschafts-/Kongressname/Geografikum ohne IDN-Verknüpfung (NW)
    subfield_b = datafield.subfields('b').value # Unterordnung
    subfield_c = datafield.subfields('c').value # Ort (NW)
    subfield_d = datafield.subfields('d').value # Datum (NW)
    subfield_e = datafield.subfields('e').value # Kongressname (NW)
    subfield_g = datafield.subfields('g').value # Name des Geografikums (NW)
    subfield_h = datafield.subfields('h').value # Zusatz
    subfield_k = datafield.subfields('k').value # Körperschaftsname (NW)
    subfield_n = datafield.subfields('n').value # Zählung (W)
    subfield_x = datafield.subfields('x').value # nachgeordneter Teil (W)
    subfield_z = datafield.subfields('x').value # geografische Unterteilung (W)

    if !subfield_a && subfield_b && !subfield_c && !subfield_e && !subfield_g && subfield_h && subfield_k && !subfield_x && !subfield_z
      "#{subfield_k} <#{subfield_h}> / #{subfield_b}"
    else
      [
        subfield_a,
        subfield_k,
        subfield_e,
        subfield_g,
        subfield_b ? "/ #{subfield_b}" : nil,
        "<#{[subfield_h, subfield_n, subfield_d, subfield_c, subfield_x, subfield_z].compact.join(', ').presence}>",
      ].compact.join(' ').try(:sub, '<>', '').try(:strip)
    end
  end
end
