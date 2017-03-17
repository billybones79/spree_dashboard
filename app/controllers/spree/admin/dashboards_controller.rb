module Spree
  module Admin
    class DashboardsController < BaseController

      helper Spree::StatsHelper

      def index

        begin_date = Time.now.years_ago(1)
        end_date = Time.now

        get_region_data(begin_date, end_date)

        get_orders_data(begin_date, end_date)
      end

      protected
      def get_orders_data (begin_date, end_date)
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

        order_quantity = {}
        order_quantity.default = 0

        price = {}
        price.default = 0

        completed_orders.each do |order|
          month = order.completed_at.beginning_of_month.beginning_of_day.to_i*1000
          sale = order.total.to_f
          order_quantity[month] += 1
          price[month] += sale
       end

        order_quantity.each do |key, value|
          @order_line_bar_data[0][:values] << [key, value]
          @order_line_bar_data[1][:values] << [key, price[key]]
        end
      end

      def get_region_data (begin_date, end_date)

        completed_orders = Spree::Order
                               .eager_load(bill_address: [:state, :country])
                               .where(payment_state: 'paid')
                               .where(completed_at: begin_date..end_date)
                               .order(:completed_at)


        @pie_data = []

        region_data = {:state => {}, :country => {}}

        completed_orders.each do |order|
          month = order.completed_at.month
          sale = order.total.to_f
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

        [:state, :country].each do |type|
          region_data[type].each { |_, v| @pie_data << {:label => v[:name], :value => v[:revenue]} }
        end
        return @pie_data
      end
    end
  end
end
