namespace :db do
  desc "Fill database with posts."
  task :add_posts => :environment do
    #Rake::Task['db:reset'].invoke

    #creating 16 posts each for first 11 users of hangout 
    admin_post = "Welcome to the MEST hangout!"
    admin = User.first

    User.all(:limit => 3).each do |user|

      #creating 1 more post by admin
      user.posts.create!(:content => admin_post, :poster_id =>admin)
      #user.posts.create!(:content => admin_post)

      #creating 15 more posts by current user
      3.times do
        post = Faker::Lorem.sentence(5)
        user.posts.create!(:content=> post, :poster_id=>user)
      end

    end
  end
end
