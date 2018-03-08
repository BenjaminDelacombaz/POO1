class ProductStockObserver < ActiveRecord::Observer
  observe :product

  def after_create(model)
    puts 'OK'
  end
end
