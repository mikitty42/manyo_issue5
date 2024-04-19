FactoryBot.define do
  factory :task do
      title { 'test_title'}
      content { 'test_content'}
      deadline { '2024-03-01' }
      status { '完了'}
      priority { '高'}

      
      #after(:build) do |task|
            #label = create(:label)
            #task.labellings << build(:labelling, task: task, label: label)
          #end
  end
  
  factory :second_task, class: Task do
      title { 'Factoryで作ったデフォルトのタイトル２' }
      content { 'Factoryで作ったデフォルトのコンテント２' }
      deadline { '2024-02-28'}
      status { '着手'}
      priority { '中'}

    end

end
