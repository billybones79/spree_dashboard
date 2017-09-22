module Spree
  module DataVisualisations
    class BarGraphVisualisation < DataVisualisation
      def view_name
        "bar_graph_visualisation"
      end

      def div_id
        "bar_graph"
      end

      def bar_graph_name
        "bar_graph"
      end




      def prepare(options = { })

        options = {from: 1.year.ago, to: Time.now(), div_options:{id: div_id, style: "height: 200px"}}.merge(options)
        locals = {}
        locals[:bar_graph_name] = bar_graph_name
        locals[:bar_graph_data] = data(options[:from], options[:to])

        locals[:div_options] = options[:div_options]

        locals

      end


      def data(from, to)

      end

    end
  end
end