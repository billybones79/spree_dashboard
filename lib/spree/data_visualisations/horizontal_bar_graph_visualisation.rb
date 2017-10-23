module Spree
  module DataVisualisations
    class HorizontalBarGraphVisualisation < DataVisualisation
      def view_name
        "horizontal_bar_graph_visualisation"
      end

      def div_id
        "bar_graph"
      end

      def name
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
        locals[:name] = bar_graph_name
        locals[:data] = data(options[:filters])
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
