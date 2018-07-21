class Board < ApplicationRecord
  has_many :cells
  has_many :user_actions
end
