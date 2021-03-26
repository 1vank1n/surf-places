import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/common/widgets/sight_card.dart';
import 'package:places/ui/common/widgets/sight_navigation_bar.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/screen/widgets/search_bar.dart';

class SightListScreen extends StatefulWidget {
  @override
  _SightListScreenState createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Список интересных мест',
          style: Theme.of(context).textTheme.headline3,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(52.0),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 0,
              right: 16.0,
              bottom: 12.0,
              left: 16.0,
            ),
            child: SearchBar(
              searchTextEditingController: TextEditingController(),
              isButton: true,
            ),
          ),
        ),
        //
        // TODO непонятно какой окончательный стиль заголовка
        // bottom: PreferredSize(
        //   preferredSize: const Size.fromHeight(72.0),
        //   child: Container(
        //     width: double.infinity,
        //     padding: const EdgeInsets.symmetric(horizontal: 16.0),
        //     child: Text(
        //       'Список\nинтересных мест',
        //       style: Theme.of(context).textTheme.headline1,
        //     ),
        //   ),
        // ),
        //
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [for (var sight in SightStorage.sights) SightCard(sight)],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          print('Pressed FAB');
        },
        backgroundColor: Colors.transparent,
        elevation: 0,
        label: Container(
          height: 48.0,
          padding: EdgeInsets.symmetric(horizontal: 22.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                warningColor,
                successColor,
              ],
            ),
            borderRadius: BorderRadius.circular(24.0),
          ),
          child: Row(
            children: [
              Icon(Icons.add),
              SizedBox(
                width: 8.0,
              ),
              Text(
                'НОВОЕ МЕСТО',
                style: button,
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: SightNavigationBar(),
    );
  }
}
