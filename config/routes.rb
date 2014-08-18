Rails.application.routes.draw do
  root 'whiteboard#index'
  post 'whiteboard/auth' => 'whiteboard#auth'
end
