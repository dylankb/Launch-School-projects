# Logs must happen when 'data' accessed
# class SecretFile
#   attr_reader :data
#
#   def initialize(secret_data)
#     @data = secret_data
#   end
# end
# class SecurityLogger
#   def create_log_entry
#     # ... implementation omitted ...
#   end
# end

class SecretFile
  def initialize(secret_data)
    @data = secret_data
  end

  def data
    SecurityLogger.new.create_log_entry
  end
end

class SecurityLogger
  def create_log_entry
    # ... implementation omitted ...
    puts "Logged"
  end
end

file = SecretFile.new('Data')
file.data

# Provided solution - logger seems like an implementation detail, so I'm not sure if passing it into initialize is better here.

# class SecretFile
#   def initialize(secret_data, logger)
#     @data = secret_data
#     @logger = logger
#   end
#
#   def data
#     @logger.create_log_entry
#     @data
#   end
# end
