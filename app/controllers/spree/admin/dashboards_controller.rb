module Spree
  module Admin
    class DashboardsController < BaseController

      def index

        begin_date = Time.now - 3.month
        end_date = Time.now

        completed_orders = Spree::Order
          .eager_load(bill_address: [:state, :country])
          .where(payment_state: 'paid').where(completed_at: begin_date..end_date)

        @order_line_bar_data = [
          {
            :key => 'Quantité',
            :bar => true,
            :values =>  []
          },
          {
            :key => 'Ventes totales',
            :values => []
          }
        ]
        @pie_data = []

        @user_data = [
            {
                :key => 'user',
                :values => []
            }
        ]

        order_quantity = {}
        order_quantity.default = 0

        user_quantity = {}
        user_quantity.default = 0

        price = {}
        price.default = 0

        region_data = { :state => {}, :country => {}}

        users = Spree::User.where('created_at >= ?', begin_date)


        users.each do |user|
          day = user.created_at.beginning_of_day.to_i * 1000
          user_quantity[day] += 1
        end

        user_quantity.each do |key, value|
          @user_data[0][:values].push([key, value])
        end

        completed_orders.each do |order|
          day = order.completed_at.beginning_of_day.to_i * 1000
          sale = order.total.to_f
          order_quantity[day] += 1
          price[day] += sale
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
            @order_line_bar_data[0][:values].push([key, value])
            @order_line_bar_data[1][:values].push([key, price[key]])
          end
          [:state, :country].each do |type|
            region_data[type].each { |_, v| @pie_data << {:label => v[:name], :value => v[:revenue] } }
          end
      end
    end
  end
end
