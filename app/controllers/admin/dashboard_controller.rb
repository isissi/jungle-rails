class Admin::DashboardController < ApplicationController
  def show
    @products_count = Product.all.size
    @products_categories = Category.all.size
  end
end
