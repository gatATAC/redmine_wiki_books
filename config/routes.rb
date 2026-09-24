resources :books, except: :index do
  post :add_book_chapter, on: :member
end

resources :book_chapters, only: %i[show edit update destroy]

get 'projects/:project_id/books', to: 'books#index', as: :project_books
post 'projects/:project_id/books', to: 'books#create'
