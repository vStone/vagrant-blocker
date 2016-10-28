# frozen_string_literal: true
module VagrantPlugins
  module Blocker
    module Errors
      class BoxBlocksRunningVM < Vagrant::Errors::VagrantError
        error_namespace('vagrant_blocker.errors')
        error_key(:box_blocks_running_vm)
      end
      class BoxBlockedByRunningVM < Vagrant::Errors::VagrantError
        error_namespace('vagrant_blocker.errors')
        error_key(:box_blocked_by_running_vm)
      end
    end
  end
end
