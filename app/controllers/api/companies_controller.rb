class Api::CompaniesController < ApiController
  def index
    render json: Company.all
  end

  def show
    company = Company.find(params[:id])
    render json: company, except: [:created_at, :updated_at], include: {critics: {only: [:id, :title, :body]}}
  end
end