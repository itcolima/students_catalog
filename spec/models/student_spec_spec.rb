require 'rails_helper'



#Only validates:first_name, uniqueness: { scope: [ :last_name, :birthdate ] }
RSpec.describe StudentSpec, type: => :model do

  describe "validations" do
    it "fails to save" do
      studenspec = StudentSpec.new

      studenspec.save

      expect(studenspec).to_not be_persisted
    end

    it "validate birthday" do
      studenspec = StudentSpec.new(first_name: "Maximiliano", last_name: "Hernández")

      studenspec.save

      expect(studenspec.errors.full_messages).to eq(["Birthday necessary"])
    end

    it "validate first_name" do
      studenspec = StudentSpec.new(last_name: "Hernández", birthday: "03/06/1991")

      studenspec.save

      expect(studenspec.errors.full_messages).to eq(["First name necessary"])
    end

    it "validate last_name" do
      studenspec = StudentSpec.new(first_name: "Maximiliano",birthday: "03/06/1991")

      studenspec.save

      expect(studenspec.errors.full_messages).to eq(["Last name necessary"])
    end

    it "Validates uniqueness of first name" do
      StudentSpec.create(first_name: "Maximiliano",
                  last_name: "Hernández",
                  birthday:"03/06/1991")

      studenspec = StudentSpec.new(first_name: "Maximiliano",
                  last_name: "Hernández",
                  birthday:"03/06/1991")

      studenspec.save

      expect(studenspec.errors.full_messages).to eq(["First name saved"])
    end
  end
end