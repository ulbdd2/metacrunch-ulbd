describe Metacrunch::UBPB::Transformations::MabToPrimo::AddCorporateBodyContributorDisplay do
  define_field_test '000000003', corporate_body_contributor_display: ["Lippstadt", "Stadtarchiv <Lippstadt>"]
  define_field_test '000017278', corporate_body_contributor_display: ["Hochschulwoche für Politische Bildung <18, 1980, Horn-Meinberg>", "Landeszentrale für Politische Bildung <Düsseldorf>"]
  define_field_test '000023677', corporate_body_contributor_display: ["Conference on Physics of Fiber Optics <1978, Kingston, RI>", "Short Course on Recent Advances in Fiber Optics <1978, Kingston, RI>"]
end
