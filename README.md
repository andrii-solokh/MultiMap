### Multidimensional Hashmap in Apex

#### Initiate map with list of SObjects and list of fieldPathes
```
MultiMap orderItemsByAssignedHotelId = new MultiMap(
  originalOrderItems,
  new List<String>{ 'Order.Assigned_Hotel__r.Tracked_Hotel__c', 'Product2Id' }
);
```

#### Get the first matching record
```
OrderItem originalOrderItem = (OrderItem) orderItemsByAssignedHotelId.getFirst(orderItem);
originalOrderItemByOrderItemId.put(orderItem.Id, originalOrderItem);

```
