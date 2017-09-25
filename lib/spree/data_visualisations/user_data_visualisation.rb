module Spree
  module DataVisualisations
    class UserDataVisualisation < BarGraphVisualisation
      def view_name
        "bar_graph_visualisation"
      end

      def div_id
        "user_graph"
      end

      def bar_graph_name
        I18n.t('index.new_users')
      end


      def data(filters={})

        user_data = [
            {
                :key => 'user',
                :values => []
            }
        ]
        user_quantity = {}
        user_quantity.default = 0

        users = Spree::User.eager_load(:spree_roles)
                    .where("(spree_roles.name != ? OR spree_roles.id IS NULL)", 'admin')
                    .where('created_at >= ?', filters[:from])
                    .where('created_at < ?', filters[:to])
                    .order('created_at')

        users.each do |user|
          day = user.created_at.beginning_of_day.to_i * 1000
          user_quantity[day] += 1
        end

        user_quantity.each do |key, value|
          user_data[0][:values] << [key, value]
        end
         user_data.to_json.html_safe
      end

    end
  end
end