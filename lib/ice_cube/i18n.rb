require 'ice_cube/null_i18n'

module IceCube
  module I18n

    LOCALES_PATH = File.expand_path(File.join('..', '..', '..', 'config', 'locales'), __FILE__)

    class << self
      delegate :t, :l, to: :backend
    end

    def self.backend
      @backend ||= detect_backend!
    end

    def self.detect_backend!
      temp_load_path = I18n.load_path
      rails_i18n_index = temp_load_path.index { |item| item =~ /rails_i18n/ } || -1
      temp_load_path.insert(rails_i18n_index, *Dir[File.join(LOCALES_PATH, "*.yml")])
      ::I18n.load_path = temp_load_path
      ::I18n
    rescue NameError
      NullI18n
    end
  end
end
