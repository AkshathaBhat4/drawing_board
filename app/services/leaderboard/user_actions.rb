module Leaderboard
  class UserActions
    attr_accessor :output, :top_users, :user_actions, :colors
    LIMIT=3

    def initialize
      @output = {}
    end

    def run
      begin
        fetch_top_users
        generate_output_structure
        fetch_top_user_actions
        fetch_all_colors
        process_output
      rescue Exception => e
        puts e.message.to_s
        puts e.backtrace.to_s
      end
      output
    end

    private

    def fetch_top_users
      @top_users = Hash[*User.top_users.first(LIMIT).map{|user| [user.id, user.name]}.flatten]
    end

    def fetch_top_user_actions
      @user_actions = User.top_user_actions(top_users.keys)
    end

    def fetch_all_colors
      color_ids = user_actions.map{|ua| ua.user_action_color}
      @colors = Color.where(id: color_ids).inject({}){|data, color| data[color.id] = {name: color.name, code: color.code};data;}
    end

    def process_output
      user_actions.each do |user_action|
        @output[user_action.name] << user_action_details(user_action)
      end
    end

    def user_action_details(user_action)
      color_id = user_action.user_action_color
      OpenStruct.new({color_name: get_color(color_id, :name), color_code: get_color(color_id, :code), count: user_action.user_action_count})
    end

    def generate_output_structure
      top_users.values.each do |user|
        @output[user] = []
      end
    end

    def get_color(id, type)
      colors[id][type.to_sym]
    end
  end
end
