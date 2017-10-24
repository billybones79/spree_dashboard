module Spree
  module DataVisualisations
    class TotalVisualisation < DataVisualisation
      def view_name
        "total_visualisation"
      end


      def prepare(options = { })

        options = {from: from, to: from}.merge options
        locals = {}
        locals[:total] =  Spree::Money.new(Spree::Order.where(completed_at: options[:from]..options[:to]).where(payment_state: 'paid').sum(:total))
        locals[:avg_sale] =  Spree::Money.new(Spree::Order.where(completed_at: options[:from]..options[:to]).where(payment_state: 'paid').average(:total))

        locals

      end



    end
  end
end