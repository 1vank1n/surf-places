import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/common/widgets/sight_card.dart';
import 'package:places/ui/common/widgets/sight_navigation_bar.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/text_styles.dart';

class SightListScreen extends StatefulWidget {
  @override
  _SightListScreenState createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(72.0),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Список\nинтересных мест',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [for (var sight in mocks) SightCard(sight)],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          print('Pressed FAB');
        },
        backgroundColor: Colors.transparent,
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
