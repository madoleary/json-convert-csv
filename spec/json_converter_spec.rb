require './json-convert'

# RSpec.describe JSONConverter do

  RSpec.describe "#flatten_hash" do
    context "given data type that is not a hash" do
      it "raises ArgumentError" do
        expect { @JSONConverter.flatten_hash }.to raise_error(ArgumentError)
      end
    end
  end

# end
