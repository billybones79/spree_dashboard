Spree::Backend::Config.configure do |config|
  config.menu_items << config.class::MenuItem.new(
      [:admin_dash],
      'copy',
      label: :dashboard,
      partial: 'spree/admin/shared/dashboard_main_menu',
      url: '/admin/dash'
  )


end