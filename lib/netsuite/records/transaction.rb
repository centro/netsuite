# TODO specs
# TODO a transaction is actually the superclass of a SalesOrder, this is backwards

module NetSuite
  module Records
    class Transaction < SalesOrder
      def initialize(attributes = {})
        @internal_id = attributes.delete(:internal_id) || attributes.delete(:@internal_id)
        @external_id = attributes.delete(:external_id) || attributes.delete(:@external_id)
        @type        = attributes.delete(:type) || attributes.delete(:'@xsi:type')
        initialize_from_attributes_hash(attributes)
      end

      def type
        @type
      end

      def to_record
        rec = super
        if rec["#{record_namespace}:customFieldList"]
          rec["#{record_namespace}:customFieldList!"] = rec.delete("#{record_namespace}:customFieldList")
        end
        rec
      end

    end
  end
end
