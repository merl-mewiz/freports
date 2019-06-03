Rails.application.routes.draw do
    root "reports#interaction_report"
    resources :municipalitys, :consumers, :owners, only: [:index, :new, :edit, :create, :update, :destroy]
    get "/report", to: "reports#interaction_report", as: "interaction_report"
end
