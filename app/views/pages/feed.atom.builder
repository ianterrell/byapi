atom_feed do |feed|
  feed.title @site.title

  feed.updated @designs.first.try :approved_at

  @designs.each do |design|
    feed.entry(design, :published => design.approved_at) do |entry|
      entry.title design.title
      
      entry.author do |author|
        author.name "Ian Terrell, or else a mystery"
      end
      
      html = image_tag(@site.domain + design.image.url)
      html << "<br/>".html_safe
      if design.cafepress_section_id
        html << link_to("Buy this design on a t-shirt, mug, greeting card, water bottle, or more!", "http://www.cafepress.com/#{design.store.name}/#{design.cafepress_section_id}")
      end
      
      entry.summary :type => "html" do
        entry.cdata! html
      end
    end
  end
end