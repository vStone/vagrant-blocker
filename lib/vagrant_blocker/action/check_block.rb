# frozen_string_literal: true
module VagrantPlugins
  module Blocker
    module Action
      # Vagrant action that checks for blocking machines
      class CheckBlock
        def initialize(app, env)
          @app = app
          @machine = env[:machine]
          @global_env = @machine.env
        end

        def call(env)
          # Only do stuff if we want to bring a machine up.
          return @app.call(env) if !env[:machine_action] == :up

          # Aquire active machines and check their blockers.
          @machine.env.active_machines.each do |name, provider|
            test_block_by_running(name)
            test_blocks_running(name, provider)
          end
          @app.call(env)
        end

        private

        def test_block_by_running(name)
          my_blockers = @machine.config.blocker.blocks
          raise Errors::BoxBlockedByRunningVM, name: name if my_blockers && my_blockers.include?(name)
        end

        def test_blocks_running(name, provider)
          machine = @machine.env.machine(name, provider)
          machine_blocks = machine.config.blocker.blocks
          raise Errors::BoxBlocksRunningVM, name: machine.name.to_s if machine_blocks.include?(@machine.name)
        end
      end
    end
  end
end
