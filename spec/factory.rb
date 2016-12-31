FactoryGirl.define do
  factory :user do
    sequence(:first_name){ |n| "John#{n}" }
    last_name "Doe"
    email { "#{first_name}@example.com" }
    password "password"
  end

  factory :friend_ship do
  	user_id 1
  	friends_id 2
  	securitylevel1_id 1
  	securitylevel2_id 2
  	state "done"
  end

  factory :activity_feed do
    targetable_id 1
    status "created"
    targetable_type "Post"
    user_id 1
    securitylevel_id 1
  end

  factory :post do
    user_id 1
    title "some title"
    body "some_body"
  end

  factory :photo do
    user_id 1
    caption "some caption"
  end

  factory :album do
    user_id 1
  end

  factory :security_setting do
    securable_id 1
    securable_type "Post"
    securitylevel_id 1
  end
end