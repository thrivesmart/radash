class Ops::CreativesController < ApplicationController
  before_filter :enforce_auth
  before_filter :enforce_superuser
  before_action :set_creative, only: [:approve]
  
  def index
    @creatives = Creative.all
  end

  # PATCH/PUT /ops/creatives/1/approve
  # PATCH/PUT /ops/creatives/1/approve.json
  def approve
    respond_to do |format|
      if @creative.update_as_approved_by(authed_user)
        format.html { redirect_to ops_creatives_path, notice: 'Creative was successfully approved.' }
        format.json { render :show, status: :ok, location: ops_creatives_path }
      else
        format.html { redirect_to edit_org_creative_path(@creative.org, @creative) }
        format.json { render json: @creative.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private
  
  # Use callbacks to share common setup or constraints between actions.
  def set_creative
    @creative = Creative.find(params[:id])
  end
end
