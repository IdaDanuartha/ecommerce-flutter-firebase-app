import 'package:flutter/material.dart';
import 'package:MushMagic/themes.dart';

class LoadingButton extends StatelessWidget {
  const LoadingButton({super.key, required this.text, this.marginTop = 30});

  final String text;
  final double marginTop;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      margin: EdgeInsets.only(top: marginTop),
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation(
                  primaryTextColor,
                ),
              ),
            ),
            SizedBox(
              width: 6,
            ),
            Text(
              "$text",
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
