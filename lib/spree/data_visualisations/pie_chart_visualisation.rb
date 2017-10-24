module Spree
	module DataVisualisations
		class PieChartVisualisaton < DataVisualisation
			def view_name
		        "pie_chart_visualisation"
		    end

		    def style
		    	"height: 550px;"
		    end

		    def div_id
		    	"the_pie_chart_id"
		    end

		    def prepare(options = { })
			    from = get_fiscal_year "from"
			    to = get_fiscal_year "to"

			    options = {filters:{ from: from, to: to}, div_options:{id: "pie_chart", style: "height: 550px"}}.deep_merge(options)
			    locals = {}
			    locals[:pie_name] = I18n.t('index.sales_by_region')
			    locals[:pie_data] = get_region_data(options[:filters])
			    locals[:div_options] = options[:div_options]
			    locals
		    end
		end
	end
end