# frozen_string_literal: true
module VagrantPlugins
  module Blocker
    module Errors
      # The current box blocks a vm that is already running
      class BoxBlocksRunningVM < Vagrant::Errors::VagrantError
        error_namespace('vagrant_blocker.errors')
        error_key(:box_blocks_running_vm)
      end
      # The box is blocked by a vm that is already running
      class BoxBlockedByRunningVM < Vagrant::Errors::VagrantError
        error_namespace('vagrant_blocker.errors')
        error_key(:box_blocked_by_running_vm)
      end
    end
  end
end
