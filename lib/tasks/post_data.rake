namespace :db do
  desc "Fill database with posts."
  task :populate_posts => :environment do
    #Rake::Task['db:reset'].invoke

    #creating 16 posts each for first 11 users of hangout 
    #admin_post = "Welcome to the MEST hangout!"
    #admin = User.find(1)

    User.all(:limit => 11).each do |user|

      #creating 1 more post by admin
      #user.posts.create!(:content => admin_post, :poster_id =>admin.id)
      #user.posts.create!(:content => admin_post)

      #creating 15 more posts by current user
      15.times do
        post = Faker::Lorem.sentence(5)
        user.microposts.create!(:content=> post)
      end

    end
  end
end
