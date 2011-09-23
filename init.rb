require 'redmine'

Redmine::Plugin.register :redmine_wiki_books do
  name 'Redmine Wiki Books plugin'
  author 'Txinto Vaz'
  description 'This is a plugin for Redmine that allows the user to read books written in wiki pages'
  version '0.0.2'
  url 'http://gatatac.net/projects/redminewikibooks'
  author_url 'http://gatatac.net/users/3'

   permission :view_books, :books => [:index,:show]
   permission :manage_books, {:books => [:new,:create,:add_book_chapter,:edit,:destroy],:book_chapters => [:new,:create,:add_book_chapter,:edit,:destroy]}
   menu :project_menu, :books, { :controller => 'books', :action => 'index' }, :caption => :label_book_plural, :after => :activity, :param => :project_id
   permission :view_book_chapters, :book_chapters => [:index,:show]

end
