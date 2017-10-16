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
      def style
        "height: 550px;"
      end




      def prepare(options = {})
        today = Date.today
        from = Date.new(Date.today.year, 6, 30)
        to = from + 1.day

        if today < from
          from = from - 1.year
          to = to - 1.year
        end

        options = {filters: {from: from, to: to}, div_options:{id: div_id, style: style}}.merge(options)
        locals = {}
        locals[:bar_graph_name] = bar_graph_name
        locals[:bar_graph_data] = data(options[:filters])
        locals[:div_options] = options[:div_options]
        locals[:from] = options[:filters][:from]
        locals[:to] = options[:filters][:to]
        locals

      end


      def data(filters={})

      end

    end
  end
end
