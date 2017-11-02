module Spree
  module DataVisualisations
    class GrowthVisualisation < DataVisualisation
      def view_name
        "growth_visualisation"
      end


      def prepare(options = { })

        f = get_fiscal_year
        f = {from: get_fiscal_year[:from].to_s, to: get_fiscal_year[:to].to_s }
        options = {filters: f}.deep_merge(options)
        locals = {}
        locals[:year_growth]  = calculate_growth new_from: Date.parse(options[:filters][:from]) , new_to: Date.parse(options[:filters][:to]),  old_from: Date.parse(options[:filters][:from]) - 1.year , old_to: Date.parse(options[:filters][:to]) - 1.year

        locals

      end

      def calculate_growth(filters = {})
        new =  base_order_scope(filters).where(payment_state: 'paid').sum(:total)
        old =  base_order_scope(filters).where(payment_state: 'paid').sum(:total)

        growth = (old - new) / old * 100
        if growth.abs == BigDecimal.new('Infinity')
          growth = 0
        end

        growth

      end


    end
  end
end
