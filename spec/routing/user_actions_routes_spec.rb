require 'rails_helper'

describe 'User Actions Routes Spec', type: :routing do
  describe 'All Post Requests' do
    it { expect(post: '/user_actions/user_color').to route_to(controller: 'user_actions', action: 'user_color', format: :json) }
    it { expect(post: '/user_actions/cell_color').to route_to(controller: 'user_actions', action: 'cell_color', format: :json) }
  end
end
