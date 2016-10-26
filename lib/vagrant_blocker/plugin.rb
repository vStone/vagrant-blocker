module VagrantPlugins
  module Blocker
    class VagrantBlocker < Vagrant.plugin('2')
      name 'Vagrant Blocker'

      config(:blocker) do
        require_relative 'config'
        Config
      end

  end
end
