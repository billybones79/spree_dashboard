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

      def prepare(options = {})
        options = {filters: get_fiscal_year, div_options:{id: div_id, style: style}}.merge(options)
        locals = {}
        locals[:name] = name
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
