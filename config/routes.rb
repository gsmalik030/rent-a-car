Rails.application.routes.draw do
  resources :cars, only: %i[index show create update destroy]

  get 'latest', to: 'cars#latest'
  
  scope '/api' do
    scope '/v1' do
      resources :users, only: %i[index show create update destroy]

      post 'authentication', to: 'authentication#create'
      delete 'authentication', to: 'authentication#destroy'
    end
  end
end
