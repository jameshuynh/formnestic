module Formnestic
  module Inputs
    module Base
      extend ActiveSupport::Autoload
      autoload :Wrapping
      autoload :Labelling

      include Wrapping
      include Labelling
    end
  end
end
