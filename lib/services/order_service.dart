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
          orderService.add(OrderModel.fromJson(data));
        }
      },
      onError: (e) => print("Error completing: $e"),
    );

    return orderService;
  }

  Future<dynamic> checkout(newData) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;

    DocumentReference orderRef = await db.collection("orders").add(newData);

    // Use the order ID to fetch the document data
    DocumentSnapshot orderSnapshot = await orderRef.get();

    // Check if the document exists and retrieve the data
    if (orderSnapshot.exists) {
      Map<String, dynamic> order =
          orderSnapshot.data() as Map<String, dynamic>;
      order['id'] = orderRef.id;
      return order;
    } else {
      print("Order document does not exist");
      return null;
    }
  }
}
