FactoryBot.define do
  factory :user do
    id                              {1}
    name                            {'aaa'}
    email                           {'aaa@example.com'}
    password                        {'aaaaaa'}
    password_confirmation           {'aaaaaa'}
    admin                           { false}
  end
  
  factory :second_user, class: User do
    id                              {2}
    name                            {'bbb'}
    email                           {'bbb@example.com'}
    password                        {'bbbbbb'}
    password_confirmation           {'bbbbbb'}
    admin                           { false}
  end
  
  factory :third_user, class: User do
    id                              {3}
    name                            {'ccc'}
    email                           {'ccc@example.com'}
    password                        {'cccccc'}
    password_confirmation           {'cccccc'}
    admin                           { true}
  end
end

