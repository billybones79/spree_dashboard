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


      def data(filters={})

      end
    end
  end
end
