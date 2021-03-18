import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/common/widgets/sight_navigation_bar.dart';
import 'package:places/ui/common/widgets/sight_visited_card.dart';
import 'package:places/ui/common/widgets/sight_wanted_card.dart';

class VisitingScreen extends StatefulWidget {
  @override
  _VisitingScreenState createState() => _VisitingScreenState();
}

class _VisitingScreenState extends State<VisitingScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Избранное',
            style: Theme.of(context).textTheme.headline3,
          ),
          elevation: 0,
          bottom: TabBar(
            indicatorColor: Colors.transparent,
            tabs: [
              Tab(
                child: Text('Хочу посетить'),
              ),
              Tab(
                child: Text('Посетил'),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: mocks.map((sight) => SightWantedCard(sight)).toList(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: mocks.map((sight) => SightVisitedCard(sight)).toList(),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: SightNavigationBar(),
      ),
    );
  }
}
