class Serve::SettingsController < ApplicationController
  def index
    respond_to do |format|
      format.json { render json: { device_similarity_map: Ad::DEVICE_SIMILARITY_MAP } }
    end
  end
end
