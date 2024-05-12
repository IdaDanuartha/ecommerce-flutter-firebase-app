import 'package:ecommerce_firebase/helpers/generate_random_string.dart';
import 'package:ecommerce_firebase/helpers/location_picker_alert.dart';
import 'package:ecommerce_firebase/helpers/send_to_gmail.dart';
import 'package:ecommerce_firebase/pages/home/checkout_success_page.dart';
import 'package:ecommerce_firebase/providers/cart_provider.dart';
import 'package:ecommerce_firebase/providers/order_provider.dart';
import 'package:ecommerce_firebase/providers/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_firebase/themes.dart';
import 'package:ecommerce_firebase/widgets/checkout_card.dart';
import 'package:ecommerce_firebase/widgets/loading_button.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  static const routeName = '/home/checkout';

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _provinceController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _subdistrictController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _paymentMethodController =
      TextEditingController();

  bool isLoading = false;

  List<DropdownMenuItem<String>> get dropdownItems{
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(child: Text("Online Banking"),value: "Online Banking"),
      const DropdownMenuItem(child: Text("COD"),value: "COD"),
      const DropdownMenuItem(child: Text("Mastercard"),value: "Mastercard"),
    ];
    return menuItems;
  }
  String paymentSelected = "Online Banking";

  LatLng? selectedLocation;

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    OrderProvider orderProvider = Provider.of<OrderProvider>(context);
    UserProvider userProvider = Provider.of<UserProvider>(context);

    _paymentMethodController.text = paymentSelected;

    String grandTotal = (cartProvider.totalPrice + 0 - cartProvider.totalDiscount).toStringAsFixed(2);

    void handleCheckout() async {
      setState(() {
        isLoading = true;
      });

      User? user = FirebaseAuth.instance.currentUser;

      String generateCode = generateWithFormat();

      var newOrder = await orderProvider.checkout({
        "user_id": user!.uid,
        "customer_name": _customerNameController.text,
        "phone": _phoneController.text,
        "code": generateCode,
        "status": 1,
        "payment_method": _paymentMethodController.text,
        "sub_total": cartProvider.totalPrice,
        "total_discount": cartProvider.totalDiscount,
        "delivery_fee": 0.0,
        "created_at": DateTime.now(),
        "address": {
          "country": _countryController.text,
          "province": _provinceController.text,
          "city": _cityController.text,
          "subdistrict": _subdistrictController.text,
          "details": _detailsController.text,
        },
        "items": cartProvider.items.map((item) {
          return {
            "price": item.product.price,
            "qty": item.qty,
            "discount": item.product.discount,
            "product": {
              "id": item.product.id,
              "name": item.product.name,
              "price": item.product.price,
              "discount": item.product.discount,
              "qty": item.product.qty,
              "description": item.product.description,
              "created_at": item.product.createdAt,
              "images": item.product.images
            },
          };
        })
      }, context);

      if (newOrder) {
        Navigator.pushNamed(context, CheckoutSuccessPage.routeName);
        orderProvider.getOrdersByUser(userId: user.uid);
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: successColor,
            duration: const Duration(milliseconds: 2500),
            content: const Text(
              'Order placed successfully',
              textAlign: TextAlign.center,
            ),
          ),
        );

        sendToGmail("New Order From Your Customer!", "entered", generateCode, grandTotal, userProvider, context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: alertColor,
            duration: const Duration(milliseconds: 2500),
            content: const Text(
              'Failed to place your order',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }

      setState(() {
        isLoading = false;
      });
    }

    AppBar header() {
      return AppBar(
        backgroundColor: bgColor1,
        iconTheme: IconThemeData(
          color: primaryTextColor,
        ),
        centerTitle: true,
        title: Text(
          'Checkout Page',
          style: primaryTextStyle.copyWith(fontSize: 18, fontWeight: medium),
        ),
        elevation: 0,
      );
    }

    Widget listItems() {
      // NOTE: LIST ITEMS
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'List Items',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            ...cartProvider.items
                .map((cart) => CheckoutCard(cart: cart))
                .toList()
          ],
        ),
      );
    }

    Widget customerNameInput() {
      return Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   'Full name',
            //   style: primaryTextStyle.copyWith(
            //       fontSize: 16, fontWeight: medium, color: primaryTextColor),
            // ),
            // const SizedBox(height: 12),
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(width: 1, color: const Color(0xFF797979))),
              child: Center(
                child: Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                      controller: _customerNameController,
                      style: secondaryTextStyle.copyWith(fontSize: 14),
                      decoration: InputDecoration(
                          hintText: 'Input your full name',
                          hintStyle: subtitleTextStyle,
                          border: InputBorder.none),
                    ))
                  ],
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget phoneInput() {
      return Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   'Full name',
            //   style: primaryTextStyle.copyWith(
            //       fontSize: 16, fontWeight: medium, color: primaryTextColor),
            // ),
            // const SizedBox(height: 12),
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(width: 1, color: const Color(0xFF797979))),
              child: Center(
                child: Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                      controller: _phoneController,
                      style: secondaryTextStyle.copyWith(fontSize: 14),
                      decoration: InputDecoration(
                          hintText: 'Input your phone number',
                          hintStyle: subtitleTextStyle,
                          border: InputBorder.none),
                    ))
                  ],
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget countryInput() {
      return Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   'Full name',
            //   style: primaryTextStyle.copyWith(
            //       fontSize: 16, fontWeight: medium, color: primaryTextColor),
            // ),
            // const SizedBox(height: 12),
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(width: 1, color: const Color(0xFF797979))),
              child: Center(
                child: Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                      controller: _countryController,
                      style: secondaryTextStyle.copyWith(fontSize: 14),
                      decoration: InputDecoration(
                          hintText: 'Input your country',
                          hintStyle: subtitleTextStyle,
                          border: InputBorder.none),
                    ))
                  ],
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget provinceInput() {
      return Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   'Full name',
            //   style: primaryTextStyle.copyWith(
            //       fontSize: 16, fontWeight: medium, color: primaryTextColor),
            // ),
            // const SizedBox(height: 12),
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(width: 1, color: const Color(0xFF797979))),
              child: Center(
                child: Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                      controller: _provinceController,
                      style: secondaryTextStyle.copyWith(fontSize: 14),
                      decoration: InputDecoration(
                          hintText: 'Input your province',
                          hintStyle: subtitleTextStyle,
                          border: InputBorder.none),
                    ))
                  ],
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget cityInput() {
      return Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   'Full name',
            //   style: primaryTextStyle.copyWith(
            //       fontSize: 16, fontWeight: medium, color: primaryTextColor),
            // ),
            // const SizedBox(height: 12),
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(width: 1, color: const Color(0xFF797979))),
              child: Center(
                child: Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                      controller: _cityController,
                      style: secondaryTextStyle.copyWith(fontSize: 14),
                      decoration: InputDecoration(
                          hintText: 'Input your city',
                          hintStyle: subtitleTextStyle,
                          border: InputBorder.none),
                    ))
                  ],
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget subdistrictInput() {
      return Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   'Full name',
            //   style: primaryTextStyle.copyWith(
            //       fontSize: 16, fontWeight: medium, color: primaryTextColor),
            // ),
            // const SizedBox(height: 12),
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(width: 1, color: const Color(0xFF797979))),
              child: Center(
                child: Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                      controller: _subdistrictController,
                      style: secondaryTextStyle.copyWith(fontSize: 14),
                      decoration: InputDecoration(
                          hintText: 'Input your subdistrict',
                          hintStyle: subtitleTextStyle,
                          border: InputBorder.none),
                    ))
                  ],
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget addressDetailInput() {
      return Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   'Full name',
            //   style: primaryTextStyle.copyWith(
            //       fontSize: 16, fontWeight: medium, color: primaryTextColor),
            // ),
            // const SizedBox(height: 12),
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(width: 1, color: const Color(0xFF797979))),
              child: Center(
                child: Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                      controller: _detailsController,
                      style: secondaryTextStyle.copyWith(fontSize: 14),
                      decoration: InputDecoration(
                          hintText: 'Input your address details',
                          hintStyle: subtitleTextStyle,
                          border: InputBorder.none),
                    ))
                  ],
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget showLocationFromMap() {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 20),
        child: ElevatedButton.icon(
          onPressed: () async {
            await showDialog(
              context: context,
              builder: (BuildContext context) {
                return LocationPickerAlert(
                  onLocationSelected: (LatLng userLocation) {
                    selectedLocation = userLocation;
                    print("Selected location - latitude : ${userLocation.latitude}, longitude : ${userLocation.longitude}");
                  }
                );
              }
            );
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
            )
          ),
          icon: Icon(
            Icons.location_on
          ),
          label: const Text(
            "Select Location from Map",
          ),
        ),
      );
    }

    Widget paymentMethodInput() {
      return Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   'Full name',
            //   style: primaryTextStyle.copyWith(
            //       fontSize: 16, fontWeight: medium, color: primaryTextColor),
            // ),
            // const SizedBox(height: 12),
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(width: 1, color: const Color(0xFF797979))),
              child: Center(
                child: Row(
                  children: [
                    Expanded(
                        child: DropdownButtonFormField(
                            decoration: const InputDecoration(
                              border: InputBorder.none
                              // enabledBorder: OutlineInputBorder(
                              //   borderSide:
                              //       BorderSide(color: Colors.blue, width: 2),
                              //   borderRadius: BorderRadius.circular(20),
                              // ),
                              // border: OutlineInputBorder(
                              //   borderSide:
                              //       BorderSide(color: Colors.blue, width: 2),
                              //   borderRadius: BorderRadius.circular(20),
                              // ),
                              // filled: true,
                              // fillColor: Colors.blueAccent,
                            ),
                            elevation: 0,
                            dropdownColor: bgColor3,
                            style: TextStyle(
                              color: primaryTextColor,
                            ),
                            value: paymentSelected,
                            onChanged: (String? newValue) {
                              setState(() {
                                paymentSelected = newValue!;
                              });
                            },
                            items: dropdownItems))
                  ],
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget personalInformation() {
      return Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(
          top: defaultMargin,
        ),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: bgColor4,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Personal Information',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            customerNameInput(),
            phoneInput()
          ],
        ),
      );
    }

    Widget addressInformation() {
      return Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(
          top: defaultMargin,
        ),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: bgColor4,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Address Information',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            // countryInput(),
            // provinceInput(),
            // cityInput(),
            // subdistrictInput(),
            showLocationFromMap(),
            addressDetailInput(),
          ],
        ),
      );
    }

    Widget paymentMethod() {
      return Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(
          top: defaultMargin,
        ),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: bgColor4,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Payment Information',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            paymentMethodInput()
          ],
        ),
      );
    }

    Widget paymentSummary() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
        ),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: bgColor4,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Payment Summary',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Subtotal',
                  style: secondaryTextStyle.copyWith(
                    fontSize: 14,
                  ),
                ),
                Text(
                  "\$${cartProvider.totalPrice.toStringAsFixed(2)}",
                  style: primaryTextStyle.copyWith(
                    fontWeight: medium,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Discount',
                  style: secondaryTextStyle.copyWith(
                    fontSize: 14,
                  ),
                ),
                Text(
                  "-\$${cartProvider.totalDiscount.toStringAsFixed(2)}",
                  style: primaryTextStyle.copyWith(
                    fontWeight: medium,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Delivery fee',
                  style: secondaryTextStyle.copyWith(
                    fontSize: 14,
                  ),
                ),
                Text(
                  "\$0",
                  style: primaryTextStyle.copyWith(
                    fontWeight: medium,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            const Divider(
              thickness: 1,
              color: Color(0xff2E3141),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Grand Total',
                  style: priceTextStyle.copyWith(
                    fontWeight: semiBold,
                  ),
                ),
                Text(
                  '\$${grandTotal}',
                  style: priceTextStyle.copyWith(
                    fontWeight: semiBold,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget checkoutButton() {
      return Column(
        children: [
          // NOTE: CHECKOUT BUTTON
          SizedBox(
            height: defaultMargin,
          ),
          const Divider(
            thickness: 1,
            color: Color(0xff2E3141),
          ),
          isLoading
              ? Container(
                  margin: const EdgeInsets.only(
                    bottom: 30,
                  ),
                  child: const LoadingButton(text: "Checking your order..."),
                )
              : Container(
                  height: 50,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(
                    vertical: defaultMargin,
                  ),
                  child: TextButton(
                    onPressed: handleCheckout,
                    style: TextButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Checkout',
                      style: primaryTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: semiBold,
                      ),
                    ),
                  ),
                ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: bgColor3,
      appBar: header(),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Column(
            children: [
              listItems(),
              personalInformation(),
              addressInformation(),
              paymentMethod(),
              paymentSummary(),
              checkoutButton(),
            ],
          ),
        ),
      ),
    );
  }
}
