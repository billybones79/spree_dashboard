module Spree
  module DataVisualisations
    class PieChartVisualisation < DataVisualisation
      def view_name
        "pie_chart_visualisation"
      end




      def prepare(options = { })

        options = {filters:{ from:  Time.now.beginning_of_year, to: Time.now()}, div_options:{id: "pie_chart", style: "height: 550px"}}.merge(options)
        locals = {}
        locals[:pie_name] = I18n.t('index.sales_by_region')
        locals[:pie_data] = get_region_data(options[:filters])
        locals[:div_options] = options[:div_options]

        locals

      end

      def get_region_data (filters= {})

        completed_orders = Spree::Order
                               .eager_load(bill_address: [:state, :country])
                               .where(payment_state: 'paid')
                               .where(completed_at: filters[:begin_date]..filters[:end_date])
                               .order(:completed_at)


        pie_data = []

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
          region_data[type].each { |_, v| pie_data << {:label => v[:name], :value => v[:revenue]} }
        end
        pie_data
      end



    end
  end
end