class WorldController < ApplicationController
  def show
    render json: { name: 'wupsi' }
  end
end