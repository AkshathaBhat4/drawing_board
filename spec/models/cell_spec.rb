require 'rails_helper'

RSpec.describe Cell, type: :model do
  describe "self.ordered_cells" do
    let(:max) { Cell.all.pluck(:x_axis).max }
    let(:min) { Cell.all.pluck(:x_axis).min }
    before(:each) do
      @cells = Cell.ordered_cells
    end

    it "Cell Count should be equal to max size" do
      expect(@cells.count).to be max + 1
    end

    it "Cell keys should consists of all elements between max & min" do
      expect(@cells.keys).to eq (min..max).to_a
    end

    it "Cell y_axis elements should also be in ordered form" do
      first_element = @cells.keys.first
      internal_cells = Cell.where(x_axis: first_element).order('y_axis')
      expect(internal_cells).to eq @cells[first_element]
    end
  end

  describe "#title" do
    let(:cell) { Cell.first }

    context "when no user color associated with the cell" do
      it "title should be blank" do
        expect(cell.title).to eq ''
      end
    end

    context "when user updated cell color" do
      let(:user) { User.create }
      let(:color) { Color.first }
      before(:each) do
        user.update_color(color_id: color.id)
        user.update_cell_color(cell_id: cell.id)
        cell.reload
      end
      it "title should return user name & time of updation" do
        expect(cell.title).not_to eq ''
        expect(cell.title).to eq "Name : #{user.name} \nTime : #{cell.updated_at.strftime('%d/%b/%Y %H:%M %p')}"
      end
    end
  end
end
