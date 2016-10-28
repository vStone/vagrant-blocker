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
        @blocks.each do |blocker|
          next if machine.env.machine_names.include?(blocker)
          errors << I18n.t('vagrant_blocker.warnings.blocker_not_found', blocker: blocker.to_s, name: machine.name.to_s)
        end
        report(errors, machine.env.ui)
      end

      private

      def report(errors, ui)
        return { 'blocker' => errors } if @strict_config
        errors.each { |m| ui.warn(m) }
        {}
      end
    end
  end
end
