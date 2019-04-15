module Spree
  module Admin
    class DashboardsController < BaseController

      helper Spree::StatsHelper

      def index
        begin_date = Time.now.years_ago(1)
        end_date = Time.now


      end

      protected

    end
  end
end
