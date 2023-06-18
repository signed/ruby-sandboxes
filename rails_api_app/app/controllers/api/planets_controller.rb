class Api::PlanetsController < ApplicationController
  before_action :set_planet, only: %i[ show update destroy ]

  class CreatePlanetSchema < Dry::Schema::JSON
    define do
      required(:planet).hash(NameSchema.new & RadiusSchema.new & StarIdSchema.new)
    end
  end

  class PatchPlanetSchema < Dry::Schema::JSON
    define do
      required(:planet).hash do
        optional(:name).value(Types::Name)
        optional(:radius).value(Types::Radius)
        optional(:star_id).value(Types::NumericForeignKey)
      end
    end
  end

  # GET /planets
  def index
    @planets = Planet.all

    render json: @planets
  end

  # GET /planets/1
  def show
    render json: @planet
  end

  # POST /planets
  def create
    validation_result = CreatePlanetSchema.new.call(json_body)
    return head(:unprocessable_entity) if validation_result.failure?

    args = validation_result.to_h[:planet]

    name = args[:name]
    radius = args[:radius]
    star_id = args[:star_id]
    result = Universe::CreatePlanet.call(name, radius, star_id)

    case result
    when :failed
      render head(:internal_server_error)
      return
    else
      @planet = result
      render json: @planet, status: :created, location: api_planet_url(@planet)
    end
  end

  # PATCH/PUT /planets/1
  def update
    validation_result = PatchPlanetSchema.new.call(json_body)
    return head(:unprocessable_entity) if validation_result.failure?

    if @planet.update(validation_result.to_h[:planet])
      render json: @planet
    else
      render json: @planet.errors, status: :unprocessable_entity
    end
  end

  # DELETE /planets/1
  def destroy
    @planet.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_planet
    @planet = Planet.find(params[:id])
  end
end
