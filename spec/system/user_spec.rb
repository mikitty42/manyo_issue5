require 'rails_helper'
RSpec.describe 'ユーザー管理機能', type: :system do
    before do
        @user = FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com')
        FactoryBot.create(:task, title: '最初のタスク')
          visit new_session_path
          fill_in 'Email', with: 'a@example.com'
          fill_in 'Password', with: 'password'
          click_on 'Log in'
        end
    context 'ユーザー登録' do
      it 'ユーザーの新規登録が出来る' do
          visit new_user_path
          fill_in '名前', with: 'ccc'
          fill_in 'メールアドレス', with: 'ccc@example.com'
          fill_in 'パスワード', with: 'cccccc'
          fill_in '確認用パスワード', with: 'cccccc'
          click_on 'Create my account'
          expect(page).to have_content 'ユーザーの登録に成功しました'
          
      end
    end
    it 'ユーザがログインせずタスク一覧画面に飛ぼうとしたとき、ログイン画面に遷移すること' do
        visit root_path
        expect(current_path).to eq new_session_path
    end
    context 'セッション機能' do
        it 'ログインが出来る' do
            visit new_session_path
            fill_in 'Email',with: 'a@example.com'
            fill_in 'Password', with: 'aaaaaa'
            click_on 'Log in'
            expect(page).to have_content 'ログインに成功しました'
        end
            it '自分の詳細画面に飛べる' do
                visit new_session_path
                fill_in 'Email', with: 'a@example.com'
                fill_in 'Password', with: 'aaaaaa'
                click_on 'Log in'
                visit user_path(@user.id)
                expect(current_path).to eq user_path(@user.id)
        end
        it '一般ユーザが他人の詳細画面に飛ぶとタスク一覧画面に遷移すること' do
            visit new_session_path
            fill_in 'Email',with: 'a@example.com'
            fill_in 'Password', with: 'aaaaaa'
            click_on 'Log in'
            visit user_path(2)
            expect(page).to have_content '権限がありません'
            expect(current_path).to eq tasks_path
        end
        it 'ログアウトが出来る' do
            visit new_session_path
            fill_in 'Email',with: 'a@example.com'
            fill_in 'Password', with: 'aaaaaa'
            click_on 'Log in'
            click_on 'Logout'
            expect(page).to have_content 'ログアウトしました'
        end
    end
    context '管理画面のテスト' do
        before do
            user_c = FactoryBot.create(:third_user, name: 'ユーザーC', email: 'c@example.com')
            visit new_session_path
            fill_in 'Email',with: 'c@example.com'
            fill_in 'Password', with: 'cccccc'
            click_on 'Log in'
        end
        it '管理ユーザは管理画面にアクセスできること' do

            visit admin_users_path
            expect(current_path).to eq admin_users_path
        end
        it '一般ユーザは管理画面にアクセスできないこと' do
            visit new_session_path
            fill_in 'Email',with: 'a@example.com'
            fill_in 'Password', with: 'aaaaaa'
            click_on 'Log in'
            visit admin_users_path
            expect(page).to have_content '管理者以外はアクセス出来ません'
            expect(current_path).to eq root_path
        end
        it '管理ユーザはユーザの新規登録ができること' do

            visit admin_users_path
            click_on 'ユーザーの新規作成'
            fill_in '名前', with: 'test2'
            fill_in 'メールアドレス',with: 'test2@example.com'
            fill_in 'パスワード', with: 'test2t'
            fill_in '確認用パスワード', with: 'test2t'
            click_on 'Create my account'
            expect(page).to have_content 'ユーザーの登録に成功しました'
        end
        it '管理ユーザはユーザの詳細画面にアクセスできること' do
            visit new_session_path
            fill_in 'Email',with: 'ccc@example.com'
            fill_in 'Password', with: 'cccccc'
            click_on 'Log in'
            visit admin_users_path
            click_link '詳細',match: :first
            expect(page).to have_content 'aaaのページ'
        end
        it '管理ユーザはユーザの編集画面からユーザを編集できること' do
            visit new_session_path
            fill_in 'Email',with: 'ccc@example.com'
            fill_in 'Password', with: 'cccccc'
            click_on 'Log in'
            visit admin_users_path
            click_link '編集',match: :first
            fill_in 'パスワード', with: 'dddddd'
            fill_in '確認用パスワード', with: 'dddddd'
            click_on 'Create my account'
            expect(page).to have_content '権限がありません'
            
        end
        it '管理ユーザはユーザの削除をできること' do
            visit new_session_path
            fill_in 'Email',with: 'ccc@example.com'
            fill_in 'Password', with: 'cccccc'
            click_on 'Log in'
            visit admin_users_path
            click_link '削除',match: :first
            page.driver.browser.switch_to.alert.accept
            expect(page).to have_content 'ユーザーを削除しました'
        end
    end
end


