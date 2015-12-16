require 'guess_helper'
module GuessPaging
  class Engine < ::Rails::Engine
    isolate_namespace GuessPaging
    initializer 'guess_paging.action_controller_helpers' do
      ActiveSupport.on_load :action_controller do
        include GuessPaging::GuessHelper
      end
    end
  end
end
