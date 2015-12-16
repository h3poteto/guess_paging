require 'guess_paging/guess_helper'
module GuessPaging
  class Engine < ::Rails::Engine
    isolate_namespace GuessPaging
    initializer 'guess_paging.action_view_helpers' do
      ActiveSupport.on_load :action_view do
        include GuessPaging::GuessHelper
      end
    end
  end
end
