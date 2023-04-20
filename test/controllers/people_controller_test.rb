require 'test_helper'

class PeopleControllerTest < ActionDispatch::IntegrationTest
  test '#index' do
    get people_path
    assert_response :success
  end

  test '#new' do
    get new_person_path
    assert_response :success
  end

  test '#show' do
    ahmed = people(:ahmed)

    get person_path(ahmed)

    assert_response :success
    assert_select 'h1', ahmed.name
  end

  test '#create' do
    assert_difference 'Person.count' do
      post people_path, params: { person: { name: 'Khaled' } }
    end

    khaled = Person.last

    assert_response :redirect
    assert_redirected_to person_path(khaled)
    follow_redirect!
    assert_select '*', 'Person was successfully created.'
    assert_select 'h1', khaled.name
  end

  test '#create children/grandchildren' do
    samer = people(:samer)
    ahmed = people(:ahmed)
    assert_difference 'Person.count' do
      post people_path, params: { person: { name: 'Kamol', parent_id: samer.id } }
    end

    kamol = Person.last

    assert_response :redirect
    assert_redirected_to person_path(kamol)
    follow_redirect!
    assert_select '*', 'Person was successfully created.'
    assert_select 'h1', kamol.name
    assert_includes samer.children, kamol
    assert_includes ahmed.grandchildren, kamol
  end

  test '#create fails if name is nil' do
    assert_no_difference 'Person.count' do
      post people_path, params: { person: { name: '' } }
    end

    assert_response :unprocessable_entity
  end

  test '#delete' do
    ahmed = people(:ahmed)

    assert_difference 'Person.count', -1 do
      delete person_path(ahmed)
    end

    assert_response :redirect
  end
end
