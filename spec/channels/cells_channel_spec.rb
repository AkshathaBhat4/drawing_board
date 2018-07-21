require "rails_helper"

RSpec.describe CellsChannel, type: :channel do
  let(:user) { User.create}
  let(:cell) { Cell.first}
  before do
    stub_connection user_id: user.id
  end

  it "subscribes to a stream when cell id is provided" do
    subscribe(cell_id: cell.id)
    expect(subscription).to be_confirmed
    expect(streams).to include('cells')
  end
end
