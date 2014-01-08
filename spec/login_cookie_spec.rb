require 'spec_helper'

describe 'login cookie' do
  before :each do
    User.delete_all
    user
  end

  let(:user) { User.create(email: 'test@example.com', password: 'test') }

  it 'creates login cookie after user logging in' do
    visit '/users/sign_in'
    login
    assert_logged_in
    cookies['user_token'].should_not be_nil
  end

  it 'logs user out once user cookie has been deleted' do
    visit '/users/sign_in'
    login
    assert_logged_in
    delete_cookie('user_token')
    visit '/'
    page.should have_content "You need to sign in or sign up before continuing"
  end

  it 'allows user to log in with across multiple subdomains' do
    visit 'http://au.localtest.me:5000/users/sign_in'
    login
    assert_logged_in
    visit 'http://nz.localtest.me:5000/'
    assert_logged_in
  end

  it 'clears login token once user logs out' do
    visit '/users/sign_in'
    login
    assert_logged_in
    visit '/users/sign_out'
    cookies['user_token'].should be_nil
  end

  def assert_logged_in
    page.should have_content "Logged in"
  end

  def assert_login_path
    page.current_url.should include "/users/sign_in"
  end
end

