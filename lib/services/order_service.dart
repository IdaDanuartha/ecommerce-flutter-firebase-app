import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_firebase/models/order_model.dart';

class OrderService {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  List<OrderModel> orderService = [];
  int index = 0;

  Future<List<OrderModel>> getOrders() async {
    await db.collection("orders").orderBy("created_at", descending: true).get().then(
      (querySnapshot) {
        orderService.clear();
        for (var item in querySnapshot.docs) {
          Map<String, dynamic> data = item.data();
          data['id'] = item.id;
          // for (var order in data["items"]) {
          //   data["items"][index] = OrderItemModel.fromJson(order);
          //   index++;
          // }
          orderService.add(OrderModel.fromJson(data));
        }
      },
      onError: (e) => print("Error completing: $e"),
    );

    return orderService;
  }
}
