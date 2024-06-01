import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:MushMagic/models/order_model.dart';

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

  Future<double> getOrdersMonthly(int month) async {
    DateTime date = DateTime.now();

    double total = 0;

    await db.collection("orders")
            .where("created_at", isGreaterThanOrEqualTo: new DateTime(date.year, month, 1), isLessThanOrEqualTo: DateTime(date.year, month, 31))
            .orderBy("created_at", descending: true)
            .get().then(
          (querySnapshot) {
            for (var item in querySnapshot.docs) {
              total += 1;
            }
      },
      onError: (e) => print("Error completing: $e"),
    );

    return total;
  }

  Future<dynamic> checkout(newData) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;

    DocumentReference orderRef = await db.collection("orders").add(newData);
    
    for (var item in newData["items"]) {
      DocumentReference productRef = db.collection("products").doc(item["product"]["id"]);

      await productRef.update({
        "total_revenue": item["product"]["total_revenue"] + (item["qty"] * item["price"])
      });
    }

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

  Future<dynamic> cancelOrder(String orderId, Map<Object, Object> data) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;

    DocumentReference orderRef = db.collection("orders").doc(orderId);
    await orderRef.update(data);
    
    // Use the order ID to fetch the document data
    DocumentSnapshot orderSnapshot = await orderRef.get();

    // Check if the document exists and retrieve the data
    if (orderSnapshot.exists) {
      Map<String, dynamic> order = orderSnapshot.data() as Map<String, dynamic>;
      order['id'] = orderId;
      return order;
    } else {
      print("Order document does not exist");
      return null;
    }
  }

  Future<dynamic> changeStatusOrder(String orderId, Map<Object, Object> data) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;

    DocumentReference orderRef = db.collection("orders").doc(orderId);
    await orderRef.update(data);
    
    // Use the order ID to fetch the document data
    DocumentSnapshot orderSnapshot = await orderRef.get();

    // Check if the document exists and retrieve the data
    if (orderSnapshot.exists) {
      Map<String, dynamic> order = orderSnapshot.data() as Map<String, dynamic>;
      order['id'] = orderId;
      return order;
    } else {
      print("Order document does not exist");
      return null;
    }
  }
}
