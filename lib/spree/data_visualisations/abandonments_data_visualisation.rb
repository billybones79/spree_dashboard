module Spree
  module DataVisualisations
    class AbandonmentsDataVisualisation < DataVisualisation

      def view_name
        "abandonments_visualisation"
      end

      def graph_name
        "Abandons"
      end

      def prepare(options = {})
        from = get_fiscal_year "from"
        to = get_fiscal_year "to"

        options = {filters: {from: from, to: to}, div_options:{id: div_id, style: style}}.merge(options)
        locals = {}
        locals[:stats_name] = graph_name
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
