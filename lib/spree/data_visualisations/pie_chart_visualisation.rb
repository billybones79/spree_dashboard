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

		    def prepare(options = { })
		    	# Obtenir la date de début et de fin
			    from = get_fiscal_year "from"
			    to = get_fiscal_year "to"

			    options = {filters: {from: from, to: to}, div_options:{id: div_id, style: style}}.merge(options)
		        locals = {}
		        locals[:name] = name
		        locals[:data] = data(options[:filters])
		        locals[:div_options] = options[:div_options]
		        locals[:from] = options[:filters][:from]
		        locals[:to] = options[:filters][:to]
		        locals
		    end

		    def data(filters={})
		    	
		    end
		end
	end
end