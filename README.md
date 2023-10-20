
MultiMap orderItemsByAssignedHotelId = new MultiMap(
  originalOrderItems,
  new List<String>{ 'Order.Assigned_Hotel__r.Tracked_Hotel__c', 'Product2Id' }
);

for (OrderItem orderItem : orderItemRecords) {
  OrderItem originalOrderItem = (OrderItem) orderItemsByAssignedHotelId.getFirst(orderItem);
  originalOrderItemByOrderItemId.put(orderItem.Id, originalOrderItem);
}
