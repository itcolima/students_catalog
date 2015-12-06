require 'rails_helper'

RSpec.feature "CreateStudents", type: => :feature do

feature "Create student" do
  scenario "successfully" do
    visit "/"

    click_link "Alta de estudiante"

    within "#new_student" do
      fill_in "Nombre", with: "My name"
      fill_in "Apellido", with: "My last name"
      fill_in "Cumpleaños",  with: "My Birthday"

      click_on "Guardar"
    end

    expect(current_path).to eq "/"
    expect(page).to have_content "My name"
  end

  scenario "unsuccessfully" do
    visit "/"

    click_link "Alta de estudiante"

    within "#new_student" do
      click_on "Guardar"
    end

    expect(current_path).to eq "/Altas"
    expect(page).to have_content "First name necessary"
    expect(page).to have_content "Last name necessary"
    expect(page).to have_content "Birthday necessary"
  end

  scenario "unsuccessfully when first name is duplicated" do
    CreateStudents.create!(first_name: "My name",
     last_name: "My lastname", 
     birthday: "My Birthday")

    visit "/"

    click_link "Alta de estudiante"

    within "#new_student" do
      fill_in "Nombre", with: "My name"
      fill_in "Apellido", with: "My last name"
      fill_in "Cumpleaños",  with: "My Birthday"

      click_on "Guardar"
    end

    expect(current_path).to eq "/Altas"
    expect(page).to have_content "First name saved"
  end
end