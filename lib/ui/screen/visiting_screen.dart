import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/common/widgets/sight_navigation_bar.dart';
import 'package:places/ui/common/widgets/sight_visited_card.dart';
import 'package:places/ui/common/widgets/sight_wanted_card.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/icons.dart';
import 'package:places/ui/res/text_styles.dart';

class VisitingScreen extends StatefulWidget {
  @override
  _VisitingScreenState createState() => _VisitingScreenState();
}

class _VisitingScreenState extends State<VisitingScreen> {
  List<Sight> _wantedSights = []..addAll(SightStorage.sights);
  List<Sight> _visitedSights = []..addAll(SightStorage.sights);

  void _removeSights({
    required List<Sight> sights,
    required int index,
  }) {
    setState(() {
      sights.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
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
            _buildWantedList(),
            _buildVisitedList(),
          ],
        ),
        bottomNavigationBar: SightNavigationBar(),
      ),
    );
  }

  Widget _buildVisitedList() {
    return _visitedSights.length > 0
        ? SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  for (var i = 0; i < _visitedSights.length; i++)
                    SightVisitedCard(
                      sight: _visitedSights[i],
                      removeHandler: () {
                        _removeSights(sights: _visitedSights, index: i);
                      },
                    )
                ],
              ),
            ),
          )
        : Center(
            child: Padding(
              padding: const EdgeInsets.all(48.0),
              child: Opacity(
                opacity: 0.56,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      iconGo,
                      width: 64.0,
                      height: 64.0,
                      color: secondaryTextColor,
                    ),
                    SizedBox(height: 24.0),
                    Text(
                      'Пусто',
                      style: headline3,
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Завершите маршрут, чтобы место попало сюда.',
                      style: textBody1,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  Widget _buildWantedList() {
    return _wantedSights.length > 0
        ? SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  for (var i = 0; i < _wantedSights.length; i++)
                    SightWantedCard(
                      sight: _wantedSights[i],
                      removeHandler: () {
                        _removeSights(sights: _wantedSights, index: i);
                      },
                    )
                ],
              ),
            ),
          )
        : Center(
            child: Padding(
              padding: const EdgeInsets.all(48.0),
              child: Opacity(
                opacity: 0.56,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      iconWanted,
                      width: 64.0,
                      height: 64.0,
                    ),
                    SizedBox(height: 24.0),
                    Text(
                      'Пусто',
                      style: headline3,
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Отмечайте понравившиеся места и они появиятся здесь.',
                      style: textBody1,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
