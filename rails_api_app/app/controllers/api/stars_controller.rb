require 'dry/types'
require 'dry/validation'

module Types
  include Dry::Types()

  Radius = Integer.constrained(gt: 0)
end

class NameSchema < Dry::Schema::JSON
  define do
    required(:name).value(:string, min_size?: 1)
  end
end

class RadiusSchema < Dry::Schema::JSON
  define do
    required(:radius).value(Types::Radius)
  end
end

class CreateStarSchema < Dry::Schema::JSON
  define do
    required(:star).hash(NameSchema.new & RadiusSchema.new)
  end
end

class PatchStarSchema < Dry::Schema::JSON
  define do
    required(:star).hash do
      #optional(:name).value(NameSchema.new)
      #optional(:radius).value(RadiusSchema.new)
      optional(:name).value(:string, min_size?: 1)
      optional(:radius).value(Types::Radius)
    end
  end
end

class Api::StarsController < ApplicationController
  before_action :set_star, only: %i[ show update destroy ]

  # GET /stars
  def index
    @stars = Star.all

    render json: @stars
  end

  # POST /stars
  def create
    validation_result = CreateStarSchema.new.call(json_body)
    return head(:unprocessable_entity) if validation_result.failure?

    @star = Star.new(validation_result.to_h[:star])

    if @star.save
      render json: @star, status: :created, location: api_star_url(@star)
    else
      render json: @star.errors, status: :unprocessable_entity
    end
  end

  # GET /stars/1
  def show
    render json: @star
  end

  # PATCH/PUT /stars/1
  def update
    validation_result = PatchStarSchema.new.call(json_body)
    return head(:unprocessable_entity) if validation_result.failure?

    if @star.update(validation_result.to_h[:star])
      render json: @star
    else
      render json: @star.errors, status: :unprocessable_entity
    end
  end

  # DELETE /stars/1
  def destroy
    @star.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_star
    @star = Star.find(params[:id])
  end

end
