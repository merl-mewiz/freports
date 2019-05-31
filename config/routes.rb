Rails.application.routes.draw do
    root 'welcome#index'
    resources :municipalitys, :consumers, :owners, only: [:index, :new, :edit, :create, :update, :destroy]
end
