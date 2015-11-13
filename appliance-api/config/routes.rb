Rails.application.routes.draw do
  root to: 'report#report'

  get '/api/report-data', to: 'report#report_data'
end
