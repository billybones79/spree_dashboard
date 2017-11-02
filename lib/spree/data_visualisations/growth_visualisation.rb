module Spree
  module DataVisualisations
    class GrowthVisualisation < DataVisualisation
      def view_name
        "growth_visualisation"
      end


      def prepare(options = { })


        f = get_fiscal_year
        f = {from: get_fiscal_year[:from].to_s, to: get_fiscal_year[:to].to_s }
        options = {filters: f}.deep_merge(options)
        locals = {}
        #yeah this is cheating the params, buts it looks silly when checking a partial year vs a complete one
        to = [Date.parse(options[:filters][:to]), Date.today].min
        locals[:year_growth]  = calculate_growth new_from: Date.parse(options[:filters][:from]),
                                                 new_to: to,
                                                 old_from: Date.parse(options[:filters][:from]) - 1.year ,
                                                 old_to: to - 1.year,
                                                 route_code: options[:filters][:route_code]

        locals

      end

      def calculate_growth(filters = {})
        byebug
        new_filters = {from: filters[:new_from], to: filters[:new_to], route_code: filters[:route_code]}
        old_filters = {from: filters[:old_from], to: filters[:old_to], route_code: filters[:route_code]}

        new =  base_order_scope(new_filters).where(payment_state: 'paid').sum(:total)
        old =  base_order_scope(old_filters).where(payment_state: 'paid').sum(:total)

        growth = (old - new) / old * 100
        if growth.abs == BigDecimal.new('Infinity')
          growth = 0
        end

        growth

      end


    end
  end
end
