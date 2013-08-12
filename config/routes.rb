resources :books
resources :book_chapters
#get 'books', :to => 'books#index'
#get 'books/new', :to => 'books#new'
#get 'books/:id', :to => 'books#show'
#post 'books/:id/edit', :to => 'books#edit'
#post 'books/:id/destroy', :to => 'books#destroy'
post 'books/:id/add_book_chapter', :to => 'books#add_book_chapter'
