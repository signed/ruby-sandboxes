class Api::MoonsController < ApplicationController
  before_action :set_moon, only: %i[ show update destroy ]

  class CreateMoonSchema < Dry::Schema::JSON
    define do
      required(:moon).hash(NameSchema.new & RadiusSchema.new & PlanetIdSchema.new)
    end
  end

  class PatchMoonSchema < Dry::Schema::JSON
    define do
      required(:moon).hash do
        optional(:name).value(Types::Name)
        optional(:radius).value(Types::Radius)
        optional(:planet_id).value(Types::NumericForeignKey)
      end
    end
  end

  def index
    @moons = Moon.all

    render json: @moons
  end

  def show
    render json: @moon
  end

  def create
    validation_result = CreateMoonSchema.new.call(json_body)
    return head(:unprocessable_entity) if validation_result.failure?

    @moon = Moon.new(validation_result.to_h[:moon])

    if @moon.save
      render json: @moon, status: :created, location: api_moon_url(@moon)
    else
      render json: @moon.errors, status: :unprocessable_entity
    end
  end

  def update
    validation_result = PatchMoonSchema.new.call(json_body)
    return head(:unprocessable_entity) if validation_result.failure?

    if @moon.update(validation_result.to_h[:moon])
      render json: @moon
    else
      render json: @moon.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @moon.destroy
  end

  private
    def set_moon
      @moon = Moon.find(params[:id])
    end
end
