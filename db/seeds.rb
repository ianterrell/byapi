# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

Category.create :key => "scifi", :name => "Fantasy / Science Fiction"
Category.create :key => "entertainment", :name => "Entertainment / Pop Culture"
Category.create :key => "geek", :name => "Geeks / Technology"
Category.create :key => "health", :name => "Health"
Category.create :key => "gblt", :name => "Gay / Lesbian / Bi / Transgender"
Category.create :key => "politics", :name => "Politics / Government"
Category.create :key => "humor", :name => "Humor"
Category.create :key => "pets", :name => "Pets"
Category.create :key => "holidays", :name => "Holidays / Occasions"
Category.create :key => "art", :name => "Art / Photography"
Category.create :key => "sports", :name => "Sports"
Category.create :key => "music", :name => "Music"
Category.create :key => "events", :name => "Current Events"
Category.create :key => "comics", :name => "Comics / Animation"
Category.create :key => "kids", :name => "Baby / Kids / Family"
Category.create :key => "education", :name => "Education / Occupations"
Category.create :key => "place", :name => "Countries / Regions / Cities"
Category.create :key => "religion", :name => "Religion / Beliefs"
Category.create :key => "military", :name => "Military"
Category.create :key => "animals", :name => "Animals / Wildlife"
Category.create :key => "hobbies", :name => "Hobbies"
Category.create :key => "sex", :name => "Sex / Relationships"