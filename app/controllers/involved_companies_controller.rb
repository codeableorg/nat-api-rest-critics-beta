class InvolvedCompaniesController < ApplicationController
  before_action :set_involved_company, only: %i[show edit update destroy]

  # GET /involved_companies
  def index
    @involved_companies = InvolvedCompany.all
  end

  # GET /involved_companies/:id
  def show
    authorize @involved_company
  end

  # GET /involved_companies/new
  def new
    @involved_company = InvolvedCompany.new
    authorize @involved_company
  end

  # GET /involved_companies/:id/edit
  def edit
    authorize @involved_company
  end

  # POST /involved_companies
  def create
    @involved_company = InvolvedCompany.new(involved_company_params)
    authorize @involved_company

    if @involved_company.save
      redirect_to @involved_company
    else
      render :new
    end
  end

  # PATCH/PUT /involved_companies/:id
  def update
    authorize @involved_company

    if @involved_company.update(involved_company_params)
      redirect_to @involved_company
    else
      render :edit
    end
  end

  # DELETE /involved_companies/:id
  def destroy
    authorize @involved_company
    @involved_company.destroy
    redirect_to involved_companies_url
  end

  private

  # Only allow a list of trusted parameters through.
  def involved_company_params
    params.require(:involved_company).permit(:game_id, :company_id, :developer, :publisher)
  end

  def set_involved_company
    @involved_company = InvolvedCompany.find(params[:id])
  end
end
