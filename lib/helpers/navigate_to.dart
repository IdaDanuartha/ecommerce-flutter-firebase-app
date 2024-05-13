import 'package:url_launcher/url_launcher.dart';

void navigateTo(double lat, double lng) async {
   var uri = Uri.parse("google.navigation:q=$lat,$lng&mode=d");
   if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
   } else {
      throw 'Could not launch ${uri.toString()}';
   }
}
