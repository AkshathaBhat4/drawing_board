class UserAction < ApplicationRecord
  belongs_to :user
  belongs_to :board
  belongs_to :cell
  belongs_to :color
end
