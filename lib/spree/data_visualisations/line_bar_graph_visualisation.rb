module Spree
  module DataVisualisations
    class LineBarGraphVisualisation < DataVisualisation

      def view_name
        "line_bar_graph_visualisation"
      end

      def name
        "line_bar_graph_visualisation"
      end

      def style
        "height: 550px;"
      end

      def div_id
        "line_bar_graph_visualisation"
      end

      def data(filters={})
        
      end

    end
  end
end
