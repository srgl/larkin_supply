require 'csv'

class ImportOrders
  DATE_REGEXP = /\d{1,2}\/\d{1,2}\/\d{4}/

  def run(file)
    if File.extname(file.original_filename) != ".csv"
      raise "Unknown file type: #{file.original_filename}"
    end

    shift_map = {"M" => :morning, "N" => :noon, "E" => :evening}
    mode_map = {"TRUCKLOAD" => :truckload}
    unit_type_map = {"box" => :box}
    imported = 0

    CSV.foreach(file.path, headers: true) do |row|
      hash = row.to_hash
      hash["delivery_shift"] = shift_map[hash["delivery_shift"]]
      hash["mode"] = mode_map[hash["mode"]]
      hash["handling_unit_type"] = unit_type_map[hash["handling_unit_type"]]
      hash["client_name"] = hash.delete("client name")
      if DATE_REGEXP =~ hash["delivery_date"]
        hash["delivery_date"] = Date.strptime(hash["delivery_date"], "%m/%d/%Y")
      else
        hash["delivery_date"] = nil
      end
      Order.create!(hash)
      imported += 1
    end

    return imported
  end
end
