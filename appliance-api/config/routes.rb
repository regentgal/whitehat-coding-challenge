Rails.application.routes.draw do

  root to: "report#index"

  post '/report', to: "report#show"

end
