#encoding: utf-8
FocusFruit::Application.routes.draw do
  devise_for :users,
    :controllers => {
    :sessions => :sessions
  }
  devise_scope :user do
    get "/users/ruler" => "users#ruler"
    get "/users/sign_in",  :to => "sessions#new",     :as => :new_user_session
    get "/users/switch",   :to => "sessions#new",     :as => :switch_user_session
    get "/users/sign_out", :to => "sessions#destroy", :as => :destroy_user_session
    get "/users/logout",   :to => "sessions#destroy"
  end


  resources :customers
  resources :orders do
    resources :items
  end

  match "/shop" => "fruit_zones#index"
  resources :fruit_zones do
    collection do
      post "upload"
      get  "admin"
    end
    resources :fruits
  end

  #处理weixin消息
  scope :path => "/weixin", :via => :post, :defaults => {:format => "xml"} do
    #接收事件推送
    root :to => "weixin#event", :constraints => Weixin::Router.new(:type => "event")
    #接收普通消息
    root :to => "weixin#shop", :constraints => Weixin::Router.new(:type => "text", :content=>/^1/)
    root :to => "weixin#help", :constraints => Weixin::Router.new(:type => "text")

    root :to => "weixin#receive", :constraints => Weixin::Router.new(:type => "image")
    root :to => "weixin#receive", :constraints => Weixin::Router.new(:type => "voice")
    root :to => "weixin#receive", :constraints => Weixin::Router.new(:type => "video")
    root :to => "weixin#receive", :constraints => Weixin::Router.new(:type => "location")
    root :to => "weixin#receive", :constraints => Weixin::Router.new(:type => "link")
    root :to => "weixin#other" #没有被处理到的事件
  end
  match "/weixin" => "weixin#authen", :via => :get
  match "/weixin/:id" => "weixin#show", :as => :weixin

  root :to => "fruit_zones#index"


  match ":controller(/:action(/:id))(.:format)"
end
