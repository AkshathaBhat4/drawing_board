require 'rails_helper'

RSpec.describe UserActionsController, type: :controller do
  describe "GET #user_color" do
    let(:color) { Color.first }
    let(:params) {{ user: { color_id: color.id} }}
    it "returns http success" do
      post :user_color, params: params
      expect(response).to be_successful
    end

    it "returns json response" do
      post :user_color, params: params
      parsed_response = JSON.parse(response.body)
      expect(parsed_response).to eq ({'color_id' => color.id})
    end
  end

  describe "GET #cell_color" do
    let(:color) { Color.first }
    let(:cell) { Cell.first }
    let(:cell_params) {{ user: { cell_id: cell.id} }}
    let(:color_params) {{ user: { color_id: color.id} }}

    before(:each) do
      post :user_color, params: color_params
    end
    it "returns http success" do
      post :cell_color, params: cell_params
      expect(response).to be_successful
    end

    it "returns json response" do
      post :cell_color, params: cell_params
      parsed_response = JSON.parse(response.body)
      # expect(parsed_response).to eq ({'cell_id' => cell.id.to_s, 'color_code' => color.code})
      expect(parsed_response).to eq ({})
    end

    it "to brodcast CellChannel" do
      expect { post :cell_color, params: cell_params }.to have_broadcasted_to("cells").from_channel(CellsChannel).with(cell_id: cell.id.to_s, color_code: color.code)
    end

    it "to brodcast LeaderboardChannel" do
      expect { post :cell_color, params: cell_params }.to have_broadcasted_to("leaderboard").from_channel(LeaderboardChannel).with { |data|
        expect(data['html']).to be_kind_of String
      }
    end
  end
end
