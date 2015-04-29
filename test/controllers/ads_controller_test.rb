require 'test_helper'

class AdsControllerTest < ActionController::TestCase
  setup do
    @ad = ads(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ads)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ad" do
    assert_difference('Ad.count') do
      post :create, ad: { approved_at: @ad.approved_at, approver_name: @ad.approver_name, bid_in_cents: @ad.bid_in_cents, bid_type: @ad.bid_type, creative_id: @ad.creative_id, devices: @ad.devices, interests: @ad.interests, locations: @ad.locations, org_id: @ad.org_id, os: @ad.os, os_versions: @ad.os_versions, paused_at: @ad.paused_at, placements: @ad.placements, subreddits: @ad.subreddits }
    end

    assert_redirected_to ad_path(assigns(:ad))
  end

  test "should show ad" do
    get :show, id: @ad
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ad
    assert_response :success
  end

  test "should update ad" do
    patch :update, id: @ad, ad: { approved_at: @ad.approved_at, approver_name: @ad.approver_name, bid_in_cents: @ad.bid_in_cents, bid_type: @ad.bid_type, creative_id: @ad.creative_id, devices: @ad.devices, interests: @ad.interests, locations: @ad.locations, org_id: @ad.org_id, os: @ad.os, os_versions: @ad.os_versions, paused_at: @ad.paused_at, placements: @ad.placements, subreddits: @ad.subreddits }
    assert_redirected_to ad_path(assigns(:ad))
  end

  test "should destroy ad" do
    assert_difference('Ad.count', -1) do
      delete :destroy, id: @ad
    end

    assert_redirected_to ads_path
  end
end
