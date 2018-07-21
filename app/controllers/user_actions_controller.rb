class UserActionsController < ApplicationController
  def user_color
    response_data, status = if @user.update_color(color_params)
      [{color_id: @user.color_id}, :accepted]
    else
      [{message: @user.error_message}, :not_acceptable]
    end
    render json: response_data.as_json, status: status
  end

  def cell_color
    response_data, status = if @user.update_cell_color(cell_params)
      send_cell_data
      send_leaderboard_data
      [{}, :accepted]
    else
      [{message: @user.error_message}, :not_acceptable]
    end

    render json: response_data.as_json, status: status

  end

  private
    def color_params
      params.require(:user).permit(:color_id)
    end

    def cell_params
      params.require(:user).permit(:cell_id)
    end

    def send_cell_data
      ActionCable.server.broadcast 'cells',
        color_code: @user.color_code,
        cell_id: cell_params[:cell_id]
    end

    def send_leaderboard_data
      @leaderboard = Leaderboard::UserActions.new.run
      ActionCable.server.broadcast('leaderboard',
        html: html(@leaderboard)
      )
    end

    def html(message)
      ApplicationController.render(partial: 'pages/home/leaderboard',
                                   locals: { leaderboard: @leaderboard })
    end
end
