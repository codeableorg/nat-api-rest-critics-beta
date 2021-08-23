class CompaniesController < ApplicationController
  before_action :set_company, only: %i[show edit update destroy]
  # GET /companies
  def index
    @companies = Company.all
  end

  # GET /companies/:id
  def show
    authorize @company
  end

  # GET /companies/new
  def new
    @company = Company.new
    authorize @company
  end

  # GET /companies/:id/edit
  def edit
    authorize @company
  end

  # POST /companies
  def create
    @company = Company.new(company_params)
    authorize @company

    if @company.save
      redirect_to @company
    else
      render :new
    end
  end

  # PATCH/PUT /companies/:id
  def update
    authorize @company

    if @company.update(company_params)
      redirect_to @company
    else
      render :edit
    end
  end

  # DELETE /companies/:id
  def destroy
    authorize @company
    @company.destroy
    redirect_to companies_path
  end

  private

  # Only allow a list of trusted parameters through.
  def company_params
    params.require(:company).permit(:name, :description, :start_date, :country)
  end

  def set_company
    @company = Company.find(params[:id])
  end
end
