class Admin::DashboardController < ApplicationController
  def show    
    @product_count = Product.count
    @category_count = Category.count
  
  include HttpAuthConcern
  
  def show
  end

end
