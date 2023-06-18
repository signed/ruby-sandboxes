class StarIdSchema < Dry::Schema::JSON
  define do
    required(:star_id).value(Types::NumericForeignKey)
  end
end
