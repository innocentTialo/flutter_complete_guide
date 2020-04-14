import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/screens/orders_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 100,
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Text(
              'ShopApp',
              style: TextStyle(
                fontSize: 25,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          Divider(
            color: Theme.of(context).primaryColor,
          ),
          DrawerItem(
            routeName: '/',
            label: 'Shop',
            icon: Icons.shop,
          ),
          DrawerItem(
            routeName: OrdersScreen.routeName,
            label: 'Orders',
            icon: Icons.payment,
          ),
        ],
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    @required this.routeName,
    @required this.label,
    @required this.icon,
  });

  final String routeName;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.pushReplacementNamed(context, routeName);
      },
      leading: Icon(icon),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
