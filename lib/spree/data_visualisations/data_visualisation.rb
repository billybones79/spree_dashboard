module Spree
  module DataVisualisations
    class DataVisualisation

      def view_name
        "data_visualisation"
      end

      def view_path
        "spree/admin/data_visualisations"
      end

      def prepare options = {}

      end


      def render_visualisation  options = {}


        ApplicationController.new.render_to_string(
            :partial => (view_path+"/" +view_name),
            :locals => prepare(options)
        )


      end
    end
  end
end