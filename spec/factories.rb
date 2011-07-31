Factory.define :user do |user|
  user.name "dantheta"
  user.email "dan@yahoo.com"
  user.password "foobar"
  user.password_confirmation "foobar"
end

Factory.sequence :email do |n|
  "user-#{n}@meltwater.org"
end

Factory.define :spec do |spec|
  spec.first_name   "Foo"
  spec.last_name    "Bar"
  spec.gender       "Male"
  spec.occupation   "Developer"
  spec.city         "Accra"
  spec.association  :user
end

Factory.define :micropost do |micropost|
  micropost.content "Ipsum something"
  micropost.association  :user
end
