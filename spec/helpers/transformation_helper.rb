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

end
