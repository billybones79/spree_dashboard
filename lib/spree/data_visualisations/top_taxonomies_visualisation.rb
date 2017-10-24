module Spree
  module DataVisualisations
    class TopTaxonomiesVisualisation < DataVisualisation
      def view_name
        "top_taxonomies_visualisation"
      end

      def prepare(options = { })
        from = get_fiscal_year "from"
        to = get_fiscal_year "to"
        
        options = {filters: {from: from, to: to}}.merge(options)
        locals = {}
        locals[:top_taxo] = top_taxonomies options[:filters]
        locals

      end

      def top_taxonomies(filters,  top = 3)
        top_tax = {}
        taxonomies = Spree::Taxonomy.all

        taxonomies.each do |t|
          top_tax[t.name] = []
          top_taxons = Spree::Order.
              joins(:line_items => [{:product => :taxons}]).
              where(payment_state: 'paid').
              where(completed_at: filters[:begin_date]..filters[:end_date]).
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
         top_tax
      end
    end
  end
end
