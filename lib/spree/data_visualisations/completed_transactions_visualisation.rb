module Spree
  module DataVisualisations
    class CompletedTransactionsVisualisation < DataVisualisation

      def view_name
        "transactions_visualisation"
      end

      def name
        "completed_transactions"
      end

      def div_id
        'completed_transactions'
      end

      def style
        "height: 550px;"
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
