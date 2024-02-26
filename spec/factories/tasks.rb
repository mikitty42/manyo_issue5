FactoryBot.define do
  factory :task do
      title { 'test_title'}
      content { 'test_content'}
      deadline { '2024-03-01' }
      status { '完了'}
  end
  
  factory :second_task, class: Task do
      title { 'Factoryで作ったデフォルトのタイトル２' }
      content { 'Factoryで作ったデフォルトのコンテント２' }
      deadline { '2024-02-28'}
      status { '着手'}
    end
end
