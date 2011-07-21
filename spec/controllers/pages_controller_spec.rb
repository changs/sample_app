
require 'spec_helper'

describe PagesController do
  render_views

  describe "GET 'home'" do
    before(:each) do
      @user = Factory(:user)
      test_sign_in(@user)
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
