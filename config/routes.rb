Rails.application.routes.draw do
    root 'welcome#index'
    resources :municipalitys
    resources :consumers, :owners, only: [:index]
end
