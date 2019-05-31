Rails.application.routes.draw do
    root 'welcome#index'
    resources :municipalitys, :consumers, :owners, only: [:index, :new, :edit, :create, :update, :destroy]
    get "/reports/table", to: "reports#table_view", as: "report_table_view"
end
