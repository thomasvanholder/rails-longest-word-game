# test/system/games_test.rb
require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  test "Going to /new gives us a new random grid to play with" do
    visit new_url
    assert test: "New game"
    assert_selector "li", count: 10
  end

  test "Filling in random word, clicking play, gives error word is not in grid" do
    visit new_url
    fill_in "word", with: "abracaf"
    click_on "play"

    assert_text "Sorry but ABRACAF can't be build out of the intial array"
  end

  test "Filling in no word, clicking play, gives error word is no word" do
    visit new_url
    fill_in "word", with: "o"
    click_on "play"

    assert_text "Sorry, but O does not seem to be an English word"
  end

  test "Filling in valid word, clicking play, get congrats" do
    visit new_url
    fill_in "word", with: "do"
    click_on "play"

    assert_text "Congratulations! Do is a valid English word!"
  end
end
