module Spree
  module DataVisualisations
    class GrowthVisualisation < DataVisualisation
      def view_name
        "growth_visualisation"
      end


      def prepare(options = { })

        options = {starts_at:  Time.now}.merge(options)
        locals = {}
        locals[:month_growth] = calculate_growth options[:starts_at].beginning_of_month, options[:starts_at], options[:starts_at].beginning_of_month - 1.month, options[:starts_at] - 1.month
        locals[:year_growth]  = calculate_growth options[:starts_at].beginning_of_year , options[:starts_at],  options[:starts_at].beginning_of_year - 1.year , options[:starts_at] - 1.year

        locals

      end

      def calculate_growth(new_begin, new_end, old_begin, old_end)
        new =  Spree::Order.where(completed_at: new_begin..new_end).where(payment_state: 'paid').sum(:total)
        old =  Spree::Order.where(completed_at: old_begin..old_end).where(payment_state: 'paid').sum(:total)
        growth = (old - new) / old * 100

        if growth.abs == BigDecimal.new('Infinity')
          growth = 0
        end

        growth

      end


    end
  end
end