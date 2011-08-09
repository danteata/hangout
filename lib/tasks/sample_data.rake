namespace :db do
  desc "Fill database with 100 sample users"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    admin = User.create!(:name => "Dan Theta", 
                 :email =>"dan.theta@yahoo.co.uk",
                 :password => "foobar",
                 :password_confirmation => "foobar")
    admin.toggle!(:admin) #making the first user an admin 

#creating 99 more users of the network 
    99.times do |n|

      first_name = Faker::Name.first_name
      last_name = Faker::Name.last_name

      name = first_name
      email = "user-#{n+1}@meltwater.org"
      password = "password"
     user =  User.create!(:name => name,
                   :email => email,
                   :password => password,
                   :password_confirmation => password)
      #facebook_name = Faker::Name.first_name
      #twitter_name = Faker::Name.first_name
      #youtube_name = Faker::Name.first_name
      #linkedin_name = Faker::Name.first_name
      #networks = {:facebook => facebook_name, :linkedin =>linkedin_name,
                  #:youtube => youtube_name, :twitter => twitter_name}
      networks = {:facebook =>first_name.downcase, :linkedin =>first_name.downcase,
                  :youtube => last_name.downcase, :twitter => last_name.downcase}
      user.network = Network.new
      user.network.update_attributes(networks)

      bio = Faker::Lorem.sentences(5).join(" ")
      #music = Faker::Lorem.words(5).split.to_s.capitalize.join(", ").to_s
      musics = Faker::Lorem.words(8).map {|music| music.capitalize}.join(", ").to_s
      movies = Faker::Lorem.words(5).map {|movie| movie.capitalize}.join(", ").to_s
      companies = Faker::Lorem.words(2).map {|company| company.capitalize}.join(", ").to_s
      televisions = Faker::Lorem.words(5).map {|television| television.capitalize}.join(", ").to_s
      books = Faker::Lorem.words(5).map {|book| book.capitalize}.join(", ").to_s
      schools = Faker::Lorem.words(4).map {|school| school.capitalize}.join(", ").to_s
      skillsets = Faker::Lorem.words(5).map {|skillset| skillset.capitalize}.join(", ").to_s

      faq = {:bio => bio, :music => musics, :movies => movies,
             :television => televisions, :books => books, :skillsets => skillsets,
             :companies => companies, :schools => schools}
      user.faq = Faq.new
      user.faq.update_attributes(faq)

      occupations = Faker::Lorem.words(2).map {|occupation| occupation.capitalize}.join(", ").to_s
      #occupations.map {|occupation| occupation.capitalize}.join(", ").to_s
      spec = {:first_name => first_name, :last_name => last_name,
              :occupation => occupations}
      #user.spec = Spec.new
      #user.spec.update_attributes(spec)
    end
  end
end
