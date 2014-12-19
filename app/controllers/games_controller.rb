class GamesController < ApplicationController
  def show; end

  def create
    column  = params[:column].to_i
    row     = Game::RowCalculator.new(column).next_empty

    if row >= 1
      current_user.games.create(
        column: column,
        row: row
      )
    end

    redirect_to game_path(current_user.id)
  end

  private

  def p1_game_presenter
    @p1_game_presenter ||= GamePresenter.new(player_1.games)
  end
  helper_method :p1_game_presenter

  def p2_game_presenter
    @p2_game_presenter ||= GamePresenter.new(player_2.games)
  end
  helper_method :p2_game_presenter
end
