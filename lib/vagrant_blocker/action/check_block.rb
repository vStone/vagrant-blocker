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
          @config = @machine.config
        end

        def call(env)
          # Only do stuff if we want to bring a machine up.
          return @app.call(env) if !env[:machine_action] == :up

          my_blockers = @config.blocker.blocks
          # Aquire active machines and check their blockers.
          @global_env.active_machines.each do |name, provider|
            if my_blockers && my_blockers.include?(name)
              raise Errors::BoxBlockedByRunningVM, name: name
            end
            machine = @global_env.machine(name, provider)
            machine_blocks = machine.config.blocker.blocks
            if machine_blocks.include?(@machine.name)
              raise Errors::BoxBlocksRunningVM, name: machine.name.to_s
            end
          end
          @app.call(env)
        end
      end
    end
  end
end
