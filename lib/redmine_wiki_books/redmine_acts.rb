# frozen_string_literal: true

module RedmineWikiBooks
  module RedmineActs
    EXTENSIONS = %w[attachable activity_provider event searchable].freeze

    module_function

    def install!
      EXTENSIONS.each do |extension|
        require Rails.root.join("lib/plugins/acts_as_#{extension}/lib/acts_as_#{extension}").to_s
      end

      include_once(Redmine::Acts::Attachable)
      include_once(Redmine::Acts::ActivityProvider)
      include_once(Redmine::Acts::Event)
      include_once(Redmine::Acts::Searchable)
    end

    def include_once(extension)
      ApplicationRecord.include(extension) unless ApplicationRecord < extension
    end
  end
end
