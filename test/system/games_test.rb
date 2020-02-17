# test/system/games_test.rb
require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  test "Going to /new gives us a new random grid to play with" do
    visit new_url
    assert test: "New game"
    assert_selector "li", count: 10
  end

  class RandomWordTest < ApplicationSystemTestCase
    test "Filling in random word, clicking play, gives error word is not in grid" do
      visit new_url
      fill_in "word", with: "abracaf"
      click_on "play"

      assert_text "Sorry but ABRACAF can't be build out of"
    end
  end




