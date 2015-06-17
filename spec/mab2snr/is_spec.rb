describe Metacrunch::UBPB::Transformations::MAB2SNR::Id do

  it "works" do
    result = perform("123456789")
    expect(result[:control]).to eq("123456789")
  end

private

  def perform(id)
    transformer = transform(
      Metacrunch::UBPB::Transformations::MAB2SNR::Id,
      Metacrunch::Mab2::Document.new,
      Metacrunch::SNR.new,
      { source_id: id }
    )

    control = transformer.target.values("control/id").first

    {
      transformer: transformer,
      control: control
    }
  end

end
