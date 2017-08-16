class BackendController < ApplicationController

  before_action :prepend_view_paths
  #layout "frontend"

  def prepend_view_paths
    prepend_view_path "app/views/backend"
  end
end
