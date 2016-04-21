require 'csv'

class ImportOrders
  DATE_REGEXP = /\d{1,2}\/\d{1,2}\/\d{4}/
  SHIFT_MAP = {"M" => :morning, "N" => :noon, "E" => :evening}
  MODE_MAP = {"TRUCKLOAD" => :truckload}
  UNIT_TYPE_MAP = {"box" => :box}

  def run(file, permitter)
    if File.extname(file.original_filename) != ".csv"
      raise "Unknown file type: #{file.original_filename}"
    end

    imported = 0
    failures = []
    messages = []

    begin
      CSV.foreach(file.path, headers: true) do |row|
        begin
          hash = row.to_hash
          hash["delivery_shift"] = SHIFT_MAP[hash["delivery_shift"]]
          hash["mode"] = MODE_MAP[hash["mode"]]
          hash["handling_unit_type"] = UNIT_TYPE_MAP[hash["handling_unit_type"]]
          hash["client_name"] = hash.delete("client name")
          if DATE_REGEXP =~ hash["delivery_date"]
            hash["delivery_date"] = Date.strptime(hash["delivery_date"], "%m/%d/%Y")
          else
            hash["delivery_date"] = nil
          end
          hash = permitter.call(ActionController::Parameters.new({order: hash}))
          Order.create!(hash)
          imported += 1
        rescue Exception => e
          failures.push(row.to_csv)
          messages.push(e.message)
        end
      end
    rescue Exception => e
      raise "Bad csv format: #{e.message}"
    end

    return {imported: imported, failures: failures, messages: messages }
  end
end
