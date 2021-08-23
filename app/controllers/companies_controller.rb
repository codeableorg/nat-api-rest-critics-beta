class CompaniesController < ApplicationController
  # GET /companies
  def index
    @companies = Company.all
  end

  # GET /companies/:id
  def show
    @company = Company.find(params[:id])
    authorize @company
  end

  # GET /companies/new
  def new
    @company = Company.new
    authorize @company
  end

  # GET /companies/:id/edit
  def edit
    @company = Company.find(params[:id])
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
    @company = Company.find(params[:id])
    authorize @company

    if @company.update(company_params)
      redirect_to @company
    else
      render :edit
    end
  end

  # DELETE /companies/:id
  def destroy
    @company = Company.find(params[:id])
    authorize @company
    
    @company.destroy
    redirect_to companies_path
  end

  private

  # Only allow a list of trusted parameters through.
  def company_params
    params.require(:company).permit(:name, :description, :start_date, :country)
  end
end
