Rails.application.routes.draw do

  root 'welcome#home'
  get 'welcome/home', to: 'welcome#home'
  get 'welcome/addtoDB', to: 'welcome#addtoDB'
  get 'scrape/home', to: 'scrape#home'
end
