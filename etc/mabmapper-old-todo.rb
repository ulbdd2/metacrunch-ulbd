# coding: utf-8
module Mabmapper
  class AlephMabXmlEngine < Engine

    document_class MabXml::Document


    #
    # creator
    #
    field :person_creator_display do
      creators = []

      # Personen
      (100..196).step(4) do |f|
        doc.field("#{f}", ind1: ['-', 'a'], ind2: ['1', '2']).get.fields.each do |field|
          creators << (field.get_subfield('a').try(:value) || field.get_subfield('p').try(:value) || field.get_subfield('c').try(:value))
        end
      end

      creators.map(&:presence).compact.uniq
    end

    def self.corporate_body_from_field(field)
      subfield_a = field.get_subfield('a').try(:value) # Körperschafts-/Kongressname/Geografikum ohne IDN-Verknüpfung (NW)
      subfield_b = field.get_subfield('b').try(:value) # Unterordnung
      subfield_c = field.get_subfield('c').try(:value) # Ort (NW)
      subfield_d = field.get_subfield('d').try(:value) # Datum (NW)
      subfield_e = field.get_subfield('e').try(:value) # Kongressname (NW)
      subfield_g = field.get_subfield('g').try(:value) # Name des Geografikums (NW)
      subfield_h = field.get_subfield('h').try(:value) # Zusatz
      subfield_k = field.get_subfield('k').try(:value) # Körperschaftsname (NW)
      subfield_n = field.get_subfield('n').try(:value) # Zählung (W)
      subfield_x = field.get_subfield('x').try(:value) # nachgeordneter Teil (W)
      subfield_z = field.get_subfield('x').try(:value) # geografische Unterteilung (W)

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

    field :corporate_body_creator_display do
      creators = []

      # Körpferschaften
      (200..296).step(4) do |f|
        doc.field("#{f}", ind1: ['-', 'a'], ind2: ['1', '2']).get.fields.each do |field|
          creators << engine.corporate_body_from_field(field)
        end
      end

      creators.map(&:presence).compact.uniq
    end

    field :author_statement do
      f359_1 = doc.field('359', ind1:"-", ind2:'1').subfield('a').get.values.flatten.presence
      f359_2 = doc.field('359', ind1:"-", ind2:'2').subfield('a').get.values.flatten.presence
      f359_1 || f359_2
    end

    #
    # contributor
    #
    field :person_contributor_display do
      contributors = []

      # Personen
      (100..196).step(4) do |f|
        doc.field("#{f}", ind1: ['b', 'c', 'e', 'f'], ind2: ['1', '2']).get.fields.each do |field|
          name = (field.get_subfield('a').try(:value) || field.get_subfield('p').try(:value) || field.get_subfield('c').try(:value))
          action_designator = field.get_subfield('b').try(:value)
          contributors << [name, action_designator].map(&:presence).compact.join(' ')
        end
      end

      contributors.map(&:presence).compact.uniq
    end

    field :corporate_body_contributor_display do
      contributors = []

      # Körpferschaften
      (200..296).step(4) do |f|
        doc.field("#{f}", ind1: ['b', 'c', 'e', 'f'], ind2: ['1', '2']).get.fields.each do |field|
          contributors << engine.corporate_body_from_field(field)
        end
      end

      contributors.map(&:presence).compact.uniq
    end

    field :creator_contributor_display do
      creators = []

      # Personen
      (100..196).step(4) do |f|
        creators << doc.field("#{f}", ind2: ['1', '2']).subfield(['a','p','c','n','b']).get.value
      end

      # Körperschaften
      (200..296).step(4) do |f|
        creators << doc.field("#{f}", ind2: ['1', '2']).subfield(['a','k','b','e','c','n','g','h']).get.value
      end

      # Sonderfall: Verfasserangaben aus 359 -> [u.a.]
      t = doc.field("359", ind2: '1').subfield('a').get.value.presence
      creators << '[u.a.]' if t && t.match(/\.\.\.|\[u\.a\.\]/i)

      # Cleanup
      creators = creators.flatten.compact
      creators = creators.map{ |c| c.delete('<').delete('>') }
      creators = creators.map(&:presence).compact.uniq
    end

    #
    # Creators and contributors without roles for faceting
    #
    field :creator_contributor_facet do
      if (creator_contributor_display = ref(:creator_contributor_display)).present?
        creator_contributor_display.map { |creator_contributor| creator_contributor.gsub(/\[.*\]/, '').strip }
      end
    end

    #
    # Creators and contributors in extended normalized form without roles
    #
    field :creator_contributor_search do
      creators = []

      # Alle aus dem Display
      creators = creators + ref(:creator_contributor_display)
      # Entferne Sonderfall [u.a.]
      creators.reject!{|e| e == '[u.a.]'}

      # + Index Felder für Personen
      creators << doc.field('PPE').subfield(['a', 'p']).get.values

      # + zweiteilige Nebeneintragungen / beigefügte oder enthaltene Werke
      (800..824).step(6) do |f|
        creators << doc.field("#{f}").subfield(['a','p','c','n','b']).get.values
      end

      # + Index Felder für Körperschaften
      creators << doc.field('PKO').subfield(['a','k','b','e','g']).get.values

      # Füge alle Teile zusammen
      creators = creators.flatten.compact
      # Lösche Sortierzeichen
      creators = creators.map{ |c| c.delete('<').delete('>') }
      # Prüfe Inhalte auf Existenz und entferne doppelte Einträge
      creators = creators.map(&:presence).compact.uniq
    end


    #
    # Format
    #
    field :format do
      f433 = doc.field('433', ind2: '1').subfield('a').get.value
      f434 = doc.field('434', ind2: '1').subfield('a').get.values.join(', ')
      f435 = doc.field('435', ind2: '1').subfield('a').get.value
      f437 = doc.field('437', ind2: '1').subfield('a').get.value
      f653 = doc.field('653', ind2: '1').subfield('a').get.values.join(', ')

      format = f433
      format = merge(format, f434, delimiter: ' : ')
      format = merge(format, f435, delimiter: ' ; ')
      format = merge(format, f437, delimiter: ' + ')
      format = merge(format, f653, delimiter: '.- ')

      format.presence
    end

    #
    # Is part of
    #
    field :is_part_of do
      f525   = doc.field('525', ind2: '1').subfield(['p','a']).get.value(join_subfields: ': ')
      f590   = doc.field('590', ind2: '1').subfield('a').get.value
      f591   = doc.field('591', ind2: '1').subfield('a').get.value
      f592   = doc.field('592', ind2: '1').subfield('a').get.value
      f593   = doc.field('593', ind2: '1').subfield('a').get.value
      f594   = doc.field('594', ind2: '1').subfield('a').get.value
      f595   = doc.field('595', ind2: '1').subfield('a').get.value
      f596   = doc.field('596', ind2: '1').subfield('a').get.value
      f597   = doc.field('597', ind2: '1').subfield('a').get.value
      f598   = doc.field('598', ind2: '1').subfield('a').get.value

      #f599_1 = doc.datafield('599', ind1: 'a,b', ind2: '1', subfield: 'a', multiple: true).join(' ') # ISSN
      #f599_2 = doc.datafield('599', ind1: 'c,d', ind2: '1', subfield: 'a', multiple: true).join(' ') # ISBN
      #f599_3 = doc.datafield('599', ind1: 'e,f', ind2: '1', subfield: 'a', multiple: true).join(' ') # ISMN
      #f599_4 = doc.datafield('599', ind1: 'g,h', ind2: '1', subfield: 'a', multiple: true).join(' ') # ISRN

      ipo = f525
      ipo = merge(ipo, f590,   delimiter: '.- ', wrap: "In: @" )
      ipo = merge(ipo, f591,   delimiter: ' / '                )
      ipo = merge(ipo, f592,   delimiter: '. '                 )
      ipo = merge(ipo, f593,   delimiter: '.- '                )
      ipo = merge(ipo, f594,   delimiter: '.- '                )
      ipo = merge(ipo, f595,   delimiter: ', '                 )
      ipo = merge(ipo, f596,   delimiter: '.- '                )
      ipo = merge(ipo, f597,   delimiter: '.- ', wrap: "(@)"   )
      ipo = merge(ipo, f598,   delimiter: '.- '                )

      #ipo = merge(ipo, f599_1, delimiter: '.- ', wrap: "ISSN @")
      #ipo = merge(ipo, f599_2, delimiter: '.- ', wrap: "ISSN @")
      #ipo = merge(ipo, f599_3, delimiter: '.- ', wrap: "ISMN @")
      #ipo = merge(ipo, f599_4, delimiter: '.- ', wrap: "ISRN @")

      ipo.presence
    end


    #
    # Relation
    #
    field :relation do
      relations = []

      if (f021a = doc.field('021').subfield('a').get.value).present?
        relations << {
          ht_number: f021a,
          label: 'Primärform'
        }
      end

      if (f022a = doc.field('022').subfield('a').get.value).present?
        relations << {
          ht_number: f022a,
          label: 'Sekundärform'
        }
      end

      (526..534).each do |mab_field_number|
        doc.field("#{mab_field_number}", ind2: '1').get.fields.each do |field|
          ht_number = field.get_subfield('9').try(:value).presence
          label = [
            field.get_subfield('p').try(:value).presence,
            field.get_subfield('a').try(:value).try(:gsub, /<<|>>/, '').presence
          ].compact.join(' ')

          relations << {ht_number: ht_number, label: label} if label
        end
      end

      relations.flatten.select { |relation| relation[:label].present? }.map(&:to_json)
    end

    #
    # Linked superorders (only ht_numbers) + ht_number if primary form (if any)
    #
    # @depends_on: superorder_display
    #
    field :superorder do
      superorders = []

      f623 = doc.field('623').get.value # Identifikationsnummer des 1. GT der Sekundärform
      f629 = doc.field('629').get.value # Identifikationsnummer des 2. GT der Sekundärform

      superorders << if (json_encoded_superorders_display = ref(:superorder_display)).present?
        superorders_display = json_encoded_superorders_display.map { |json_encoded_superorder_display| JSON.parse(json_encoded_superorder_display) }
        superorders_display.map { |superorder_display| superorder_display['ht_number'] }
      end

      superorders << f623 if f623.present?
      superorders << f629 if f629.present?

      superorders.flatten.map(&:presence).compact
    end

    #
    # Sind wir ein Band?
    #
    field :is_suborder do
      ref(:superorder_display).present? # we take superorder_display instead of superorder to exclude superorder relations between primary/secondare form from this indicator
    end


    #
    # Delivery Catagory
    #
    field :delivery_category do
      materialtyp      = ref(:materialtyp)
      erscheinungsform = ref(:erscheinungsform)

      if (materialtyp == 'online_resource')
        'electronic_resource'
      elsif (erscheinungsform == 'series' || erscheinungsform == 'journal')
        'structural_metadata'
      else
        'physical_item'
      end
    end



    # #
    # # Notation
    # #
    # field :notation do
    #   doc.field('700', ind2: ' ').subfield('a').get.values(join_subfields: '')
    # end

    # field :notation_sort do
    #   ref(:notation).try(:last)
    # end


    #
    # Bestandsinformationen Zeitschriften
    #
    field :ldsX do
      # Feld 200 mit ind1 = ' ', ind2 = ' '
      # Unterfelder:
      #   0 - Sortierindikator
      #   a - Einleitende Wendung
      #   b - Verlauf
      #   c - Lücke im Bestand / Verlauf
      #   e - Kommentar
      #   f - Signatur
      r = []

      fields = doc.field('200', ind2: ' ').subfield(['0', 'a', 'b', 'c', 'e', 'f']).get.fields
      fields.each do |field|
        field_0 = field.get_subfield('0')
        field_a = field.get_subfield('a')
        field_b = field.get_subfield('b')
        field_c = field.get_subfield('c')
        field_e = field.get_subfield('e')
        field_f = field.get_subfield('f')

        s = ""
        s = merge(s, field_a.try(:value), delimiter: ' ')
        s = merge(s, field_b.try(:value), delimiter: ': ')
        s = merge(s, field_c.try(:value), delimiter: ' ')
        s = merge(s, field_e.try(:value), delimiter: '. ')
        s = merge(s, field_f.try(:value), delimiter: ' <strong>Zeitschriftensignatur</strong>: ')

        # Cleanup
        s = s.gsub(/^\- /, '') # Z.b. "- Index: Foo Bar"

        # Sort
        position = nil
        if field_0.present?
          position = ((field_0.value || "").match(/^(\d+)$/) && $1.to_i) || nil
        end

        if position && position.is_a?(Fixnum)
          r[position] = s
        else
          r << s
        end
      end

      r.map(&:presence).compact.uniq
    end


    field :redactional_remark do
      doc.field("537", ind2: '1').subfield(['a', 'p']).get.values(join_subfields: ': ').presence.try(:join)
    end

    #
    # Sekundärformen
    #
    field :is_secondary_form do
      (doc.field('610').get.value || doc.field('611').get.value || doc.field('619').get.value || doc.field('621').get.value) != nil
    end

    field :secondary_form_preliminary_phrase do
      doc.field('610', ind1: '-', ind2: '1').get.value
    end

    field :secondary_form_publisher do
      (doc.field('611').get.value.to_s << ' : ' << doc.field('613').get.value.to_s).gsub(/\A : /, '').presence
    end

    field :secondary_form_creationdate do
      doc.field('619').get.value
    end

    field :secondary_form_isbn do
      doc.field('634').get.value
    end

    field :secondary_form_physical_description do
      doc.field('637').get.value
    end

    # there can at most be two of 'em
    field :secondary_form_superorder do
      [
        {
          ht_number: doc.field('623').get.value,
          label: doc.field('621').get.value,
          volume_count: doc.field('625').get.value
        },
        {
          ht_number: doc.field('629').get.value,
          label: doc.field('627').get.value,
          volume_count: doc.field('631').get.value
        }
      ].select { |superorder| superorder[:label].present? }.map(&:to_json).presence
    end

    field :local_comment do
      doc.field('125', ind1: ' ', ind2: ' ').subfield(['_', 'a']).get.fields.map(&:values).flatten.uniq.presence
    end

  end
end
