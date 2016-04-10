class Book < ActiveRecord::Base
  unloadable # <= That's the ticket!

  self.table_name ="wiki_books"

  belongs_to :project
#  has_many :book_chapters, :order => :order_float
#  :order is deprecated in Rails 4
  has_many :book_chapters, -> { order(:order_float) }
  acts_as_attachable :delete_permission => :manage_books

  acts_as_searchable :columns => ['title', "#{table_name}.description"]
  acts_as_event :title => Proc.new {|o| "#{l(:label_book)}: #{o.title}"},
    :author => Proc.new {|o| (a = o.book_chapters.find(:first)) ? a.author : nil },
    :url => Proc.new {|o| {:controller => 'books', :action => 'show', :id => o.id}}
  acts_as_activity_provider :scope => includes(:project)

  validates_presence_of :project, :title
  validates_length_of :title, :maximum => 60

  scope :visible, lambda {|*args| { :include => :project,
      :conditions => Project.allowed_to_condition(args.shift || User.current, :view_books, *args) } }

  def visible?(user=User.current)
    !user.nil? && user.allowed_to?(:view_books, project)
  end

  def after_initialize
    if new_record?
      #self.category ||= bookCategory.default
    end
  end

  def book_chapters_deletable?(user=User.current)
    (respond_to?(:visible?) ? visible?(user) : true) &&
      user.allowed_to?(:manage_books, self.project)
  end

  def book_chapters_visible?(user=User.current)
    !user.nil? && user.allowed_to?(:view_books, project)
  end

  def updated_on
    unless @updated_on
      a = book_chapters.find(:first, :order => 'created_on DESC')
      @updated_on = (a && a.created_on) || created_on
    end
    @updated_on
  end
end
