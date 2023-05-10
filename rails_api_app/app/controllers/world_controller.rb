class WorldController < ApplicationController
  def show
    render status: :ok, json: { name: 'earth' }
  end
end