namespace :db do
  desc "Fill database with 100 sample users"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    User.create!(:name => "Dan Theta", 
                 :email =>"dan@yahoo.com",
                 :password => "foobar",
                 :password_confirmation => "foobar")
    99.times do |n|
      name = Faker::Name.name
      email = "user-#{n+1}@meltwater.org"
      password = "password"
      User.create!(:name => name,
                   :email => email,
                   :password => password,
                   :password_confirmation => password)
    end
  end
end
