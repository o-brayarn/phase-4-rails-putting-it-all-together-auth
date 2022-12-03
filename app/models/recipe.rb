class Recipe < ApplicationRecord
  validates :title, presence: true
  validates :instructions, length: { minimum: 50 }
  validates :minutes_to_complete, presence: true
  belongs_to :user
end
