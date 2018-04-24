class StockReducer < ActiveRecord::Observer
  observe :order
  
  def around_update(order)
    # are we shipping?
    if order.status_was != 'shipping' && order.status == 'shipping'
      # yes, let update the order
      yield
      # Reduce stock count of every ordered item
      order.order_items.each do |item|
        item.product.reload.reduce_stock_by item.quantity
      end
    else
      # no, let the update be done
      yield
    end
  end
end
