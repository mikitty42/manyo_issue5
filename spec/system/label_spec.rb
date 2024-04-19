
require 'rails_helper'
RSpec.describe 'ラベル機能', type: :system do
    
    let(:user) { FactoryBot.create(:user) }
    let(:task) { FactoryBot.create(:task)}
    let(:label) { FactoryBot.create(:label) }
    before do
        visit new_session_path
        fill_in 'Email', with: 'aaa@example.com'
        fill_in 'Password', with: 'aaaaaa'
        click_on 'Log in'
    end
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したラベルが表示される' do

          visit new_session_path
          fill_in 'Email', with: 'aaa@example.com'
          fill_in 'Password', with: 'aaaaaa'
          click_on 'Log in'
          visit tasks_path
          click_link 'Taskを新規作成する'
          fill_in 'タイトル', with: 'test'
          fill_in '内容', with: 'test'
          fill_in 'Deadline', with: '002023-01-11'
          select "未着手", from: "task[status]"
          select "高", from: "task[priority]"
          check "ラベルA",match: :first
          click_button '登録する'
          expect(page).to have_content 'ラベルA'
          
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのラベル一覧が表示される' do

          visit new_session_path
          fill_in 'Email', with: 'aaa@example.com'
          fill_in 'Password', with: 'aaaaaa'
          click_on 'Log in'
          
          visit tasks_path
          expect(page).to have_content 'ラベルA'
      end
    end
  end
  describe 'ラベル詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当ラベルの内容が表示される' do
  
           visit new_session_path
           fill_in 'Email', with: 'aaa@example.com'
           fill_in 'Password', with: 'aaaaaa'
           click_on 'Log in'
           visit tasks_path
           click_link 'Taskを新規作成する'
           fill_in 'タイトル', with: 'test'
           fill_in '内容', with: 'test'
           fill_in 'Deadline', with: '002023-01-11'
           select "未着手", from: "task[status]"
           select "高", from: "task[priority]"
           check "ラベルA",match: :first
           click_button '登録する'
           visit tasks_path
           expect(page).to have_content 'ラベルA'
       end
     end
  end


  describe '検索機能' do
      context 'ステータス検索をした場合' do
          it "ステータスに完全一致するタスクが絞り込まれる" do
              visit new_session_path
              fill_in 'Email', with: 'aaa@example.com'
              fill_in 'Password', with: 'aaaaaa'
              click_on 'Log in'
              visit tasks_path
              click_link 'Taskを新規作成する'
              fill_in 'タイトル', with: 'test'
              fill_in '内容', with: 'test'
              fill_in 'Deadline', with: '002023-01-11'
              select "未着手", from: "task[status]"
              select "高", from: "task[priority]"
              check "ラベルA",match: :first
              click_button '登録する'
              visit tasks_path
              select "ラベルA",match: :first,from: "task_label_id"
              click_on '検索'
              expect(page).to have_content 'ラベルA'
          end
      end
    end
end
