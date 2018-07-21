class Cell < ApplicationRecord
  belongs_to :color, optional: true
  belongs_to :user, optional: true
  belongs_to :board
  has_many :user_actions
  scope :order_cells , -> { order('x_axis,y_axis') }
  delegate :code, to: :color, prefix: true, allow_nil: true
  delegate :name, to: :user, prefix: true, allow_nil: true
  after_update_commit	:update_user_action

  def self.ordered_cells
    order_cells.inject({}) {|data, cell|
      data[cell.x_axis] = [] if data[cell.x_axis].blank?
      data[cell.x_axis] << cell
      data
    }
  end

  def title
    color.present? ? "Name : #{user_name} \nTime : #{updated_at.strftime('%d/%b/%Y %H:%M %p')}" : ''
  end

  def update_user_action
    user_action = UserAction.where(user_id: self.user_id, cell_id: self.id, board_id: self.board_id, color_id: self.color_id).first_or_create
    user_action.action_count += 1
    user_action.save
  end
end
