module Spree
  module Admin
    class DashboardsController < BaseController

      helper Spree::StatsHelper

      def index

        begin_date = Time.now.beginning_of_year
        end_date = Time.now
        today = end_date.beginning_of_day

        completed_orders = Spree::Order
                               .eager_load(bill_address: [:state, :country])
                               .where(payment_state: 'paid')
                               .where(completed_at: begin_date..end_date)
                               .order(:completed_at)


        @order_line_bar_data = [
            {
                :key => 'Quantité',
                :bar => true,
                :values => []
            },
            {
                :key => 'Ventes totales',
                :values => []
            }
        ]
        @pie_data = []

        order_quantity = {}
        order_quantity.default = 0

        price = {}
        price.default = 0

        region_data = {:state => {}, :country => {}}

        completed_orders.each do |order|
          month = order.completed_at.month
          sale = order.total.to_f
          order_quantity[month] += 1
          price[month] += sale
          if order.bill_address.state and order.bill_address.country.name == 'Canada'
            region_data[:state][order.bill_address.state_id] ||= {
                :name => order.bill_address.state.name,
                :revenue => 0
            }
            region_data[:state][order.bill_address.state_id][:revenue] += sale
          else
            region_data[:country][:null] ||= {
                :name => 'Autre',
                :revenue => 0
            }
            region_data[:country][:null][:revenue] += sale

          end
        end

        order_quantity.each do |key, value|
          @order_line_bar_data[0][:values] << [key, value]
          @order_line_bar_data[1][:values] << [key, price[key]]
        end
        [:state, :country].each do |type|
          region_data[type].each { |_, v| @pie_data << {:label => v[:name], :value => v[:revenue]} }
        end
      end
    end
  end
end
