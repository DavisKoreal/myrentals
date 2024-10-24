import 'dart:core';
import 'package:my_rentals/model/health_model.dart';
// import 'package:my_rentals/services/database_service.dart';

class HealthDetails {
  List<HealthModel> healthData = [
    HealthModel(icon: 'assets/icons/paid_house.jpg', value: "loading", title: "Paid Houses"),
    HealthModel(icon: 'assets/icons/unpaid_house.jpg', value: "loading", title: "Unpaid Houses"),
    HealthModel(icon: 'assets/icons/paid_rent.jpg', value: "loading", title: "Rent paid"),
    HealthModel(icon: 'assets/icons/unpaid_rent.jpeg', value: "loading", title: "Remaining Rent"),
  ];
}