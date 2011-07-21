
require 'spec_helper'

describe PagesController do
  render_views

  describe "Signed-in GET 'home'" do
    before(:each) do
      @user = Factory(:user)
      test_sign_in(@user)
      other_user = Factory(:user, email: Factory.next(:email))
      other_user.follow!(@user)
    end

    it "Should have the right follower/following counts" do
      get :home
      response.should have_selector("a", href: following_user_path(@user),
                                    content: "0 following")
      response.should have_selector("a", href: followers_user_path(@user),
                                    content: "1 follower")
    end

    it "Should have correct pluralization for none" do
      get 'home'
      response.should have_selector("span", :class => "microposts" ,content: "0 microposts")
    end

    it "Should have corret pluralization for one" do
      Factory(:micropost, user: @user, content: "Baz quux")
      get 'home'
      response.should have_selector("span", :class => "microposts", content: "1 micropost")
    end

    it "Should have corret pluralization for many" do
      Factory(:micropost, user: @user, content: "Baz quux")
      Factory(:micropost, user: @user, content: "Lorem ipsum")
      get 'home'
      response.should have_selector("span", :class => "microposts", content: "2 microposts")
    end
  end
end
