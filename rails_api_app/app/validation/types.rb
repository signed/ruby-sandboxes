module Types
  include Dry::Types()

  Name = String.constrained(min_size: 1)
  Radius = Integer.constrained(gt: 0)
  NumericForeignKey = Integer.constrained(gt: 0)
end
