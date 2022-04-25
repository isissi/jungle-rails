require "rails_helper"

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # validation tests/examples here

    before do
      @category = Category.create(name: "Tables")
    end

    it "should be successfully saved if with valid data" do
      @product = Product.create(
        name: "Wooden table",
        price_cents: 100,
        quantity: 20,
        category_id: @category.id
      )
      expect(@product).to be_present
    end

    it "should not save if no name is provided" do
      @product = Product.create(
        name: nil,
        price_cents: 100,
        quantity: 20,
        category_id: @category.id
      )
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it "should not save if no price is provided" do
      @product = Product.create(
        name: "Plastic table",
        price_cents: nil,
        quantity: 20,
        category_id: @category.id
      )
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it "should not save if no quantity is provided" do
      @product = Product.create(
        name: "Paper table",
        price_cents: 100,
        quantity: nil,
        category_id: @category.id
      )
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it "should not save if no category is provided" do
      @product = Product.create(
        name: "Ice table",
        price_cents: 100,
        quantity: 20,
        category_id: nil
      )
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end
end