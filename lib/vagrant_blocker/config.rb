# frozen_string_literal: true
module VagrantPlugins
  module Blocker
    # Configuration
    class Config < Vagrant.plugin('2', :config)
      attr_accessor :blocks

      def initialize
        @blocks = UNSET_VALUE
      end

      def finalize!
        @blocks = [] if @blocks == UNSET_VALUE
        @blocks = [@blocks].flatten.uniq.map(&:to_sym)
      end

      def validate(machine)
        {}
      end

    end
  end
end
