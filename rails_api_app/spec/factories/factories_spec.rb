require 'rails_helper'

RSpec.describe 'FactoryBot factory' do
  FactoryBot.factories.each do |factory|
    describe factory.name.inspect do
      it 'creates valid record' do
        expect { FactoryBot::Linter.new([factory]).lint! }.not_to raise_error
      end
    end
  end
end