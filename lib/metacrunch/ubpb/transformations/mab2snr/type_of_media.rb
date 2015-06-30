module Metacrunch
  module UBPB
    module Transformations
      module MAB2SNR
        class TypeOfMedia < Metacrunch::Transformer::Step

          def perform
            target.add("control", "type_of_media", type_of_media)
          end

        private

          def type_of_media
            f050 = doc.controlfield("050").values

            case
              when f050.at(0) == "a" then "print" # Druckschrift

              when f050.at(3) == "a" then "microform" # nicht spezifiziert
              when f050.at(3) == "b" then "microform" # Mikroform-Master
              when f050.at(3) == "c" then "microform" # Sekundärform

              when f050.at(5) == "a" then "audio" # Tonträger
              when f050.at(5) == "b" then "video" # Film, visuelle Projektion
              when f050.at(5) == "c" then "video" # Videoaufnahme
              when f050.at(5) == "d" then "image" # Bildliche Darstellung

              when f050.at(8) == "b" then "data_storage"    # Diskette
              when f050.at(8) == "c" then "data_storage"    # Magnetbandkasette
              when f050.at(8) == "d" then "data_storage"    # Optisches Speichermedium
              when f050.at(8) == "e" then "data_storage"    # Einsteckmodule
              when f050.at(8) == "f" then "data_storage"    # Magnetband
              when f050.at(8) == "g" then "online_resource" # Online Ressource
              when f050.at(8) == "z" then "data_storage"    # sonstige elek. Ressourcen

              when f050.at(9) == "a" then "game" # Brettspiel

              when f050.at(10) == "a" then "map" # Landkarte
            else
              "other"
            end
          end

        end
      end
    end
  end
end
