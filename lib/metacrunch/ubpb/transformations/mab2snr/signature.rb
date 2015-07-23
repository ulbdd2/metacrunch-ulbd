module Metacrunch
  module UBPB
    module Transformations
      module MAB2SNR
        class Signature < Metacrunch::Transformer::Step

          def perform
            target.add("display", "signature", display)
            target.add("search",  "signature", search)
          end

        private

          def display
            signatures(filter_for_display: true).first
          end

          def search
            signatures
          end

          def signatures(filter_for_display: false)
            signatures = []

            # Zeitschriften
            signatures += journal_signatures
            # Monos
            signatures += loc_signatures(filter_for_display: filter_for_display)
            # Stücktitel
            signatures += stuecktitel_signatures

            # Delete possible nil values
            signatures.compact!
            # Basic cleanup
            signatures.map!{ |s| cleanup(s) }
            # Fix journal signatures
            signatures.map!{ |s| fix_journals(s) }

            signatures
          end

          def loc_signatures(filter_for_display: false)
            # Extrahiere alle Exemplare mit einer Signatur
            datafields = source.datafields("LOC").select do |datafield|
              datafield.subfields("d").present?
            end

            # Sind alle Exemplare im Magazin?
            all_stack = datafields.all?{ |f| on_stack?(f) }

            # Sortiere die Exemplare nach Unterfeld 5 (Strichcode)
            datafields = datafields.sort do |x, y|
              x.subfields("5").first_value <=> y.subfields("5").first_value
            end

            # Im display Fall nimm nur die erste Signatur. Stehen zusätzlich
            # alle Exemplare im Magazin
            if filter_for_display && !all_stack
              signature = datafields
                .reject{ |f| on_stack?(f) }              # Entferne alle Magazin Exemplare
                .map{ |f| f.subfields("d").first_value } # Extrahiere alle verbleibenden Signaturen
                .first                                   # Nimm die erste Signatur

              [base_signture(signature)]
            else
              datafields.map{ |f| f.subfields("d").first_value }
            end
          end

          def stuecktitel_signatures
            source.datafields("100", ind1: :blank).subfields("a").values
          end

          def journal_signatures
            source.datafields("200", ind1: :blank, ind2: :blank).subfields("f").values
          end

          def base_signture(signature)
            index = signature.index("+") || signature.length
            signature[0..index-1]
          end

          def on_stack?(datafield)
            datafield.subfields("b").first_value =~ /02|03|04|07/
          end

          #
          # Cleanup signtaures
          #
          def cleanup(signature)
            signature
              .gsub(/\A\//, "") # remove leading '/' for some journal signatures
              .squish           # remove spaces for some journal signatures (e.g. "P 10/34 t 26")
              .upcase           # upcase
          end

          #
          # Fix journal signatures by adding missing Standortkennziffer
          #
          def fix_journals(signature)
            if is_journal_signature(signature) && !signature.starts_with?("P") && standort_kennziffer.present?
              "P#{standort_kennziffer}/#{signature}"
            else
              signature
            end
          end

          def is_journal_signature(signature)
            signature =~ /\AP\d\d|\d+[A-Za-z]\d+\Z/ # e.g. P00 or 34T26
          end

          def standort_kennziffer
            @standort_kennziffer ||= begin
              source.datafields("LOC").subfields("b").first_value ||
              source.datafields("105").subfields("a").first_value
            end
          end

        end
      end
    end
  end
end
