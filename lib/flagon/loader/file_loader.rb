require 'yaml'

module Flagon
  module Loader
    class FileLoader
      def initialize(file_name)
        @file_name = file_name
      end

      def exists?(flag_name)
        flags.has_key?(to_key(flag_name))
      end

      def get_flag(flag_name)
        flags[to_key(flag_name)]
      end

      private

      def flags
        @flags ||= load_flags
      end

      def load_flags
        file = YAML.load(File.read(file_name))
        file.each_with_object({}) do |kv,flags|
          flags[to_key(kv[0])] = kv[1]
        end
      end

      def to_key(flag_name)
        flag_name.upcase.to_sym
      end

      attr_reader :file_name
    end
  end
end
