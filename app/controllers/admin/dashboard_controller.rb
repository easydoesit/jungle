class Admin::DashboardController < ApplicationController
  
  include HttpAuthConcern
  
  def show    
    @product_count = Product.count
    @category_count = Category.count
  
  end

end
