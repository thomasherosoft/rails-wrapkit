module ModelHelpers
  extend ActiveSupport::Concern

  included do

  end

  module ClassMethods
    # def descendants
    #   ObjectSpace.each_object(Class).select { |klass| klass < self }
    # end

    def reset_auto_inc
      table = table_name
      result = ActiveRecord::Base.connection.execute("SELECT id FROM #{table} ORDER BY id DESC LIMIT 1") rescue ( puts "Warning: not procesing table #{table}. Id is missing?" and return )
      if result.any?
        ai_val = result.first['id'].to_i + 1
        # puts "-----------Resetting auto increment ID for #{table} to #{ai_val}"
        ActiveRecord::Base.connection.execute("ALTER SEQUENCE #{table}_id_seq RESTART WITH #{ai_val}")
      end
    end

    def process_remote_date(strange_date)
      return nil if strange_date.nil?
      #"/Date(1408046963797)/"
      timeint = strange_date.gsub(/\D/, '').to_i
      Time.at(timeint).to_datetime
    end
  end

end
