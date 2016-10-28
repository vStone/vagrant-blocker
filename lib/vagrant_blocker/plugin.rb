# frozen_string_literal: true
module VagrantPlugins
  module Blocker
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

      protected

      def self.init!
        return if defined?(@_init)
        I18n.load_path << File.expand_path(File.dirname(__FILE__) + '/../../locales/en.yml')
        I18n.reload!
        @_init = true
      end
    end
  end
end
