require 'rails_helper'

describe Api::StarsController, type: :request do
  describe(RadiusSchema) do
    context "pass valid input" do
      subject(:validation_result) do
        data = { 'radius' => 42, 'extra' => 'value' }
        RadiusSchema.new.call(data)
      end
      it { expect(validation_result).to be_success }
      it { expect(validation_result).not_to be_failure }
      it { expect(validation_result[:radius]).to eq(42) }
      it { expect(validation_result.errors).to be_empty }
      it 'filter out extra properties' do
        expect(validation_result.to_h).to eq({radius: 42})
      end
      it 'access by string key is not supported' do
        expect(validation_result['radius']).to be_nil
      end
      it 'drop properties not specified in the schema' do
        expect(validation_result[:extra]).to be_nil
      end
    end

    context "pass invalid input" do
      subject(:validation_result) { RadiusSchema.new.call('radius' => 0) }
      it { expect(validation_result).to be_failure }
      it { expect(validation_result).not_to be_success }
      it { expect(validation_result[:radius]).to eq(0) }
      it { expect(validation_result.errors).not_to be_empty }
    end
  end
end
