Dummy::Application.routes.draw do
 resources :sample_objects do
   match 'inherited/:id' => 'sample_objects#show_inherited', on: :collection
 end
end
