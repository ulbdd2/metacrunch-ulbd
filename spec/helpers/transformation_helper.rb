module TransformationHelper

  def transform(step_class, source, target, options = {})
    transformer = Metacrunch::Transformer.new
    transformer.register_helper(Metacrunch::UBPB::Transformations::MAB2SNR::Helpers::CommonHelper)

    transformer.source  = source
    transformer.target  = target
    transformer.options = options

    transformer.transform(step_class)

    transformer
  end

  def mab_builder(&block)
    Metacrunch::Mab2::Builder.build(&block)
  end

  def mab2snr(mab, options = {})
    transformer = transform(described_class, mab, Metacrunch::SNR.new, options)
    Mab2SnrResult.new(transformer)
  end

  class Mab2SnrResult
    attr_reader :transformer

    def initialize(transformer)
      @transformer = transformer
    end

    def values(path)
      @transformer.target.values(path)
    end

    def first_value(path)
      values(path).first
    end
  end

end
