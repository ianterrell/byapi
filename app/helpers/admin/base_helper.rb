module Admin::BaseHelper
  def breadcrumbs(*items)
    links = []
    items.each do |item|
      if item == :root
        links << { :text => "Home", :path => admin_root_path }
      elsif item.respond_to?(:title) || item.respond_to?(:name)
        links << { :text => item.respond_to?(:title) ? item.title : item.name, :path => [:admin, item] }
      elsif item.is_a? Array
        if item.last.is_a? Symbol
          links << { :text => item.last.to_s.titleize, :path => [:admin] + item }
        elsif item.last.respond_to?(:title) || item.last.respond_to?(:name)
          links << { :text => item.last.respond_to?(:title) ? item.last.title : item.last.name, :path => [:admin] + item }
        end
      else
        links << { :text => item.to_s.titleize }
      end
    end
    content_for :breadcrumbs do
      links.map{|l| l[:path].blank? ? l[:text] : link_to_unless_current(l[:text], l[:path])}.join(" &raquo; ")
    end
  end
  
  def errors_for(item)
    render :partial => "/admin/base/errors_for", :locals => { :item => item }
  end
  
  def field_for(f, field)
    render :partial => "/admin/base/field_for", :locals => { :field => field, :f => f }
  end
  
  def actions_for(f)
    render :partial => "/admin/base/actions_for", :locals => { :f => f }
  end
end
