# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

colors = [
  {name: 'Aqua', code: '#00FFFF'},
  {name: 'Black', code: '#000000'},
  {name: 'Blue', code: '#0000FF'},
  {name: 'Brown', code: '#A52A2A'},
  {name: 'DarkGreen', code: '#006400'},
  {name: 'DarkRed', code: '#8B0000'},
  {name: 'DeepPink', code: '#FF1493'},
  {name: 'GhostWhite', code: '#F8F8FF'},
  {name: 'Orange', code: '#FFA500'},
  {name: 'Red', code: '#FF0000'}
]

colors.each do |color|
  Color.where(color).first_or_create
end

board = Board.where(name: 'Drawing Board').first_or_create

board_size = 20
board_size.times do |x|
  board_size.times do |y|
    board.cells.where(x_axis: x, y_axis: y).first_or_create
  end
end
