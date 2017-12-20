require 'spec_helper'

# RSpec.describe JSONConverter do

  # RSpec.describe "#flatten_hash" do
  #   context "given data type that is not a hash" do
  #     it "raises ArgumentError" do
  #       expect { @JSONConverter.flatten_hash }.to raise_error(ArgumentError)
  #     end
  #   end
  # end

# end

# {
# "id": 0,
# "email": "colleengriffith@quintity.com",
# "tags": [
# "consectetur",
# "quis"
# ],
# "profiles": {
# "facebook": {
# "id": 0,
# "picture": "//fbcdn.com/a2244bc1-b10c-4d91-9ce8-184337c6b898.jpg"
# },
# "twitter": {
# "id": 0,
# "picture": "//twcdn.com/ad9e8cd3-3133-423e-8bbf-0602e4048c22.jpg"
# }
# }
# }

# describe "#flatten_hash" do
#   it "should flatten a hash" do
#     expect(flatten_hash({'a' => { 'b' => { 'c' => { 'd' => 0, 'e' => "foo" }, 'f' => { 'g' => 0, 'h' => "foo" }}}})).to eq {'a.b.c.d' => 0, 'a.b.c.e' => "foo", 'a.b.f.g' => 0, 'a.b.f.h' => "foo"}
#   end
# end

describe '#write_file' do
  it 'should convert a file in JSON format to CSV' do
    json_file = 'users.json'
    output = 'test.csv'

    compare = 'compare.csv'

    write_file(json_file, output)
    expect(open(output).read()).to eq open(compare).read()
  end
end
