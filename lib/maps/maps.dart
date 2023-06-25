import 'package:url_launcher/url_launcher.dart';

class MapsUtils
{
  MapsUtils._();

  //latitude longitude
  static Future<void> openMapWithPosition(double latitude, double longitude) async
  {

    Uri googleMapUrl = Uri.parse("https://www.google.com/maps/search/?api=1&query=$latitude,$longitude");
     await launchUrl(googleMapUrl);
    // if(await canLaunchUrl(googleMapUrl))
    // {
    //   print("Asher");
    //   print('Could not launch $googleMapUrl');
    //   await launchUrl(googleMapUrl);
    // }
    // else
    // {
    //   print('Could not launch $googleMapUrl');
    //
    //   throw "Could not open the map.";
    // }
  }

  //text address
  static Future<void> openMapWithAddress(String fullAddress) async
  {
    String query = Uri.encodeComponent(fullAddress);

    Uri googleMapUrl = Uri.parse('https://www.google.com/maps/search/?api=1&query=$query');

     await launchUrl(googleMapUrl);

  }

}