import 'package:flutter/material.dart';
import 'package:folding_cell/folding_cell.dart';
import 'package:rapid_mobile_app/res/values/colours.dart';

class DetailedPage extends StatefulWidget {
  const DetailedPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DetailedPage();
  }
}

class _DetailedPage extends State<DetailedPage> {
  final _foldingCellKey = GlobalKey<SimpleFoldingCellState>();

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
                alignment: Alignment.topCenter,
                child: _appbodyWidget(context),
              ),
            ),
            Expanded(
              flex: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: AppBottombarWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _appbodyWidget(BuildContext context) {
    return SimpleFoldingCell.create(
      key: _foldingCellKey,
      frontWidget: _buildFrontWidget(),
      innerWidget: _buildInnerWidget(),
      cellSize: Size(MediaQuery.of(context).size.width, 100),
      padding: const EdgeInsets.all(10),
      animationDuration: const Duration(microseconds: 300),
      borderRadius: 10,
      onOpen: () => print('cell open'),
      onClose: () => print("cell close"),
    );
  }

  Widget _buildFrontWidget() {
    return Container(
      color: colours.card_background,
      padding: const EdgeInsets.all(15),
      // alignment: Alignment.center,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Text(
              "User Type",
              style: TextStyle(
                color: colours.text_color,
                fontSize: 16,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
              flex: 0,
              child: IconButton(
                icon: const Icon(Icons.keyboard_arrow_down_rounded),
                onPressed: () => _foldingCellKey.currentState?.toggleFold(),
              ))
        ],
      ),
    );
  }

  Widget _buildInnerWidget() {
    return Container(
      padding: const EdgeInsets.all(15),
      color: colours.card_background,
      child: Row(
        children: [
          const Expanded(
            flex: 1,
            child: Text(
              "User Type1",
              style: TextStyle(
                color: colours.text_color,
                fontSize: 16,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
              flex: 0,
              child: IconButton(
                icon: const Icon(Icons.keyboard_arrow_up_rounded),
                onPressed: () => _foldingCellKey.currentState?.toggleFold(),
              ))
        ],
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
              icon: const Icon(Icons.arrow_back),
              color: colours.icon_black,
              iconSize: 24,
            ),
          ),
        ),
        const Expanded(
          flex: 1,
          child: Center(
            child: Text(
              'Users',
              style: TextStyle(
                  color: colours.black,
                  fontSize: 20,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
        Expanded(
          flex: 0,
          child: Container(
            alignment: Alignment.center,
            height: 45,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(5),
              color: colours.icon_background_light_grey,
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
              color: colours.icon_black,
              iconSize: 24,
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
    return Container();
  }
}

class AppBottombarWidget extends StatelessWidget {
  const AppBottombarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: colours.black,
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.only(left: 5, top: 10, right: 5, bottom: 10),
      child: Row(
        children: <Widget>[
          Expanded(
              flex: 1,
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
                        color: colours.icon_background_dark_grey),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.settings),
                      color: colours.yellow,
                      iconSize: 24,
                    ),
                  )
                ],
              )),
          Expanded(
            flex: 0,
            child: Container(
              width: 3,
              height: 38,
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5),
                  color: colours.icon_background_dark_grey),
            ),
          ),
          Expanded(
              flex: 0,
              child: Container(
                alignment: Alignment.center,
                width: 40,
                height: 40,
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(5),
                    color: colours.icon_background_dark_grey),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.keyboard_arrow_down_rounded),
                  color: colours.yellow,
                  iconSize: 24,
                ),
              )),
        ],
      ),
    );
  }
}
