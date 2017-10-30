module Spree
  module DataVisualisations
    class DataVisualisation

      # Permet d'obtenir les dates de l'année financière
      def get_fiscal_year()
        today = Date.today
        
        from = Date.new(Date.today.year, 6, 30)
        to = from + 1.day

        if today < from
          from = from - 1.year
          to = to - 1.year
        end

        return {from: from, to: to}
      end

      def view_path
        "spree/admin/data_visualisations"
      end

      def view_name
        "discrete_bar_chart_visualisation"
      end

      def prepare options = {}

      end


      def render_visualisation  options = {}


        ApplicationController.new.render_to_string(
            :partial => (view_path+"/" +view_name),
            :locals => prepare(options)
        )


      end
    end
  end
end