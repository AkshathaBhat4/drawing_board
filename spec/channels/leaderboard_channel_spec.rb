require 'rails_helper'

RSpec.describe LeaderboardChannel, type: :channel do
  let(:user) { User.create}
  let(:cell) { Cell.first}
  before do
    stub_connection user_id: user.id
  end

  it "subscribes to a stream when room id is provided" do
    subscribe(cell_id: cell.id)
    expect(subscription).to be_confirmed
    expect(streams).to include("leaderboard")
  end
end
