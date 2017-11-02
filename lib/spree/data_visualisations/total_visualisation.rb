module Spree
  module DataVisualisations
    class TotalVisualisation < DataVisualisation
      def view_name
        "total_visualisation"
      end


      def prepare(options = { })

        options = {filters: get_fiscal_year}.deep_merge options
        locals = {}
        locals[:total] =  Spree::Money.new(base_order_scope(options[:filters]).where(payment_state: 'paid').sum(:total))
        locals[:avg_sale] =  Spree::Money.new(base_order_scope(options[:filters]).where(payment_state: 'paid').average(:total))

        locals

      end



    end
  end
end