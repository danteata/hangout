Factory.define :user do |user|
  user.name "dantheta"
  user.email "dan@yahoo.com"
  user.password "foobar"
  user.password_confirmation "foobar"
end

Factory.sequence :email do |n|
  "user-#{n}@meltwater.org"
end

Factory.define :micropost do |micropost|
  micropost.content "Some micropost content"
  micropost.association :user
end
