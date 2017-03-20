class Chef < ActiveRecord
  validates :name, presence: true
end