module Spree
	module DataVisualisations
		class PieChartVisualisation < DataVisualisation
			def view_name
		        "pie_chart_visualisation"
		    end

		    def name
		    	"Pie Chart Graph"
		    end

		    def style
		    	"height: 550px;"
		    end

		    def div_id
		    	"the_pie_chart_id"
		    end
			

		    def data(filters={})
					completed_orders = base_order_scope(filters)
																 .eager_load(bill_address: [:state, :country])
																 .where(payment_state: 'paid')
																 .where(completed_at: filters[:from]..filters[:to])
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