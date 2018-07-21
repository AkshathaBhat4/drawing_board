require 'faker'
class User < ApplicationRecord
  has_many :cells
  has_many :user_actions
  belongs_to :color, required: false
  validates_presence_of :name
  before_validation :generate_random_name

  scope :top_user_actions, -> (user_ids){ where(id: user_ids).joins(:user_actions).select("users.name, user_actions.color_id AS user_action_color, SUM(user_actions.action_count) AS user_action_count").group("users.name, user_actions.color_id").order("user_action_count desc")}

  scope :top_users, -> { joins(:user_actions).select("users.id, users.name, SUM(user_actions.action_count) AS user_action_count").group("users.id,users.name").order("user_action_count desc").distinct}

  delegate :name, to: :color, prefix: true, allow_nil: true
  delegate :code, to: :color, prefix: true, allow_nil: true

  def generate_random_name
    self.name = Faker::Name.name if self.name.blank?
  end

  def error_message
    self.errors.full_messages.join(', ')
  end

  def update_color(new_color)
    self.color_id = new_color[:color_id]
    self.save
  end

  def update_cell_color(cell_params)
    cell = Cell.find_by_id cell_params[:cell_id]
    return false if cell.blank?
    cell.user = self
    cell.color = self.color
    cell.save
  end

  def color?(current_color)
    self.color == current_color
  end
end
