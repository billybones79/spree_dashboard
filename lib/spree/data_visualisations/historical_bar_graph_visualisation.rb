module Spree
  module DataVisualisations
    class HistoricalBarGraph < DataVisualisation

        def view_name
          "historical_bar_graph_visualisation"
        end

        def name
          "Historical Bar Graph"
        end

        def style
          "height: 550px;"
        end

        def div_id
          "the_historical_bar_graph_id"
        end



      def data(filters={})

      end

    end
  end
end
