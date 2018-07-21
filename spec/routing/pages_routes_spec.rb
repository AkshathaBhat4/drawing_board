require 'rails_helper'

describe 'Pages Routes Spec', type: :routing do
  describe 'All Landing Pages' do
    it { expect(get: '/').to route_to(controller: 'pages', action: 'home') }
  end
end
