class PlatformsController < ApplicationController
  before_action :set_platform, only: %i[show edit update destroy]

  # GET /platforms
  def index
    @platforms = Platform.all
  end

  # GET /platforms/:id
  def show
    authorize @platform
  end

  # GET /platforms/new
  def new
    @platform = Platform.new
    authorize @platform
  end

  # GET /platforms/:id/edit
  def edit
    authorize @platform
  end

  # POST /platforms
  def create
    @platform = Platform.new(platform_params)
    authorize @platform

    if @platform.save
      redirect_to @platform
    else
      render :new
    end
  end

  # PATCH/PUT /platforms/:id
  def update
    authorize @platform

    if @platform.update(platform_params)
      redirect_to @platform
    else
      render :edit
    end
  end

  # DELETE /platforms/:id
  def destroy
    authorize @platform
    @platform.destroy
    redirect_to platforms_url
  end

  private

  # Only allow a list of trusted parameters through.
  def platform_params
    params.require(:platform).permit(:name, :category)
  end

  def set_platform
    @platform = Platform.find(params[:id])
  end
end
