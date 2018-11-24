Rails.application.routes.draw do
  devise_for :users

  root 'restaurant_table_management#index_restaurant'
  delete 'restaurant_table_management/delete_restaurant/:restaurant_id' => 'restaurant_table_management#delete_restaurant'
  patch 'restaurant_table_management/update_restaurant/:restaurant_id' =>'restaurant_table_management#update_restaurant'
  get 'restaurant_table_management/edit_restaurant/:restaurant_id' => 'restaurant_table_management#edit_restaurant'
  get 'restaurant_table_management/index_restaurant'
  get 'restaurant_table_management/new_restaurant'
  post 'restaurant_table_management/create_restaurant'
  get 'restaurant_table_management/index_table/:restaurant_id' => 'restaurant_table_management#index_table'
  post 'restaurant_table_management/create_table/:restaurant_id' => 'restaurant_table_management#create_table'
  get 'restaurant_table_management/new_table/:restaurant_id' => 'restaurant_table_management#new_table'
  get 'restaurant_table_management/index_schedule/:restaurant_id/:table_id'=> 'restaurant_table_management#index_schedule'
  get 'restaurant_table_management/new_schedule/:restaurant_id/:table_id' => 'restaurant_table_management#new_schedule'
  post 'restaurant_table_management/create_schedule/:restaurant_id/:table_id' => 'restaurant_table_management#create_schedule'
  patch 'restaurant_table_management/seated/:table_id' => 'restaurant_table_management#seated'
  patch 'restaurant_table_management/out/:table_id' => 'restaurant_table_management#out'
  patch 'restaurant_table_management/start/:schedule_id' => 'restaurant_table_management#start'
  patch 'restaurant_table_management/end/:schedule_id' => 'restaurant_table_management#end'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
