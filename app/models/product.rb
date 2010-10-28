class Product < ActiveRecord::Base
  def sort_priority
    priority = 50
    if section == "apparel"
      priority += 1 if name =~ /organic/i
      priority += 1 if name =~ /shirt/i
      priority += 1 if name =~ /men's shirt/i
      priority += 1 if name =~ /fitted/i
      priority -= 1 if name =~ /long/i
      priority -= 1 if name =~ /tank/i 
      priority -= 1 if name =~ /ringer/i
      priority -= 2 if name =~ /hoodie/i
      priority -= 3 if name =~ /brief/i 
      priority -= 3 if name =~ /thong/i
      priority -= 4 if name =~ /shorts/i 
      priority -= 4 if name =~ /hat/i
      priority -= 5 if name =~ /baby/i 
      priority -= 5 if name =~ /kids/i
      priority -= 8 if name =~ /dog/i
      priority -=10 if name =~ /denim/i
      priority -=10 if name =~ /jacket/i
    else
      priority += 6 if name =~ /mug/i 
      priority += 5 if name =~ /stein/i
      priority += 4 if name =~ /bottle/i 
      priority += 4 if name =~ /food/i
      priority -= 3 if name =~ /cooler/i
      priority += 3 if name =~ /mousepad/i
      priority += 2 if name =~ /bag/i 
      priority += 2 if name =~ /beach/i 
      priority += 1 if name =~ /apron/i 
      priority += 1 if name =~ /bib/i 
      priority -= 2 if name =~ /yoga/i 
      priority -= 3 if name =~ /blanket/i
      priority -= 4 if name =~ /card/i
    end
    priority = 0 if priority == 50
    priority
  end
end
