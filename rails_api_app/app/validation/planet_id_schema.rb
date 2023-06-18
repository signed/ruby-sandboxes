class PlanetIdSchema < Dry::Schema::JSON
  define do
    required(:planet_id).value(Types::NumericForeignKey)
  end
end
