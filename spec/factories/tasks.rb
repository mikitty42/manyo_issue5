FactoryBot.define do
  factory :task do
      title { 'test_title'}
      content { 'test_content'}
      deadline { '2024-03-01' }
  end
end
