
require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
        before do
            user_a = FactoryBot.create(:user, name: 'bbb')
            @task =FactoryBot.create(:task,title: '最初のタスク',user:user_a)
            @task2 =FactoryBot.create(:task,title: '２番目のタスク',user:user_a)
            @task3 =FactoryBot.create(:task,title: '３番目のタスク',priority: '中',deadline:"2024-04-01",user:user_a)
        end

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
          visit new_session_path
          fill_in 'Email', with: 'aaa@example.com'
          fill_in 'Password',with: 'aaaaaa'
          click_on 'Log in'
          visit new_task_path
          fill_in 'タイトル', with: 'test1'
          fill_in '内容',with: 'test1'
          fill_in 'Deadline', with: '002024-05-01'
          select '着手', from:'task_status'
          select '高', from:'task_priority'
          click_on '登録する'
          expect(page).to have_content 'test1'
          expect(page).to have_content 'test1'
          expect(page).to have_content '2024-05-01'
          expect(page).to have_content '着手'
          expect(page).to have_content '高'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
          visit new_session_path
          fill_in 'Email', with: 'aaa@example.com'
          fill_in 'Password',with: 'aaaaaa'
          click_on 'Log in'
          visit new_task_path
          #FactoryBot.create(:task,title: 'test1')
          visit tasks_path
          expect(page).to have_content '最初のタスク'
      end
    end
  end
  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
           visit task_path(@task.id)
           expect(page).to have_content '最初のタスク'
       end
     end
  end
  context 'タスクが作成日時の降順に並んでいる場合' do
        it '新しいタスクが一番上に表示される' do
            visit new_session_path
            fill_in 'Email', with: 'aaa@example.com'
            fill_in 'Password',with: 'aaaaaa'
            click_on 'Log in'
            visit tasks_path
            task = all('.task_list')
            task_0 = task[0]
            expect(task_0).to have_content '３番目のタスク'
      end
    end
  context '優先順位でソートする場合' do
        it '優先順位が高いタスクが一番上に表示される' do
            visit new_session_path
            fill_in 'Email', with: 'aaa@example.com'
            fill_in 'Password',with: 'aaaaaa'
            click_on 'Log in'
            visit tasks_path
            task = all('.task_list')
            task_0 = task[0]
            expect(task_0).to have_content "中"
      end
    end
  context '終了期限でソートする場合' do
        it '終了期限が遅いタスクが一番上に表示される' do
            visit new_session_path
            fill_in 'Email', with: 'aaa@example.com'
            fill_in 'Password',with: 'aaaaaa'
            click_on 'Log in'
            visit tasks_path
            task = all('.task_list')
            task_0 = task[0]
            expect(task_0).to have_content "2024-04-01"
      end
    end
  describe '検索機能' do

      context 'タイトルであいまい検索をした場合' do
            it "検索キーワードを含むタスクで絞り込まれる" do
            visit new_session_path
            fill_in 'Email', with: 'aaa@example.com'
            fill_in 'Password',with: 'aaaaaa'
            click_on 'Log in'
              visit tasks_path
              fill_in 'task[title]',with: '最初のタスク'
              click_on '検索'
              expect(page).to have_content '最初のタスク'
            end
          end
          context 'ステータス検索をした場合' do
            it "ステータスに完全一致するタスクが絞り込まれる" do
                visit new_session_path
                fill_in 'Email', with: 'aaa@example.com'
                fill_in 'Password',with: 'aaaaaa'
                click_on 'Log in'
              visit tasks_path
              select "完了", from: "task_status"
              click_on '検索'
              expect(page).to have_content '完了'
            end
          end
          context 'タイトルのあいまい検索とステータス検索をした場合' do
            it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
                visit new_session_path
                fill_in 'Email', with: 'aaa@example.com'
                fill_in 'Password',with: 'aaaaaa'
                click_on 'Log in'
                visit tasks_path
                fill_in 'task[title]',with: '最初のタスク'
                select "完了", from: "task_status"
                click_on '検索'
                expect(page).to have_content '最初のタスク'
                expect(page).to have_content '完了'
            end
          end
        end
      end

