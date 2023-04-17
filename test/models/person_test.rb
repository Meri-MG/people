require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  test 'name should be present' do
    ahmed = Person.new
    assert_not ahmed.valid?
    assert_includes(ahmed.errors[:name], "can't be blank")

    ahmed.update(name: 'ahmed')
    assert ahmed.valid?
  end

  test 'children' do
    ahmed = Person.create(name: 'ahmed')
    khaled = Person.create(name: 'khaled', parent: ahmed)

    assert_equal ahmed.children, [khaled]
  end

  test 'grandchildren' do
    ahmed = Person.create(name: 'ahmed')
    samer = Person.create(name: 'samer', parent: ahmed)
    khaled = Person.create(name: 'khaled', parent: ahmed)
    ali = Person.create(name: 'ali', parent: samer)
    amjad = Person.create(name: 'amjad', parent: khaled)
    husam = Person.create(name: 'husam', parent: khaled)

    assert_equal ahmed.grandchildren, [ali, amjad, husam]
  end
end
