Deface::Override.new(
  virtual_path: 'spree/layouts/admin',
  name: 'dashboard_admin_sidebar_menu',
  insert_top: '#main-sidebar',
  partial: 'spree/admin/shared/dashboard_main_menu'
)
