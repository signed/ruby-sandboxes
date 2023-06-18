module Universe
  class CreatePlanet < ApplicationService

    attr_reader :name, :radius, :star_id

    def initialize(name, radius, star_id)
      @name = name
      @radius = radius
      @star_id = star_id
    end

    def call
      planet = Planet.new({ name: name, radius: radius, star_id: star_id })

      if planet.save
        return planet
      end

      :failed
    end
  end

end