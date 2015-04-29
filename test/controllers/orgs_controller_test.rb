require 'test_helper'

class OrgsControllerTest < ActionController::TestCase
  setup do
    @org = orgs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:orgs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create org" do
    assert_difference('Org.count') do
      post :create, org: { city: @org.city, country_code: @org.country_code, currency_code: @org.currency_code, email: @org.email, name: @org.name, owner_id: @org.owner_id, permalink: @org.permalink, phone: @org.phone, state_province_region: @org.state_province_region, street_address1: @org.street_address1, street_address2: @org.street_address2, timezone: @org.timezone, url: @org.url, zip_postal_code: @org.zip_postal_code }
    end

    assert_redirected_to org_path(assigns(:org))
  end

  test "should show org" do
    get :show, id: @org
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @org
    assert_response :success
  end

  test "should update org" do
    patch :update, id: @org, org: { city: @org.city, country_code: @org.country_code, currency_code: @org.currency_code, email: @org.email, name: @org.name, owner_id: @org.owner_id, permalink: @org.permalink, phone: @org.phone, state_province_region: @org.state_province_region, street_address1: @org.street_address1, street_address2: @org.street_address2, timezone: @org.timezone, url: @org.url, zip_postal_code: @org.zip_postal_code }
    assert_redirected_to org_path(assigns(:org))
  end

  test "should destroy org" do
    assert_difference('Org.count', -1) do
      delete :destroy, id: @org
    end

    assert_redirected_to orgs_path
  end
end
