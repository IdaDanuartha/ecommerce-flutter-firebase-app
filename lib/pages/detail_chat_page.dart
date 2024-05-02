import 'package:flutter/material.dart';
import 'package:ecommerce_firebase/themes.dart';
import 'package:ecommerce_firebase/widgets/chat_bubble.dart';

class DetailChatPage extends StatelessWidget {
  const DetailChatPage({super.key});

  @override
  Widget build(BuildContext context) {

    PreferredSize appBar() {
      return PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          backgroundColor: bgColor1,
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset("assets/image_shop_logo_online.png", width: 40,),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Shoe Store', style: primaryTextStyle.copyWith(
                      fontWeight: medium,
                      fontSize: 14
                    ),),
                    Text(
                      'Online',
                      style: secondaryTextStyle.copyWith(
                        fontWeight: light,
                        fontSize: 12
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );
    }

    Widget productPreview() {
      return Container(
        width: 225,
        height: 74,
        margin: const EdgeInsets.only(
          bottom: 20
        ),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: bgColor5,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: primaryColor
          )
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/image_shoes.png',
                width: 54,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'COURT VISIO...',
                    style: primaryTextStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '\$57.15',
                    style: priceTextStyle.copyWith(
                      fontWeight: medium
                    ),
                  )
                ],
              ),
            ),
            Image.asset(
              'assets/button_close.png',
              width: 22,
            )
          ],
        ),
      );
    }

    Widget chatInput() {
      return Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            productPreview(),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 45,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      color: bgColor4,
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child: Center(
                      child: TextFormField(
                        decoration: InputDecoration.collapsed(
                          hintText: 'Type message...',
                          hintStyle: subtitleTextStyle,
                        ),
                        style: primaryTextStyle,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Image.asset(
                  'assets/button_send.png',
                  width: 45,
                )
              ],
            ),
          ],
        ),
      );
    }

    Widget content() {
      return ListView(
        padding: EdgeInsets.symmetric(
          horizontal: defaultMargin
        ),
        children: [
          const ChatBubble(
            isSender: true,
            text: 'Hi, This item is still available?',
            hasProduct: true,
          ),
          const ChatBubble(
            isSender: false,
            text: 'Good night, This item is only available in size 42 and 433',
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: bgColor3,
      appBar: appBar(),
      bottomNavigationBar: chatInput(),
      body: content(),
    );
  }
}