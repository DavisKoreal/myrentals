import 'package:my_rentals/model/menu_model.dart';
import 'package:flutter/material.dart';

class SideMenuData {
  final menu = const <MenuModel>[
    MenuModel(icon: Icons.home, title: 'Dashboard', nextScreen: '/'),
    MenuModel(icon: Icons.message, title: 'Send Messages', nextScreen: '/communications'),
    MenuModel(icon: Icons.person, title: 'Hear Complaints', nextScreen: "/complaints"),
    MenuModel(icon: Icons.power, title: 'Manage Power', nextScreen: '/power_management'),
    MenuModel(icon: Icons.water, title: 'Manage Water', nextScreen: '/water_management'),
    MenuModel(icon: Icons.dataset, title: 'Add Tenant', nextScreen: '/data_input'),
    MenuModel(icon: Icons.person_remove_outlined, title: 'Edit/Remove Tenant', nextScreen:'/remove_edit_screen'),
    MenuModel(icon: Icons.phone_in_talk, title: 'Talk to us', nextScreen: '/feedback'),
    MenuModel(icon: Icons.person, title: 'Your Profile', nextScreen: '/profile'),
    MenuModel(icon: Icons.settings, title: 'Change Settings', nextScreen: '/settings'),
    MenuModel(icon: Icons.logout, title: 'SignOut', nextScreen: '/sign_out'),
  ];
}
