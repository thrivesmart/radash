require 'test_helper'

class CampaignsControllerTest < ActionController::TestCase
  setup do
    @campaign = campaigns(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:campaigns)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create campaign" do
    assert_difference('Campaign.count') do
      post :create, campaign: { flights: @campaign.flights, goal_type: @campaign.goal_type, goal_value: @campaign.goal_value, org_id: @campaign.org_id, paused_at: @campaign.paused_at, total_budget_in_cents: @campaign.total_budget_in_cents }
    end

    assert_redirected_to campaign_path(assigns(:campaign))
  end

  test "should show campaign" do
    get :show, id: @campaign
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @campaign
    assert_response :success
  end

  test "should update campaign" do
    patch :update, id: @campaign, campaign: { flights: @campaign.flights, goal_type: @campaign.goal_type, goal_value: @campaign.goal_value, org_id: @campaign.org_id, paused_at: @campaign.paused_at, total_budget_in_cents: @campaign.total_budget_in_cents }
    assert_redirected_to campaign_path(assigns(:campaign))
  end

  test "should destroy campaign" do
    assert_difference('Campaign.count', -1) do
      delete :destroy, id: @campaign
    end

    assert_redirected_to campaigns_path
  end
end
