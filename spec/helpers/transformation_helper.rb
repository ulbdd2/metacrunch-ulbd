module TransformationHelper

  def transformer
    unless @transformer
      @transformer = Metacrunch::Transformer.new
      @transformer.register_helper(Metacrunch::UBPB::Transformations::MAB2SNR::Helpers::CommonHelper)
    end

    @transformer
  end

  def transform(step_class, source, target, options = {})
    transformer.source  = source
    transformer.target  = target
    transformer.options = options
    transformer.transform(step_class)
    target
  end

end
