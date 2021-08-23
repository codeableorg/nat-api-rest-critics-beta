class GamesController < ApplicationController
  before_action :set_game, only: %i[show edit update destroy add_genre
                                    remove_genre add_platform remove_platform]

  # GET /games
  def index
    @games = Game.all
  end

  # GET /games/:id
  def show; end

  # GET /games/new
  def new
    @game = Game.new
    authorize @game
    @main_games = Game.main_game
  end

  # GET /games/:id/edit
  def edit
    authorize @game
  end

  # POST /games
  def create
    @game = Game.new(game_params)
    authorize @game

    if @game.save
      redirect_to @game
    else
      render :new
    end
  end

  # PATCH/PUT /games/:id
  def update
    authorize @game
    if @game.update(game_params)
      redirect_to @game
    else
      render :edit
    end
  end

  # DELETE /games/:id
  def destroy
    authorize @game
    @game.destroy
    redirect_to games_url
  end

  # Custom Routes

  # POST /games/:id/add_genre
  def add_genre
    authorize @game, :update?
    genre = Genre.find(params[:genre_id])

    @game.genres << genre
    redirect_to @game
  end

  # DELETE /games/:id/remove_genre
  def remove_genre
    authorize @game, :update?
    genre = Genre.find(params[:genre_id])

    @game.genres.delete(genre)
    redirect_to @game
  end

  # POST /games/:id/add_platform
  def add_platform
    authorize @game, :update?
    platform = Platform.find(params[:platform_id])

    @game.platforms << platform
    redirect_to @game
  end

  # DELETE /games/:id/remove_platform
  def remove_platform
    authorize @game, :update?
    platform = Platform.find(params[:platform_id])

    @game.platforms.delete(platform)
    redirect_to @game
  end

  private

  # Only allow a list of trusted parameters through.
  def game_params
    params.require(:game).permit(:name, :summary, :release_date, :category, :rating, :parent_id)
  end

  def set_game
    @game = Game.find(params[:id])
  end
end
