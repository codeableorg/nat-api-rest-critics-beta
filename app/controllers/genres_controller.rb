class GenresController < ApplicationController
  before_action :set_genre, only: %i[show edit update destroy]

  # GET /genres
  def index
    @genres = Genre.all
  end

  # GET /genres/:id
  def show
    authorize @genre
  end

  # GET /genres/new
  def new
    @genre = Genre.new
    authorize @genre
  end

  # GET /genres/:id/edit
  def edit
    authorize @genre
  end

  # POST /genres
  def create
    @genre = Genre.new(genre_params)
    authorize @genre

    if @genre.save
      redirect_to @genre
    else
      render :new
    end
  end

  # PATCH/PUT /genres/:id
  def update
    authorize @genre

    if @genre.update(genre_params)
      redirect_to @genre
    else
      render :edit
    end
  end

  # DELETE /genres/:id
  def destroy
    authorize @genre
    @genre.destroy
    redirect_to genres_path
  end

  private

  # Only allow a list of trusted parameters through.
  def genre_params
    params.require(:genre).permit(:name)
  end

  def set_genre
    @genre = Genre.find(params[:id])
  end
end
