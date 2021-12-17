import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rapid_mobile_app/data/module/dashboard/dashboard_controller.dart';
import 'package:rapid_mobile_app/data/widget/bottom_bar_widget/home_bottom_bar_widget.dart';
import 'package:rapid_mobile_app/res/values/colours.dart';
import 'package:rapid_mobile_app/res/values/strings.dart';

class Dashboard extends GetView<DashboardController> {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        title: Text(Strings.kDashboard.tr),
        centerTitle: true,
        leading: const Padding(
          padding: EdgeInsets.only(
            left: 5,
            top: 15,
          ),
          child: SelectedIconWidget(icon: Icons.menu),
        ),
        actions: const [

          Padding(
            padding: EdgeInsets.only(
              left: 5,
              top: 15,
            ),
            child: SelectedIconWidget(icon: Icons.person),
          ),
        ],
        elevation: 0,
        backgroundColor: colours.background_bottom,
      ),
      body: _bodyWidget(context),
      bottomNavigationBar: const HomeBottomBarWidget(),
    );
  }
}

class SelectedIconWidget extends StatelessWidget {
  const SelectedIconWidget({Key? key, required this.icon}) : super(key: key);

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 40,
      height: 40,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(5),
        color: colours.icon_background_light_grey,
      ),
      child: Icon(
        icon,
        size: 24,
        color: colours.black,
      ),
    );
  }
}

Widget _bodyWidget(BuildContext context) {
  return Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
          colors: [
            colours.background_top,
            colours.background_bottom,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [-707, -169]),
    ),
    child: Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(10),
          // child: const AppBottomBarWidget(),
        ),
      ],
    ),
  );
}

void onTapLeadingIcon() {
  // Scaffold.of(context).openDrawer();
}

void onTapActionIcon() {}

class AppBodyWidget extends StatelessWidget {
  const AppBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
