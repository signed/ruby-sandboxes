class RadiusSchema < Dry::Schema::JSON
  define do
    required(:radius).value(Types::Radius)
  end
end
