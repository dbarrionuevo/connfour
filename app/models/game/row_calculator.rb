class Game::RowCalculator
  def initialize(column)
    @column = column
  end

  # Returns next empty row for the column
  def next_empty
    min_row - 1
  end

  private

  def min_row
    Game.where(column: @column).map(&:row).min || 7
  end
end
