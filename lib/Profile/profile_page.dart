import 'package:flutter/material.dart';
import 'package:hit_api_two/Favorite/favorite_page.dart';
import 'package:hit_api_two/Helper/themes.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/carbon.dart';

import '../Navbar_Widget/navbar_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        titleTextStyle: titlePageStyle,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: IconButton(onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => FavoritePage()));
              }, icon: Iconify(Carbon.favorite), color: Colors.red,),
          )
        ],
      ),
      bottomNavigationBar: CustomNavigationBar(),
    );
  }
}
