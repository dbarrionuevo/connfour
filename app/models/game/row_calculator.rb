class Game::RowCalculator
  WIN_COLUMN_SERIES = [[1,2,3,4], [2,3,4,5], [3,4,5,6]]
  WIN_ROW_SERIES    = WIN_COLUMN_SERIES << [4,5,6,7]

  def initialize(current_user, column)
    @current_user = current_user
    @column = column
  end

  # Returns next empty row for the column
  def next_empty
    min_row - 1
  end

  def win?
    return true if win_by_column?
    return true if win_by_row?
    return true if win_by_diagional?
  end

  private

  def min_row
    Game.where(column: @column).map(&:row).min || 7
  end

  def discs_in_column
    games.where(column: @column).map(&:row).sort
  end

  def discs_in_row
    games.where(row: min_row).map(&:column).sort
  end

  # Check if user discs in a column matches a win combination
  def win_by_column?
    WIN_COLUMN_SERIES.include? discs_in_column
  end

  # Check if user discs in a row matches a win combination
  def win_by_row?
    WIN_ROW_SERIES.include? discs_in_row
  end

  def win_by_diagional?
    @win = []

    # Check all possible win combination starting at each column
    WIN_ROW_SERIES.each do |row_serie|
      3.times do |start_r|
        @win = []
        row_serie.each_with_index do |v,i|
          @win << games.where(column: v).map(&:row).include?(6 - start_r - i)
        end

        break if @win.uniq == [true]
      end
      break if @win.uniq == [true]
    end

    return @win.uniq == [true]
  end

  def games
    @games ||= @current_user.games
  end
end
