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
		    	
		    end
		end
	end
end