require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
          visit new_task_path
          fill_in 'タイトル', with: 'test1'
          fill_in '内容',with: 'test1'
          click_on '登録する'
          expect(page).to have_content 'test1'
          expect(page).to have_content 'test1'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
          FactoryBot.create(:task,title: 'task')
          visit tasks_path
          expect(page).to have_content 'task'
      end
    end
  end
  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
           @task =FactoryBot.create(:task,title: 'test2',content: 'test2')
           visit task_path(@task.id)
           expect(page).to have_content 'test2'
           expect(page).to have_content 'test2'
       end
     end
  end
  context 'タスクが作成日時の降順に並んでいる場合' do
        it '新しいタスクが一番上に表示される' do
            FactoryBot.create(:task,title: 'task1')
            FactoryBot.create(:task,title: 'task2')
            FactoryBot.create(:task,title: 'task3')
            visit tasks_path
            task = all('.task_list')
            task_0 = task[0]
            expect(task_0).to have_content "task3"
      end
    end
end
