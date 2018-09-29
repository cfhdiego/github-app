class Repository < ApplicationRecord
  paginates_per 5

  validates :name, :language, :github_url, presence: true
end
