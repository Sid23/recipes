require 'test_helper'

class ChefTest < ActiveSupport::TestCase
  def setup
    @chef = Chef.new(chefname: "myself", email: "jhOn@example.com")
  end
  
  test "Chef should be valid" do
    assert @chef.valid?
  end

  test "chef name should be present" do
    @chef.name = ""
    assert_not @chef.valid?
  end

  test "caf name should be shorter" do
    @chef.name = "abc"*11
    assert_not @chef.valid?

  test "email should be not too long" do
    @chef.email = "as"*130
    assert_not @chef.valid?
  end

  test "chef name should be written in a valid format" do
    valid_emails = %w[figaro@yahoo.com AfAfAf@ui.io bilgil@acc.it]
    valid_emails.each do |m|
      @chef.email = m
      assert @chef.valid?, "#{m.inspect} should be valid"
    end
  end

  test "email should be rejected" do
    invalid_emails = %w[Fiwra@faf,it fgsdug@ui.io.com bil.gil@it]
    invalid_emails.each do |m|
      @chef.email = m
      assert_not @chef.valid?, "#{m.inspect} should be valid"
    end
  end

  test "email should be unique and case insensitive" do
    dupplicate_chef = @chef.dup
    dupplicate_chef.email = @chef.email.downcase
    #safe chef before, in order to check uniqueness for further chefs
    @chef.save
    #check the validity of same chef with the same mail written in lowercase
    assert_not dupplicate_chef.valid?
  end

  test "email should be lowercase before be stored in db" do
    mixed_email = "John@pkh.it"
    @chef.email = mixed_email
    @chef.save
    assert_equal mixed_email.downcase, @chef.email
  end
end
