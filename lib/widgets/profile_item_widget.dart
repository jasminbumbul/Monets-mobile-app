import 'package:flutter/material.dart';
import 'package:monets/constants/color_pallete.dart';
import 'package:monets/screens/login_screen.dart';
import 'package:monets/services/http_service.dart';

class ProfileItem extends StatefulWidget {
  final Widget icon;
  final Color itemPaddingColor;
  final String itemName;
  final StatefulWidget redirectScreen;

  const ProfileItem(
      {Key? key,
      required this.icon,
      required this.itemPaddingColor,
      required this.itemName,
      required this.redirectScreen})
      : super(key: key);

  @override
  _ProfileItemState createState() => _ProfileItemState();
}

class _ProfileItemState extends State<ProfileItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: GestureDetector(
        onTap: () => widget.redirectScreen == LoginScreen()
            ? HttpService.logout().then((value) => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => LoginScreen()),
                (route) => false))
            : Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => widget.redirectScreen)),
        child: Row(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: widget.icon,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  color: widget.itemPaddingColor),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                widget.itemName,
                style: const TextStyle(
                    fontFamily: "Avenir-Medium",
                    fontWeight: FontWeight.w600,
                    color: ColorPallete.purple,
                    fontSize: 20.0),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                child: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black38,
                  size: 18.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
