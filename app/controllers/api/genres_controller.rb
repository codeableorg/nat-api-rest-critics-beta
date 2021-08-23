class Api::GenresController < ApiController
  def index
    render json: {}, status: :ok
  end
end