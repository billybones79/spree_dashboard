module Spree
  module DataVisualisations
    class DataVisualisation

      #base scope for filters
      def base_order_scope filters = {}
        Spree::Order.joins(:line_items).where(created_at: filters[:from]..filters[:to])
      end

      def get_fiscal_year
        today = Date.today
        
        from = Date.new(Date.today.year, 7, 01)
        to = from + 1.year

        if today < from
          from = from - 1.year
          to = to - 1.year
        end

         {from: from, to: to}
      end

      def view_path
        "spree/admin/data_visualisations"
      end

      def view_name
        "discrete_bar_chart_visualisation"
      end
      def defaults
        {filters: get_fiscal_year, div_options:{id: div_id, style: style}}
      end

      def prepare(options = {})

        options = defaults.deep_merge(options)
        locals = {}
        locals[:name] = name
        locals[:data] = data(options[:filters])
        locals[:div_options] = options[:div_options]
        locals[:from] = options[:filters][:from]
        locals[:to] = options[:filters][:to]
        locals
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