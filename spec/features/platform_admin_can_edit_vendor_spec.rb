require "rails_helper"

RSpec.feature "Platform admin can edit vendors" do
  scenario "Platform admin and vendor see vendor's updated status" do
    user = User.create(username: "Jones", password: "password", password_confirmation: "password", email: "jones@gmail.com")
    user.roles.create(name: "platform_admin")

    vendor = Vendor.create(name: "Jojo blu", status: "active")
    vendor.photos.create(title: "photo", image: File.new("#{Rails.root}/spec/support/fixtures/people_1.jpg"), price: 20, description: "description", vendor_id: vendor.id)

    ApplicationController.any_instance.stubs(:current_user).returns(user)

    visit vendors_path

    visit platform_admin_dashboard_path(user.id)
    click_on "Active Vendors"
    expect(page).to have_content "Jojo blu"

    click_on "Edit"

    fill_in "Name", with: "bobo brown"
    click_on "Update Vendor"

    expect(page).to have_content "bobo brown has been updated."
    expect(current_path).to eq platform_admin_dashboard_path

    visit vendors_path
    expect(page).to have_content "bobo brown"
  end

  scenario "non-platform admins cannot access all vendors" do
    user = User.create(username: "Rosco", password: "password", password_confirmation: "password", email: "rosco@gmail.com")
    user.roles.create(name: "vendor_admin")

    ApplicationController.any_instance.stubs(:current_user).returns(user)

    visit platform_admin_dashboard_path
    expect(page).to have_content "404"
  end
end
