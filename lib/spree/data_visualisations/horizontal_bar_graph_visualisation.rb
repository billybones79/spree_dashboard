module Spree
  module DataVisualisations
    class HoritonzalBarGraphVisualisation < DataVisualisation

      def view_name
        "horizontal_bar_graph_visualisation"
      end

      def name
        "Horitonzal Bar Graph"
      end

      def style
        "height: 550px;"
      end

      def div_id
        "the_bar_graph_id"
      end


      def data(filters={})

      end

    end
  end
end
