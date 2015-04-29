require 'test_helper'

class CreativesControllerTest < ActionController::TestCase
  setup do
    @creative = creatives(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:creatives)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create creative" do
    assert_difference('Creative.count') do
      post :create, creative: { approved_at: @creative.approved_at, approver_name: @creative.approver_name, asset_id: @creative.asset_id, attachment_html: @creative.attachment_html, attachment_type: @creative.attachment_type, locale: @creative.locale, org_id: @creative.org_id, posterid: @creative.posterid, postername: @creative.postername, promoted_thingid: @creative.promoted_thingid, title: @creative.title, url: @creative.url }
    end

    assert_redirected_to creative_path(assigns(:creative))
  end

  test "should show creative" do
    get :show, id: @creative
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @creative
    assert_response :success
  end

  test "should update creative" do
    patch :update, id: @creative, creative: { approved_at: @creative.approved_at, approver_name: @creative.approver_name, asset_id: @creative.asset_id, attachment_html: @creative.attachment_html, attachment_type: @creative.attachment_type, locale: @creative.locale, org_id: @creative.org_id, posterid: @creative.posterid, postername: @creative.postername, promoted_thingid: @creative.promoted_thingid, title: @creative.title, url: @creative.url }
    assert_redirected_to creative_path(assigns(:creative))
  end

  test "should destroy creative" do
    assert_difference('Creative.count', -1) do
      delete :destroy, id: @creative
    end

    assert_redirected_to creatives_path
  end
end
