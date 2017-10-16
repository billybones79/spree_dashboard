module Spree
  module DataVisualisations
    class GrowthVisualisation < DataVisualisation
      def view_name
        "growth_visualisation"
      end


      def prepare(options = { })

        options = {starts_at:  Time.now}.merge(options)
        locals = {}
        locals[:month_growth] = calculate_growth new_from: options[:starts_at].beginning_of_month, new_to: options[:starts_at], old_from: options[:starts_at].beginning_of_month - 1.month, old_to: options[:starts_at] - 1.month
        locals[:year_growth]  = calculate_growth new_from: options[:starts_at].beginning_of_year , new_to: options[:starts_at],  old_from: options[:starts_at].beginning_of_year - 1.year , old_to: options[:starts_at] - 1.year

        locals

      end

      def calculate_growth(filters = {})
        new =  Spree::Order.where(completed_at: filters[:new_from]..filters[:new_to]).where(payment_state: 'paid').sum(:total)
        old =  Spree::Order.where(completed_at: filters[:old_from]..filters[:old_to]).where(payment_state: 'paid').sum(:total)
        growth = (old - new) / old * 100

        if growth.abs == BigDecimal.new('Infinity')
          growth = 0
        end

        growth

      end


    end
  end
end
