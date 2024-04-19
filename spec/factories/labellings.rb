FactoryBot.define do
  factory :labellings do
      association :label
      association :task
  end
end
