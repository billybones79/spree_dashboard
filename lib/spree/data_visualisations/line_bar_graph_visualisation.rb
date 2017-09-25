module Spree
  module DataVisualisations
    class LineBarGraphVisualisation < DataVisualisation
      def view_name
        "line_bar_graph_visualisation"
      end




      def prepare(options = { })

        options = {filters: {from: 1.year.ago.beginning_of_month, to: Time.now()}, div_options:{id: "line_bar_graph", style: "height: 550px"}}.merge(options)
        locals = {}
        locals[:line_bar_graph_name] = I18n.t('index.sales')
        locals[:line_bar_graph_data] = get_orders_data(options[:filters])
        locals[:div_options] = options[:div_options]

        locals

      end

      def get_orders_data (filters={})
        completed_orders = Spree::Order
                               .eager_load(bill_address: [:state, :country])
                               .where(payment_state: 'paid')
                               .where(completed_at: filters[:begin_date]..filters[:end_date])
                               .order(:completed_at)


        order_line_bar_data = [
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
          puts month
          sale = order.total.to_f
          order_quantity[month] += 1
          price[month] += sale
        end

        order_quantity.each do |key, value|
          order_line_bar_data[0][:values] << [key, value]
          order_line_bar_data[1][:values] << [key, price[key]]
        end
        order_line_bar_data
      end



    end
  end
end