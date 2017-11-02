module Spree
  module DataVisualisations
    class BarGraphVisualisation < DataVisualisation

        def view_name 
          "bar_graph_visualisation"
        end

        def name
          "Bar Graph"
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
