# frozen_string_literal: true
module VagrantPlugins
  module Blocker
    # Configuration
    class Config < Vagrant.plugin('2', :config)
      attr_accessor :blocks
      attr_accessor :strict_config

      def initialize
        @blocks = UNSET_VALUE
        @strict_config = UNSET_VALUE
      end

      def finalize!
        @strict_config = true if @strict_config == UNSET_VALUE
        @blocks = [] if @blocks == UNSET_VALUE
        @blocks = [@blocks].flatten.uniq.map(&:to_sym)
      end

      def validate(machine)
        errors = []
        [@blocks].flatten.uniq.map(&:to_sym).each do |blocker|
          unless machine.env.machine_names.include?(blocker)
            message = I18n.t('vagrant_blocker.warnings.blocker_not_found', blocker: blocker.to_s, name: machine.name.to_s)
            if @strict_config
              errors << message
            else
              machine.env.ui.warn(message)
            end
          end
        end
        { 'blocker' => errors}
      end

    end
  end
end
