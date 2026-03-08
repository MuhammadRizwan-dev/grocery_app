import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grocery_app/components/utils.dart';
import 'package:grocery_app/controllers/cart_controller.dart';
import 'package:grocery_app/controllers/order_controller.dart';
import 'package:grocery_app/screens/orderAccepted_screen.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final List<String> myStripeSecrets = [
    "pi_3T8iXcJ9jDKffTGg1qxau3Lo_secret_daiIXblwzavs9ohMsCM46BM5X",
    "pi_3T8iYHJ9jDKffTGg0aOHmYHu_secret_wqJCVv8ch1fi1wgGaYUCPjXAW",
    "pi_3T8iYYJ9jDKffTGg1QR2ASgS_secret_UWdwri2sI2YwjtkF4PKDNYRqD",
    "pi_3T8iYnJ9jDKffTGg0cFWNVDd_secret_97LsxL0IrMnbCo8fnGvoAeevK",
    "pi_3T8iZ5J9jDKffTGg0aydjPHr_secret_Ms9BSOyeaijyMmIQKru7jScaK",
  ];
  static int secretIndex = 0;
  final CartController cartController = Get.find();
  final OrderController orderController = Get.put(OrderController());
  String selectedDeliveryMethod = "Selected Method";
  String selectedPaymentMethod = "Credit Card";
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        color: AppColors.whiteColor,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "CheckOut",
                  style: TextStyle(
                    fontFamily: "Gilroy",
                    fontWeight: FontWeight.w600,
                    fontSize: 24.sp,
                  ),
                ),
                IconButton(
                  onPressed: () => Get.back(),
                  icon: Icon(Icons.close),
                ),
              ],
            ),
            Divider(thickness: 1),
            _buildCheckoutRow(
              label: "Delivery",
              value: selectedDeliveryMethod,
              onTap: () => showSelectedOption(
                "Delivery Method",
                ["Standard", "Express", "Next Day"],
                (selectedText) =>
                    setState(() => selectedDeliveryMethod = selectedText),
              ),
            ),
            _buildCheckoutRow(
              label: "Payment",
              value: selectedPaymentMethod,
              trailingWidget: selectedPaymentMethod == "Credit Card"
                  ? Icon(Icons.payment_sharp, color: Colors.red)
                  : null,
              onTap: () => showSelectedOption(
                "Payment Methods",
                ["Cash On Delivery", "Credit Card", "Apple Pay"],
                (selectedText) =>
                    setState(() => selectedPaymentMethod = selectedText),
              ),
            ),
            _buildCheckoutRow(
              label: "Promo Card",
              value: "Pick Discount",
              onTap: () => showSelectedOption("Select Promo", [
                "New User 50%",
                "Summer Sale",
                "Free Delivery",
              ], (selectedText) => Utils.showSnackBar(selectedText)),
            ),
            _buildCheckoutRow(
              label: "Total Cost",
              trailingWidget: Obx(
                () => Text(
                  "\$${cartController.totalPrice.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontFamily: "Gilroy",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 15.h),
            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontFamily: "Gilroy",
                  color: AppColors.lightGrey,
                  fontSize: 13.sp,
                ),
                children: [
                  TextSpan(text: "By placing an order you agree to \nour "),
                  TextSpan(
                    text: "Terms",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(text: " and "),
                  TextSpan(
                    text: "Conditions",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            AppButtons.socialButton(
              text: "Place Order",
              onPressed: () async {
                List itemsForOrder = cartController.cartItems.toList();

                if (itemsForOrder.isEmpty) {
                  Utils.showSnackBar("Your cart is empty!", color: Colors.red);
                  return;
                }

                if (selectedPaymentMethod == "Credit Card") {
                  try {
                    if (secretIndex >= myStripeSecrets.length) {
                      Utils.showSnackBar(
                        "No more test secrets left. Generate more!",
                        color: Colors.orange,
                      );
                      return;
                    }
                    String currentSecret = myStripeSecrets[secretIndex];
                    await Stripe.instance.initPaymentSheet(
                      paymentSheetParameters: SetupPaymentSheetParameters(
                        paymentIntentClientSecret: currentSecret,
                        merchantDisplayName: 'Fresh Grocery Store',
                        appearance: PaymentSheetAppearance(
                          colors: PaymentSheetAppearanceColors(
                            primary: AppColors.primaryColor,
                            background: AppColors.whiteColor,
                            componentBackground: AppColors.verylightgrey,
                            componentBorder: AppColors.lightGrey,
                            primaryText: Colors.black,
                            secondaryText: AppColors.lightGrey,
                            placeholderText: AppColors.lightGrey,
                            icon: AppColors.primaryColor,
                            error: Colors.red,
                          ),
                          shapes: PaymentSheetShape(
                            borderRadius: 12.r,
                            borderWidth: 1.0,
                          ),
                          primaryButton: PaymentSheetPrimaryButtonAppearance(
                            shapes: PaymentSheetPrimaryButtonShape(
                              blurRadius: 8.r,
                            ),
                            colors: PaymentSheetPrimaryButtonTheme(
                              light: PaymentSheetPrimaryButtonThemeColors(
                                background: AppColors.primaryColor,
                                text: AppColors.whiteColor,
                              ),
                            ),
                          ),
                        ),
                        style: ThemeMode.light,
                      ),
                    );
                    await Stripe.instance.presentPaymentSheet();
                    setState(() {
                      secretIndex++;
                    });
                    await _finishOrder(itemsForOrder, "Credit Card", "Paid");
                  } catch (e) {
                    if (e is StripeException) {
                      Utils.showSnackBar(
                        "Payment Cancelled",
                        color: Colors.red,
                      );
                    } else {
                      Utils.showSnackBar("Error: $e", color: Colors.red);
                    }
                  }
                } else if (selectedPaymentMethod == "Cash On Delivery") {
                  await _finishOrder(
                    itemsForOrder,
                    "Cash On Delivery",
                    "Pending",
                  );
                } else {
                  Utils.showSnackBar(
                    "This method is coming soon!",
                    color: Colors.orange,
                  );
                }
              },
              bgColor: AppColors.primaryColor,
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }

  Future<void> _finishOrder(List items, String method, String status) async {
    String? generatedOrderId = await orderController.placeOrder(
      items: items,
      total: cartController.totalPrice,
      address: "User's Delivery Address",
      paymentMethod: method,
      paymentStatus: status,
    );

    if (generatedOrderId != null) {
      Get.offAll(() => OrderAcceptedScreen(orderId: generatedOrderId));
    } else {
      Utils.showSnackBar("Order failed to save!", color: Colors.red);
    }
  }

  void showSelectedOption(
    String title,
    List<String> options,
    Function(String) onSelected,
  ) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
            ),
            Divider(),
            ...options.map(
              (option) => ListTile(
                title: Text(option),
                trailing: Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  onSelected(option);
                  Get.back();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckoutRow({
    required String label,
    String? value,
    Widget? trailingWidget,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.h),
            child: Row(
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontFamily: "Gilroy",
                    color: AppColors.lightGrey,
                  ),
                ),
                Spacer(),
                if (value != null)
                  Text(
                    value,
                    style: TextStyle(
                      fontFamily: "Gilroy",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                if (trailingWidget != null) trailingWidget,
                SizedBox(width: 5.w),
                Icon(Icons.arrow_forward_ios_sharp, size: 16),
              ],
            ),
          ),
          Divider(thickness: 1),
        ],
      ),
    );
  }
}
