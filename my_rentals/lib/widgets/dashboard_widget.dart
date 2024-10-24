// import 'package:my_rentals/util/responsive.dart';
import 'package:my_rentals/widgets/activity_details_card.dart';
//import 'package:fitness_dashboard_ui/widgets/bar_graph_widget.dart';
import 'package:my_rentals/widgets/header_widget.dart';
import 'package:my_rentals/widgets/hello_landlord.dart';
import 'package:my_rentals/widgets/line_chart_card.dart';
// import 'package:my_rentals/widgets/summary_widget.dart';
import 'package:flutter/material.dart';

class DashboardWidget extends StatelessWidget {
  const DashboardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            SizedBox(height: 18),
            HeaderWidget(),
            SizedBox(height: 18),
            HelloLandlordWidget(),
            SizedBox(height: 18),
            ActivityDetailsCard(),
            SizedBox(height: 18),
            LineChartCard(),
            SizedBox(height: 18),
            //const BarGraphCard(), Commented this out because of overflow
            //const SizedBox(height: 18),
            // if (Responsive.isTablet(context)) const SummaryWidget(),
          ],
        ),
      ),
    );
  }
}
