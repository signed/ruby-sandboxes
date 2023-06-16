class NameSchema < Dry::Schema::JSON
  define do
    required(:name).value(Types::Name)
  end
end
