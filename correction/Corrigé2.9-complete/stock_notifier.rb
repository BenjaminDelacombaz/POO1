STOCK_COUNT_THRESHOLD = 5

class StockNotifier < ActiveRecord::Observer
  observe :product
  
  def after_update(product)
    if product.stock_count < STOCK_COUNT_THRESHOLD
      # Notify when low on stock
      Notifier.notify(:manager, "Product #{product.id} #{product} is low on stock")
    end
  end
end
