require "test_helper"

class PollsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @poll = polls(:one)
  end

  test "should get index" do
    get polls_url
    assert_response :success
  end

  test "should get new" do
    get new_poll_url
    assert_response :success
  end

  test "should create poll" do
    assert_difference("Poll.count") do
      post polls_url, params: { poll: { question: @poll.question } }
    end

    assert_redirected_to poll_url(Poll.last)
  end

  test "should create poll with options" do
    assert_difference("Poll.count") do
      post polls_url, params: { 
        poll: { 
          question: "New Poll Question",
          options_attributes: [
            { text: "Option 1" },
            { text: "Option 2" }
          ]
        }
      }
    end

    poll = Poll.last
    assert_redirected_to poll_url(poll)
    assert_equal "New Poll Question", poll.question
    assert_equal 2, poll.options.count
    assert_equal "Option 1", poll.options.first.text
    assert_equal "Option 2", poll.options.second.text
  end

  test "should show poll" do
    get poll_url(@poll)
    assert_response :success
  end

  test "should get edit" do
    get edit_poll_url(@poll)
    assert_response :success
  end

  test "should update poll" do
    patch poll_url(@poll), params: { poll: { question: @poll.question } }
    assert_redirected_to poll_url(@poll)
  end

  test "should destroy poll" do
    assert_difference("Poll.count", -1) do
      delete poll_url(@poll)
    end

    assert_redirected_to polls_url
  end
end
