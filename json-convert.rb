require 'open-uri'
require 'json'
require 'csv'

# flattens the nested hashes to comport with csv structure
def flatten_hash(hash)
  if hash.instance_of? Hash
    hash.each_with_object({}) do |(k, v), h|
      if v.is_a? Hash
        flatten_hash(v).map do |h_k, h_v|
          h["#{k}.#{h_k}".to_sym] = h_v
        end
      else
        h[k] = v
      end
    end
  else
    raise ArgumentError, 'Please provide a type of hash'
  end
end

# goes through json file to flatten all of the hashes
def flatten_json(file)
  flat_structure = file.map do |hash|
    flatten_hash(hash)
  end

  flat_structure
end

# grabs headers from flattened hashes and formats them to strings
def get_headers(file)
  headers = flatten_json(file).first.keys.map { |k| k.to_s }
  headers
end

# grabs and formats the values; the values from each hash are inside of an array, and those arrays are inside of an encompassing array
def get_values(file)
  values = flatten_json(file).map do |h|
    h.values.map do |e|
      if e.instance_of? Array
        e.join(',')
      else
        e
      end
    end
  end

  values
end

def write_file(file_path, output)
  CSV.open(output, "w+") do |csv|
    json = JSON.parse(File.open(file_path).read)
    csv << get_headers(json)
    get_values(json).each do |a|
      csv << a
    end
  end
end

# puts write_file('./users.json', './test.csv')



