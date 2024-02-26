require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
          visit new_task_path
          fill_in 'タイトル', with: 'test1'
          fill_in '内容',with: 'test1'
          fill_in 'Deadline', with: '002024-05-01'
          select '着手', from:'task_status'
          click_on '登録する'
          expect(page).to have_content 'test1'
          expect(page).to have_content 'test1'
          expect(page).to have_content '2024-05-01'
          expect(page).to have_content '着手'
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
           @task =FactoryBot.create(:task,title: 'test2',content: 'test3',deadline: '2024-04-02')
           visit task_path(@task.id)
           expect(page).to have_content 'test2'
           expect(page).to have_content 'test3'
           expect(page).to have_content '2024-04-02'
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
  context '終了期限でソートする場合' do
        it '新しい終了期限が一番上に表示される' do
            FactoryBot.create(:task,deadline: '2024-03-01')
            FactoryBot.create(:task,deadline:'2024-04-01')
            FactoryBot.create(:task,deadline: '2024-02-01')
            visit tasks_path
            task = all('.task_list')
            task_0 = task[0]
            expect(task_0).to have_content "2024-04-01"
      end
    end
  describe '検索機能' do
      before do
        FactoryBot.create(:task, title: "task")
        #FactoryBot.create(:second_task, title: "sample")
      end
      context 'タイトルであいまい検索をした場合' do
            it "検索キーワードを含むタスクで絞り込まれる" do
              visit tasks_path
              fill_in 'task[title]',with: 'task'
              click_on '検索'
              expect(page).to have_content 'task'
            end
          end
          context 'ステータス検索をした場合' do
            it "ステータスに完全一致するタスクが絞り込まれる" do
            　select '未着手', from:'task_status'
              click_on '検索'
              expect(page).to have_content '未着手'
            end
          end
          context 'タイトルのあいまい検索とステータス検索をした場合' do
            it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
              # ここに実装する
            end
          end
        end
      end

