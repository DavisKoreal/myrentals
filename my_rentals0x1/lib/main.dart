import 'package:my_rentals/api/sheets/user_sheets_api.dart';
import 'package:my_rentals/const/constant.dart';
import 'package:my_rentals/screens/auth_page.dart';
import 'package:my_rentals/screens/complaints.dart';
import 'package:my_rentals/screens/feedback.dart';
import 'package:my_rentals/screens/history.dart';
// import 'package:my_rentals/screens/log_in_page.dart';
import 'package:my_rentals/screens/main_screen.dart';
import 'package:my_rentals/screens/data_input.dart';
import 'package:my_rentals/screens/communications.dart';
import 'package:my_rentals/screens/paid_houses_screen.dart';
import 'package:my_rentals/screens/power_management.dart';
import 'package:my_rentals/screens/profile.dart';
import 'package:my_rentals/screens/remove_edit_screen.dart';
import 'package:my_rentals/screens/settings.dart';
import 'package:my_rentals/screens/sign_out.dart';
import 'package:my_rentals/screens/edit_automatic_days.dart';
import 'package:flutter/material.dart';
// import 'package:my_rentals/services/database_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_rentals/screens/unpaid_houses_screen.dart';
import 'package:my_rentals/screens/update_tenant_details.dart';
import 'package:my_rentals/screens/water_management.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  UserSheetsApi.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes:{
        '/': (context) => const AuthPage(),
        '/main_screen': (context) => const MainScreen(),
        '/complaints': (context) => const Complaints(),
        '/data_input': (context)=> const DataInputPage(),
        '/communications': (context)=> const Communications(),
        '/profile':(context)=> Profile(),
        '/settings':(context)=> const Settings(),
        '/history':(context)=> const History(),
        '/sign_out':(context)=> const SignOut(),
        '/feedback':(context)=> const FeedbackPage(),
        '/power_management':(context)=> const PowerManagementPage(),
        '/water_management':(context)=> const WaterManagement(),
        '/paid_houses_screen':(context)=> const PaidHousesScreen(),
        '/unpaid_houses_screen':(context)=> const UnpaidHousesScreen(),
        '/remove_edit_screen':(context)=> const RemoveEditScreen(),
        '/update_tenant_details':(context)=> const UpdateTenantDetails(),
        '/edit_automatic_days':(context)=> const EditAutomaticDaysPage(),
      },
      title: 'MyRentals',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundColor,
        brightness: Brightness.dark,
      ),
    );
  }
}
