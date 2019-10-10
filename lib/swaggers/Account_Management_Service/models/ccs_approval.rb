=begin
#CCITS Service Profile

#The **Service Profile** service is used to read and update the following details of the given  Service Profile. - Address - ServiceName(Read Only)     - CCSApproval(Read Only) - Contact   - Declaration   - ExternalManagement   - Fees  - Financial  - OperationAcrossBorders   - Other(Update Only)  - ServiceLocationOfRecord - ServiceStopOperating((Update Only)  - ServiceStopOperatingSale(Update Only) - ServiceTemporarilyCeasing  - SupportingDocuments  - Trustee  

OpenAPI spec version: 2.04

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 2.4.7

=end

require 'date'

module AccountManagementService
  class CCSApproval
	include ActiveModel::Model
    # Service CCS Approval Status
    attr_accessor :status

    # Reason associated with the status
    attr_accessor :reason

    # Validity start date of this Service CCS Approval Status.
    attr_accessor :start_date

    # Validity end date of this Service CCS Approval Status.
    attr_accessor :end_date

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'status' => :'status',
        :'reason' => :'reason',
        :'start_date' => :'startDate',
        :'end_date' => :'endDate'
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        :'status' => :'String',
        :'reason' => :'String',
        :'start_date' => :'String',
        :'end_date' => :'String'
      }
    end

    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }

      if attributes.has_key?(:'status')
        self.status = attributes[:'status']
      end

      if attributes.has_key?(:'reason')
        self.reason = attributes[:'reason']
      end

      if attributes.has_key?(:'startDate')
        self.start_date = attributes[:'startDate']
      end

      if attributes.has_key?(:'endDate')
        self.end_date = attributes[:'endDate']
      end
    end

    # Show invalid properties with the reasons. Usually used together with valid?
    # @return Array for valid properties with the reasons
    def list_invalid_properties
      invalid_properties = Array.new
      if !@status.nil? && @status.to_s.length > 6
        invalid_properties.push('invalid value for "status", the character length must be smaller than or equal to 6.')
      end

      if !@reason.nil? && @reason.to_s.length > 6
        invalid_properties.push('invalid value for "reason", the character length must be smaller than or equal to 6.')
      end

      if !@start_date.nil? && @start_date.to_s.length > 10
        invalid_properties.push('invalid value for "start_date", the character length must be smaller than or equal to 10.')
      end

      if !@end_date.nil? && @end_date.to_s.length > 10
        invalid_properties.push('invalid value for "end_date", the character length must be smaller than or equal to 10.')
      end

      invalid_properties
    end

    # Check to see if the all the properties in the model are valid
    # @return true if the model is valid
    def valid?
      return false if !@status.nil? && @status.to_s.length > 6
      return false if !@reason.nil? && @reason.to_s.length > 6
      return false if !@start_date.nil? && @start_date.to_s.length > 10
      return false if !@end_date.nil? && @end_date.to_s.length > 10
      true
    end

    # Custom attribute writer method with validation
    # @param [Object] status Value to be assigned
    def status=(status)
      if !status.nil? && status.to_s.length > 6
        fail ArgumentError, 'invalid value for "status", the character length must be smaller than or equal to 6.'
      end

      @status = status
    end

    # Custom attribute writer method with validation
    # @param [Object] reason Value to be assigned
    def reason=(reason)
      if !reason.nil? && reason.to_s.length > 6
        fail ArgumentError, 'invalid value for "reason", the character length must be smaller than or equal to 6.'
      end

      @reason = reason
    end

    # Custom attribute writer method with validation
    # @param [Object] start_date Value to be assigned
    def start_date=(start_date)
      if !start_date.nil? && start_date.to_s.length > 10
        fail ArgumentError, 'invalid value for "start_date", the character length must be smaller than or equal to 10.'
      end

      @start_date = start_date
    end

    # Custom attribute writer method with validation
    # @param [Object] end_date Value to be assigned
    def end_date=(end_date)
      if !end_date.nil? && end_date.to_s.length > 10
        fail ArgumentError, 'invalid value for "end_date", the character length must be smaller than or equal to 10.'
      end

      @end_date = end_date
    end

    # Checks equality by comparing each attribute.
    # @param [Object] Object to be compared
    def ==(o)
      return true if self.equal?(o)
      self.class == o.class &&
          status == o.status &&
          reason == o.reason &&
          start_date == o.start_date &&
          end_date == o.end_date
    end

    # @see the `==` method
    # @param [Object] Object to be compared
    def eql?(o)
      self == o
    end

    # Calculates hash code according to all attributes.
    # @return [Fixnum] Hash code
    def hash
      [status, reason, start_date, end_date].hash
    end

    # Builds the object from hash
    # @param [Hash] attributes Model attributes in the form of hash
    # @return [Object] Returns the model itself
    def build_from_hash(attributes)
      return nil unless attributes.is_a?(Hash)
      self.class.swagger_types.each_pair do |key, type|
        if type =~ /\AArray<(.*)>/i
          # check to ensure the input is an array given that the the attribute
          # is documented as an array but the input is not
          if attributes[self.class.attribute_map[key]].is_a?(Array)
            self.send("#{key}=", attributes[self.class.attribute_map[key]].map { |v| _deserialize($1, v) })
          end
        elsif !attributes[self.class.attribute_map[key]].nil?
          self.send("#{key}=", _deserialize(type, attributes[self.class.attribute_map[key]]))
        end # or else data not found in attributes(hash), not an issue as the data can be optional
      end

      self
    end

    # Deserializes the data based on type
    # @param string type Data type
    # @param string value Value to be deserialized
    # @return [Object] Deserialized data
    def _deserialize(type, value)
      case type.to_sym
      when :DateTime
        DateTime.parse(value)
      when :Date
        Date.parse(value)
      when :String
        value.to_s
      when :Integer
        value.to_i
      when :Float
        value.to_f
      when :BOOLEAN
        if value.to_s =~ /\A(true|t|yes|y|1)\z/i
          true
        else
          false
        end
      when :Object
        # generic object (usually a Hash), return directly
        value
      when /\AArray<(?<inner_type>.+)>\z/
        inner_type = Regexp.last_match[:inner_type]
        value.map { |v| _deserialize(inner_type, v) }
      when /\AHash<(?<k_type>.+?), (?<v_type>.+)>\z/
        k_type = Regexp.last_match[:k_type]
        v_type = Regexp.last_match[:v_type]
        {}.tap do |hash|
          value.each do |k, v|
            hash[_deserialize(k_type, k)] = _deserialize(v_type, v)
          end
        end
      else # model
        temp_model = AccountManagementService.const_get(type).new
        temp_model.build_from_hash(value)
      end
    end

    # Returns the string representation of the object
    # @return [String] String presentation of the object
    def to_s
      to_hash.to_s
    end

    # to_body is an alias to to_hash (backward compatibility)
    # @return [Hash] Returns the object in the form of hash
    def to_body
      to_hash
    end

    # Returns the object in the form of hash
    # @return [Hash] Returns the object in the form of hash
    def to_hash
      hash = {}
      self.class.attribute_map.each_pair do |attr, param|
        value = self.send(attr)
        next if value.nil?
        hash[param] = _to_hash(value)
      end
      hash
    end

    # Outputs non-array value in the form of hash
    # For object, use to_hash. Otherwise, just return the value
    # @param [Object] value Any valid value
    # @return [Hash] Returns the value in the form of hash
    def _to_hash(value)
      if value.is_a?(Array)
        value.compact.map { |v| _to_hash(v) }
      elsif value.is_a?(Hash)
        {}.tap do |hash|
          value.each { |k, v| hash[k] = _to_hash(v) }
        end
      elsif value.respond_to? :to_hash
        value.to_hash
      else
        value
      end
    end
  end

end
