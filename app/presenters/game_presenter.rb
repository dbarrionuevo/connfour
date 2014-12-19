class GamePresenter
  def initialize(games)
    @games = games
  end

  def disc_at?(row, column)
    @games.select{|g| g.row == row+1}.select{|g| g.column == column+1}.any?
  end
end
