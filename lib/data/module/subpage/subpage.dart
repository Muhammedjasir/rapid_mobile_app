import 'package:flutter/material.dart';
import 'package:rapid_mobile_app/res/values/colours.dart';

class SubPage extends StatefulWidget {
  const SubPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SubPage();
  }
}

class _SubPage extends State<SubPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              colours.background_top,
              colours.background_bottom,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [-707, -169],
          ),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(
                  left: 10,
                  top: 40,
                  right: 10,
                  bottom: 10,
                ),
                child: const AppbarWidget(),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                // width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(5),
                width: 200,
                height: 50,
                child: const AppBodyWidget(),
              ),
            ),
            Expanded(
              flex: 0,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: const AppBottomWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppbarWidget extends StatelessWidget {
  const AppbarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 0,
          child: Container(
            alignment: Alignment.center,
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(5),
              color: colours.icon_background_light_grey,
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.menu),
              color: colours.icon_black,
              iconSize: 24,
            ),
          ),
        ),
        const Expanded(
          flex: 1,
          child: Center(
            child: Text(
              'Service',
              style: TextStyle(
                color: colours.black,
                fontSize: 20,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AppBodyWidget extends StatelessWidget {
  const AppBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: colours.card_background,
      elevation: 1,
      child: Container(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.menu),
              color: colours.icon_black,
              iconSize: 30,
            ),
          ],
        ),
      ),
    );
  }
}

class AppBottomWidget extends StatelessWidget {
  const AppBottomWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: colours.black,
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            width: 40,
            height: 40,
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(5),
              color: colours.icon_background_dark_grey,
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.settings),
              color: colours.yellow,
              iconSize: 24,
            ),
          )
        ],
      ),
    );
  }
}
