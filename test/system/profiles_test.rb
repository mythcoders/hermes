require "application_system_test_case"

class ProfilesTest < ApplicationSystemTestCase
  setup do
    @profile = profiles(:approved)
  end

  test "visiting the index" do
    visit profiles_url
    assert_selector "h1", text: "Profiles"
  end

  test "should create profile" do
    visit profiles_url
    click_on "New profile"

    fill_in "Name", with: @profile.name
    check "Regex" if @profile.regex
    fill_in "Reply to address", with: @profile.reply_to_address
    fill_in "Reroute address", with: @profile.reroute_address
    fill_in "Sender", with: @profile.sender_id
    fill_in "State", with: @profile.state
    click_on "Create Profile"

    assert_text "Profile was successfully created"
    click_on "Back"
  end

  test "should update Profile" do
    visit profile_url(@profile)
    click_on "Edit this profile", match: :first

    fill_in "Name", with: @profile.name
    check "Regex" if @profile.regex
    fill_in "Reply to address", with: @profile.reply_to_address
    fill_in "Reroute address", with: @profile.reroute_address
    fill_in "Sender", with: @profile.sender_id
    fill_in "State", with: @profile.state
    click_on "Update Profile"

    assert_text "Profile was successfully updated"
    click_on "Back"
  end

  test "should destroy Profile" do
    visit profile_url(@profile)
    click_on "Destroy this profile", match: :first

    assert_text "Profile was successfully destroyed"
  end
end
