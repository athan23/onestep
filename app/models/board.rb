class Board < ApplicationRecord
  before_create :generate_board

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :width, numericality: { greater_than_or_equal_to: 1, only_integer: true }
  validates :height, numericality: { greater_than_or_equal_to: 1, only_integer: true }
  validates_numericality_of :number_of_mines, less_than: ->(board) { board.width * board.height }, greater_than: 0

  # validates :number_of_mines, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: width * height, only_integer: true }

  private

  def generate_board
    num_of_mines = self.number_of_mines
    grid = Array.new(self.height) { Array.new(self.width, 0) }

    while num_of_mines > 0
      mine_x = rand(0...self.height)
      mine_y = rand(0...self.width)
      if grid[mine_x][mine_y] >= 0
        (-1..1).each do |x|
          (-1..1).each do |y|
            if x == 0 && y == 0
              grid[mine_x][mine_y] = -num_of_mines
            else
              neighbor_x = x + mine_x
              neighbor_y = y + mine_y
              grid[neighbor_x][neighbor_y] += 1 if (0...self.height).member?(neighbor_x) && (0...self.width).member?(neighbor_y)
            end
          end
        end
        num_of_mines -= 1
      end
    end
    self.tiles = grid
  end
end
