module Spree
  module DataVisualisations
    class AbandonmentsDataVisualisation < DataVisualisation

      def name
        "abandonments_data_visualisation"
      end

      def div_id
        'abandonments_data_visualisation'
      end

      def style
        "height: 550px;"
      end

      def data(filters={})
        values = []
        total = base_order_scope(filters).count
        cancelled = base_order_scope(filters).where("completed_at is null").count

        if cancelled == 0
          result = 0
        else
          result = (cancelled * 100) / total
        end
        values = {result: result, places: places_list}

      end
    end
  end
end
