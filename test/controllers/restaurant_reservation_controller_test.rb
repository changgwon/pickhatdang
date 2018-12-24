require 'test_helper'

class RestaurantReservationControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get restaurant_reservation_index_url
    assert_response :success
  end

end
