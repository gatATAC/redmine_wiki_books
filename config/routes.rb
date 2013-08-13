# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html

resources :books
resources :book_chapters
#post 'books/edit', :to => 'books#edit'
#get 'books', :to => 'books#index'
#get 'books/new', :to => 'books#new'
post 'books/new', :to => 'books#new'
post 'books/:id/add_book_chapter', :to => 'books#add_book_chapter'
get 'book_chapters/edit', :to => 'book_chapters#edit'
get 'book_chapters/destroy', :to => 'book_chapters#destroy'