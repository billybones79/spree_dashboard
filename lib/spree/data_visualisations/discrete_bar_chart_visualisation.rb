module Spree
  module DataVisualisations
    class DiscreteBarChartVisualisation < DataVisualisation

        def name
          "Discrete Bar Graph"
        end

        def style
          "height: 550px;"
        end

        def div_id
          "the_discrete_bar_graph_id"
        end


      def data(filters={})

      end

    end
  end
end
