class GamesController < ApplicationController
  def show; end

  def create
    row     = row_calculator.next_empty

    if row >= 1
      current_user.games.create(
        column: column,
        row: row
      )
    end

    if row_calculator.win?
      flash[:notice] = "You Won!"
    end

    redirect_to game_path(current_user.id)
  end

  def restart
    Game.destroy_all

    redirect_to game_path(current_user.id)
  end

  private

  def column
    @column  ||= params[:column].to_i
  end

  def row_calculator
    @row_calculator ||= Game::RowCalculator.new(current_user, column)
  end

  def p1_game_presenter
    @p1_game_presenter ||= GamePresenter.new(player_1.games)
  end
  helper_method :p1_game_presenter

  def p2_game_presenter
    @p2_game_presenter ||= GamePresenter.new(player_2.games)
  end
  helper_method :p2_game_presenter
end
