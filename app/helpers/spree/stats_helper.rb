module Spree
  module StatsHelper
   def filtered_params
     params.slice(:from, :to, :route_code).delete_if{|k, v| v.blank?}.symbolize_keys
   end
  end
end
