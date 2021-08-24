class Api::GenresController < ApiController
  def index
    render json: Genre.all
  end

  def show
    genre = Genre.find(params[:id])
    render json: genre
  end


  def create
    genre = Genre.new(genre_params)
    genre.save
    render json: genre
  end

  def update
    genre = Genre.find(params[:id])
    genre = genre.update(genre_params)
    render json: genre
  end

  def destroy
    genre = Genre.find(params[:id])
    genre.destroy
    head :no_content
  end

  private

  # Only allow a list of trusted parameters through.
  def genre_params
    params.require(:genre).permit(:name)
  end

end