module Metacrunch
  module UBPB
    module Transformations
      module MAB2SNR
        class CMC < Metacrunch::Transformer::Step

          def perform
            target.add("control", "cmc", cmc)
          end

        private

          def cmc
            { content: content, media: media, carrier: carrier }
          end

          def content
            nil
          end

          def media
            nil
          end

          def carrier
            f050 = source.controlfield("050").values
            p0   = f050[0]
            p1   = f050[1]
            p3   = f050[3]
            p4   = f050[4]
            p56  = f050.slice(5..6).join
            p7   = f050[7]
            p8   = f050[8]
            p9   = f050[9]
            p10  = f050[10]

            case
              # Druckschrift
              when ["a"].include?(p0) then "zu" # Nicht spezifiziert => unspecified

              # Handschrift
              when ["a"].include?(p1) then "zu" # Nicht spezifiziert => unspecified

              # Mikroform
              when ["a", "b", "c"].include?(p3) then "he" # Mikroform => microfiche

              # Blindenschriftträger
              when ["a"].include?(p4) then "zu" # Nicht spezifiziert => unspecified

              # AV-Medien
              when ["aa"].include?(p56) then "sd" # CD-DA => audio disc
              when ["ab"].include?(p56) then "sd" # CD-Bildplatte => audio disc
              when ["ac"].include?(p56) then "st" # Tonband => audiotape reel
              when ["ad"].include?(p56) then "ss" # Tonkassete => audiocassette
              when ["ae"].include?(p56) then "ss" # Micro-Cassette => audiocassette
              when ["af"].include?(p56) then "ss" # DAT-Cassette => audiocassette
              when ["ag"].include?(p56) then "ss" # DCC-Cassette => audiocassette
              when ["ah"].include?(p56) then "sg" # Cartridge => audio cartridge
              when ["ai"].include?(p56) then "sz" # Drahtton => other audio carrier
              when ["aj"].include?(p56) then "sd" # Schallplatte => audio disk
              when ["ak"].include?(p56) then "se" # Walze => audio cylinder
              when ["al"].include?(p56) then "sq" # Klavierrolle => audio roll
              when ["am"].include?(p56) then "si" # Filmtonspur => sound track reel
              when ["an"].include?(p56) then "sz" # Tonbildreihe => other audio carrier

              when ["ba"].include?(p56) then "mr" # Filmspulen => film reel
              when ["bb"].include?(p56) then "mc" # Film-Cartridge => film cartridge
              when ["bc"].include?(p56) then "mf" # Film-Cassette => film cassette
              when ["bd"].include?(p56) then "mz" # Anderes Filmmedium => other projected image carrier
              when ["be"].include?(p56) then "gf" # Filmstreifen => filmstrip
              when ["bf"].include?(p56) then "gc" # Filmstreifen-Cartridge => filmstrip cartridge
              when ["bg"].include?(p56) then "mo" # Filmstreifen-Rolle => film roll
              when ["bh"].include?(p56) then "mz" # Anderer Filmstreifentyp => other projected image carrier
              when ["bi"].include?(p56) then "gs" # Dia => slide
              when ["bj"].include?(p56) then "gt" # Arbeitstransparent => overhead transparency
              when ["bk"].include?(p56) then "gt" # Arbeitstransparentstreifen => overhead transparency

              when ["ca"].include?(p56) then "vf" # Videobandcassette => videocassette
              when ["cb"].include?(p56) then "vc" # Videobandcartridge => video cartridge
              when ["cc"].include?(p56) then "vr" # Videobandspulen => videotape reel
              when ["cd"].include?(p56) then "vd" # Bildplatte => videodisc
              when ["ce"].include?(p56) then "vz" # Anderer Videotyp => other video carrier

              when ["da"].include?(p56) then "zu" # Foto => unspecified
              when ["db"].include?(p56) then "zu" # Kunstblatt => unspecified
              when ["dc"].include?(p56) then "zu" # Plakat => unspecified

              when ["uu"].include?(p56) then "zu" # Unbekannt => unspecified
              when ["yy"].include?(p56) then "zu" # Nicht spezifiziert => unspecified
              when ["zz"].include?(p56) then "zu" # sonstige AV-Medien => unspecified

              # Medienkombination
              when ["a"].include?(p7) then "zu" # Nicht spezifiziert => unspecified

              # Elektronische Ressource
              when ["a"].include?(p8) then "cz" # Nicht spezifiziert => other computer carrier
              when ["b"].include?(p8) then "cd" # Diskette => computer disc
              when ["c"].include?(p8) then "cf" # Magnetbandkassette => computer tape cassette
              when ["d"].include?(p8) then "cd" # Optische Speicherplatten => computer disc
              when ["e"].include?(p8) then "ck" # Einsteckmodule => computer card
              when ["f"].include?(p8) then "ch" # Magnetband => computer tape reel
              when ["g"].include?(p8) then "cr" # Elektronische Ressource => online resource
              when ["z"].include?(p8) then "cz" # Nicht spezifiziert => other computer carrier

              # Spiele
              when ["a"].include?(p9) then "zu" # Nicht spezifiziert => unspecified

              # Landkarten
              when ["a"].include?(p10) then "no" # Nicht spezifiziert => Karte
            else
              "zu" # unspecified
            end
          end

        end
      end
    end
  end
end
