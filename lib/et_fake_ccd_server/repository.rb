require 'pstore'
module EtFakeCcdServer
  class Repository
    def initialize(filename: Tempfile.new.path)
      self.store = PStore.new(filename)
      store.transaction do
        store[:cases] ||= []
      end
    end

    def all(jid:, ctid:, filters: {})
      unfiltered = store.transaction(true) { store[:cases] }
      unfiltered.select do |case_record|
        matches_filter?(case_record, jid: jid, ctid: ctid, filters: filters)
      end
    end

    private

    def matches_filter(record, jid:, ctid:, filters: {})
      return false unless record['jurisdiction'] == jid && record['ctid'] == ctid
      return true if filters.empty?
      filters.all? do |(key, value)|
        json_path_for(record, key: mapped_json_key(key)) == value
      end
    end

    def json_path_for(record, key:)
      attrs = key.split('.')
      attr = attrs.shift
      value = record[attr]
      if attrs.empty?
        value
      else
        json_path_for(value, key: attrs.join('.'))
      end
    end

    def mapped_json_key(key)
      key.gsub(/\Acase\./, 'case_data')
    end

    attr_accessor :store
  end
end
