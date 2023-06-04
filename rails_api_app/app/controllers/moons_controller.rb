class MoonsController < ApplicationController
  before_action :set_moon, only: %i[ show update destroy ]

  # GET /moons
  def index
    @moons = Moon.all

    render json: @moons
  end

  # GET /moons/1
  def show
    render json: @moon
  end

  # POST /moons
  def create
    @moon = Moon.new(moon_params)

    if @moon.save
      render json: @moon, status: :created, location: @moon
    else
      render json: @moon.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /moons/1
  def update
    if @moon.update(moon_params)
      render json: @moon
    else
      render json: @moon.errors, status: :unprocessable_entity
    end
  end

  # DELETE /moons/1
  def destroy
    @moon.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_moon
      @moon = Moon.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def moon_params
      params.require(:moon).permit(:name, :radius, :planet_id)
    end
end
