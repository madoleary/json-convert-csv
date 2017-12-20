require 'spec_helper'

json = [
  {
    "a": 0,
    "b": "foo",
    "c": [
      "foo2",
      "foo3"
    ],
    "d": {
      "e": {
        "f": 0,
        "g": "foo4"
      },
      "h": {
        "i": 0,
        "j": "foo5"
      }
    }
  },
  {
    "k": 1,
    "l": "foo6",
    "m": [
      "foo7",
      "foo8",
      "foo9"
    ],
    "n": {
      "o": {
        "p": 1,
        "q": "foo10"
      },
      "r": {
        "s": 1,
        "t": "foo11"
      }
    }
  }]

describe "#flatten_hash" do
 it "should flatten a hash" do
   expect(
     flatten_hash(
       {
         'a' => { 'b' => { 'c' => { 'd' => 0, 'e' => "foo" }, 'f' => { 'g' => 0, 'h' => "foo" }}}
       }
     )).to eq({:'a.b.c.d' => 0, :'a.b.c.e' => "foo", :'a.b.f.g' => 0, :'a.b.f.h' => "foo"})
 end
end

describe "#flatten_json" do
  it "should loop through a JSON file to flatten all of the nested hashes" do

  flat_json = [{:a=>0,
  :b=>"foo",
  :c=>["foo2", "foo3"],
  :"d.e.f"=>0,
  :"d.e.g"=>"foo4",
  :"d.h.i"=>0,
  :"d.h.j"=>"foo5"},
 {:k=>1,
  :l=>"foo6",
  :m=>["foo7", "foo8", "foo9"],
  :"n.o.p"=>1,
  :"n.o.q"=>"foo10",
  :"n.r.s"=>1,
  :"n.r.t"=>"foo11"}]

   expect(flatten_json(json)).to eq(flat_json)
  end
end

describe '#get_headers' do
  it 'should grab the keys from the flattened hash and convert them to the proper header format for the CSV file, returned as an array of strings' do

  headers = ["a", "b", "c", "d.e.f", "d.e.g", "d.h.i", "d.h.j"]

  expect(get_headers(json)).to eq(headers)

  end
end

describe '#get_values' do
  it 'should get the values from the hashes in the JSON file and return them in an array per hash' do

      values_array = [[0, "foo", "foo2,foo3", 0, "foo4", 0, "foo5"],
      [1, "foo6", "foo7,foo8,foo9", 1, "foo10", 1, "foo11"]]

      expect(get_values(json)).to eq(values_array)

  end
end

describe '#write_file' do
  it 'should convert a file in JSON format to CSV' do
    json_file = 'users.json'
    output = 'test.csv'

    compare = 'compare.csv'

    write_file(json_file, output)
    expect(open(output).read()).to eq open(compare).read()
  end
end
