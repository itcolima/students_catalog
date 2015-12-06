require 'rails_helper'

RSpec.describe StudentsControllerController, type: => :controller do

  describe "GET #index" do
    it "is successful" do
      get :index

      expect(response.status).to eq 200
    end
  end

  describe "GET #new" do
    it "is successful" do
      get :new

      expect(response.status).to eq 200
    end
  end

  describe "Student #create" do
    context "when the attributes are complete" do
      it "redirects to root path" do
        studenspec :create, post: {first_name: "Maximiliano",
				  last_name: "Hernández",
                  birthday:"03/06/1991" }

        expect(response).to redirect_to(root_path)
      end
    end

    context "when the attributes are incomplete" do
      it "renders the new template" do
        studenspec :create, studenspec: { first_name: nil, last_name: nil, birthday: nil }

        expect(response).to render_template("new")
      end

      it "is unprocessable entity" do
        studenspec :create, studenspec: { first_name: nil, last_name: nil, birthday: nil }

        expect(response.status).to eq 422
      end
    end
  end

  describe "GET #edit" do
    it "is successful" do
      p = StudentSpec.create!(first_name: "Maximiliano",
				  last_name: "Hernández",
                  birthday:"03/06/1991")

      get :edit, control_number: p.control_number

      expect(response.status).to eq 200
    end

    it "is not found" do
      get :edit, control_number: 10460282

      expect(response.status).to eq 404
    end
  end

  describe "PUT #update" do
    it "redirects to root path" do
      p = StudentSpec.create!(first_name: "Maximiliano",
				  last_name: "Hernández",
                  birthday:"03/06/1991")

      put :update, control_number: p.control_number, studenspec: { first_name: "MaximilianoM" }

      expect(response).to redirect_to(root_path)
    end

    context "when the attributes are invalid" do
      it "renders the edit view" do
        p = StudentSpec.create!(first_name: "Maximiliano",
				  last_name: "Hernández",
                  birthday:"03/06/1991")

        put :update, control_number: p.control_number, studenspec: { first_name: nil }

        expect(response).to render_template("edit")
      end

      it "renders the edit view" do
        p = StudentSpec.create!(first_name: "Maximiliano",
				  last_name: "Hernández",
                  birthday:"03/06/1991")

        put :update, control_number: p.control_number, studenspec: { first_name: nil }

        expect(response.status).to eq 422
      end
    end
  end

  describe "DELETE #destroy" do
    it "redirects to root path" do
      p = StudentSpec.create!(first_name: "Maximiliano",
				  last_name: "Hernández",
                  birthday:"03/06/1991")

      delete :destroy, control_number: p.control_number

      expect(response).to redirect_to(root_path)
    end

    it "redirects returns an exception" do
      delete :destroy, id: 1

      expect(response.status).to eq 404
    end
  end
end