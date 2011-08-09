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
      networks = {:facebook =>first_name, :linkedin =>first_name,
                  :youtube => last_name, :twitter => last_name}
      user.network = Network.new
      user.network.update_attributes(networks)

      bio = Faker::Lorem.sentences(5).join(" ")
      music = Faker::Lorem.words(5).to_s.capitalize
      movies = Faker::Lorem.words(5).to_s.capitalize
      television = Faker::Lorem.words(5).to_s.capitalize
      books = Faker::Lorem.words(5).to_s.capitalize
      skillsets = Faker::Lorem.words(5).to_s.capitalize
      companies = Faker::Lorem.words(2).to_s.capitalize
      schools = Faker::Lorem.words(5).to_s.capitalize

      faq = {:bio => bio, :music => music, :movies => movies,
             :television => television, :boooks => books, :skillsets => skillsets,
             :companies => companies, :schools => schools}
      user.faq = Faq.new
      user.faq.update_attributes(faq)

      occupation = Faker::Lorem.words(1).to_s.capitalize
      spec = {:first_name => first_name, :last_name => last_name,
              :occupation => occupation}
      user.spec = Spec.new
      user.spec.update_attributes(spec)
    end
  end
end
