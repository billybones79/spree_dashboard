module Spree
  module StatsHelper
    def total_sales_period(begin_date = Time.now.beginning_of_year, end_date = Time.now)
      Spree::Order
        .where(completed_at: begin_date..end_date)
        .where(payment_state: 'paid')
        .sum(:total)
    end

    def average_sales_period(begin_date = Time.now.beginning_of_year, end_date = Time.now)
      Spree::Order
        .where(completed_at: begin_date..end_date)
        .where(payment_state: 'paid')
        .average(:total)
    end

    def average_num_period(date_extract = 'month', begin_date = Time.now.beginning_of_year, end_date = Time.now)
      subquery = Spree::Order.select("EXTRACT(#{date_extract} FROM completed_at) AS ex, COUNT(*) as the_count")
        .where(payment_state: 'paid')
        .where(completed_at: begin_date..end_date)
        .group('ex')
      return Spree::Order.from("(#{subquery.to_sql}) as subq").average('the_count')

    end

    def calculate_growth(new_begin, new_end, old_begin, old_end)
      new = total_sales_period new_begin, new_end
      old = total_sales_period old_begin, old_end
      growth = (old - new) / old * 100

      if growth.abs == BigDecimal.new('Infinity')
        growth = 0
      end

      return growth

    end

    def top_taxonomies(begin_date = Time.now.beginning_of_year, end_date = Time.now, top = 3)
      top_tax = {}
      taxonomies = Spree::Taxonomy.all

      taxonomies.each do |t|
        top_tax[t.name] = []
        top_taxons = Spree::Order.
          joins(:line_items => [{:product => :taxons}]).
          where(payment_state: 'paid').
          where(completed_at: begin_date..end_date).
          where(:spree_taxons => {
          id: Spree::Taxon
            .select(:id)
            .where(taxonomy_id: t)
            .where.not(id: Spree::Taxon
            .select(:parent_id)
            .where(taxonomy_id: t)
            .where('parent_id IS NOT NULL')
            .map(&:parent_id).uniq)
            .map(&:id)
        })
          .select('spree_taxons.id')
          .group('spree_taxons.id')
          .order('count_spree_taxons_id desc')
          .limit(top)
          .count('spree_taxons.id')
        top_taxons.each do |k, v|
          taxon = Spree::Taxon.find(k)
          pretty_name = taxon.pretty_name.slice(taxon.pretty_name.index("->")+3..-1)
          top_tax[t.name] << {:name => pretty_name, :value => v}
        end
      end
        return top_tax
    end

    def user_data(begin_date = Time.now.beginning_of_year)

      user_data = [
        {
          :key => 'user',
          :values => []
        }
      ]
      user_quantity = {}
      user_quantity.default = 0

      users = Spree::User.where('created_at >= ?', begin_date)

      users.each do |user|
        day = user.created_at.beginning_of_day.to_i * 1000
        user_quantity[day] += 1
      end

      user_quantity.each do |key, value|
        user_data[0][:values] << [key, value]
      end
      return user_data.to_json.html_safe
    end

    def email_data(begin_date = Time.now.beginning_of_year)
      email_data = [
        {
          :key => 'email',
          :values => []
        }
      ]
      email_quantity = {}
      email_quantity.default = 0

      emails = Spree::Order.select(:email)
        .where('created_at >= ?', begin_date)
        .where(payment_state: 'paid')
        .group(:email)
        .uniq
        .minimum(:completed_at)

      emails.each do |e|
        day = e[1].beginning_of_day.to_i
        email_quantity[day] += 1
      end

      email_quantity.each do |key, value|
        email_data[0][:values] << [key, value]
      end
      return email_data.to_json.html_safe
    end
  end
end
