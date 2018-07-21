class PagesController < ApplicationController
  before_action :fetch_cells, only: [:home]
  before_action :fetch_colors, only: [:home]
  before_action :fetch_leaderboard, only: [:home]
  def home
  end

  private
  def fetch_cells
    @cells = Cell.ordered_cells
  end

  def fetch_colors
    @colors = Color.all
  end

  def fetch_leaderboard
    @leaderboard = Leaderboard::UserActions.new.run
  end
end
