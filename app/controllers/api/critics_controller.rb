class Api::CriticsController < ApiController
  def index
    render json: Critics.all
  end

  def show
    critics = Critics.find(params[:id])
    render json: critics
  end
end

