# frozen_string_literal: true

begin
  require 'vagrant'
rescue LoadError
  raise 'The vagrant-disksize plugin must be run within vagrant.'
end

module VagrantPlugins
  module Blocker
    # Vagrant plugin that allows machines to block eachother from running simultaneously
    class Plugin < Vagrant.plugin('2')
      name 'Vagrant Blocker'
      description <<-EOF
      Allow certain VMs to block eachother in a multi-vm setup.
      EOF

      config 'blocker' do
        require_relative 'config'
        init!
        Config
      end

      action_hook(:do_before_boot, :machine_action_up) do |hook|
        require_relative 'action/check_block'
        init!
        hook.prepend(VagrantPlugins::Blocker::Action::CheckBlock)
      end

      def self.init!
        return if defined?(@_init)
        I18n.load_path << File.expand_path(File.dirname(__FILE__) + '/../../locales/en.yml')
        I18n.reload!
        @_init = true
      end
    end
  end
end
