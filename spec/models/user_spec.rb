require 'rails_helper'

RSpec.describe User, type: :model do
  describe "User validation" do
    context "user name is present" do
      it "check same name is retained" do
        user = User.create(name: 'batman')
        expect(user).to be_valid
        expect(user.name).to eq("batman")
      end

      it "random name is assigned to the user" do
        user = User.create
        expect(user).to be_valid
        expect(user.name).not_to be_empty
      end

      it "two random names assigned to the user are not same" do
        user1 = User.create
        user2 = User.create
        # expect(user).to be_valid
        expect(user1.name).not_to eq(user2.name)
      end
    end
  end

  describe "Validate Color" do
    before(:each) do
      @user = User.create
    end
    let(:color) { Color.first }
    let(:cell) { Cell.first }

    context "User Color" do
      it "By default user color should be blank" do
        expect(@user.color).to be nil
      end

      it "update_color method should update the specified color" do
        @user.update_color(color_id: color.id)
        expect(@user.color).to eq color
      end
    end

    context "Cell Color" do
      it "update_cell_color method should update the specified cell color" do
        @user.update_color(color_id: color.id)
        @user.update_cell_color(cell_id: cell.id)
        cell.reload
        expect(@user.cells.count).to eq 1
        expect(cell.color).to eq color
      end
    end
  end

  describe "#color?" do
    let(:color) { Color.first }
    let(:different_color) { Color.last }

    before(:each) do
      @user = User.create
      @user.update_color(color_id: color.id)
    end

    context "when color is same as user color" do
      it "it returns true" do
        expect(@user.color?(color)).to be true
      end
    end

    context "when color is different from user color" do
      it "it returns true" do
        expect(@user.color?(different_color)).to be false
      end
    end
  end
end
