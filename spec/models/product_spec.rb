require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it 'saves a new product if all fields are valid' do
      @category = Category.new(name: "evergreens")

      @product = Product.new(
        name: "name",
        price_cents: 20,
        quantity: 2,
        category: @category
      )
      expect(@product.save).to eq true
    end

    it "returns an error that says Name can't be blank" do
      @category = Category.new(name: "evergreens")
      @product = Product.new(
        name: nil,
        price_cents: 2,
        quantity: 2,
        category: @category
      )
      @product.save
      expect(@product.errors.full_messages.to_sentence).to eq "Name can't be blank"
    end

    it "returns an error that says Price can't be blank" do
      @category = Category.new(name: "evergreens")
      @product = Product.new(
        name: "name",
        price_cents: nil,
        quantity: 2,
        category: @category
      )
      @product.save
      expect(@product.errors.full_messages.to_sentence).to eq "Price cents is not a number, Price is not a number, and Price can't be blank"
    end

    it "returns an error that says Quantity can't be blank" do
      @category = Category.new(name: "evergreens")
      @product = Product.new(
        name: "name",
        price_cents: 2,
        quantity: nil,
        category: @category
      )
      @product.save
      expect(@product.errors.full_messages.to_sentence).to eq "Quantity can't be blank"
    end

    it "returns an error that says category can't be blank" do
      @category = Category.new(name: "evergreens")
      @product = Product.new(
        name: "name",
        price_cents: 2,
        quantity: 20,
        category: nil,
      )
      @product.save
      expect(@product.errors.full_messages.to_sentence).to eq "Category must exist and Category can't be blank"
    end
  end
end
