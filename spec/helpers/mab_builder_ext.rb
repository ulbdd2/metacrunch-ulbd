module Metacrunch
  module Mab2
    class Builder

      def superorder!
        controlfield("051", "n")
      end

      def journal!
        controlfield("052", "p")
      end

    end
  end
end
