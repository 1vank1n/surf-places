import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/main.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/common/widgets/sight_navigation_bar.dart';
import 'package:places/ui/common/widgets/sight_visited_card.dart';
import 'package:places/ui/common/widgets/sight_wanted_card.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/icons.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/screen/res/themes.dart';
import 'package:provider/provider.dart';

class VisitingScreen extends StatefulWidget {
  @override
  _VisitingScreenState createState() => _VisitingScreenState();
}

class _VisitingScreenState extends State<VisitingScreen> {
  final List<Sight> _wantedSights = []..addAll(SightStorage.sights);
  final List<Sight> _visitedSights = []..addAll(SightStorage.sights);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 108.0,
          title: Text(
            'Избранное',
            style: Theme.of(context).textTheme.headline3,
          ),
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(40.0),
            child: Theme(
              data: Theme.of(context).copyWith(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: Provider.of<AppModel>(context).theme == lightThemeData
                      ? lightBgColor
                      : deepDarkColor,
                  borderRadius: BorderRadius.circular(40.0),
                ),
                child: TabBar(
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
            ),
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

  Widget _buildWantedList() {
    return _wantedSights.length > 0
        ? ReorderableListView.builder(
            padding: const EdgeInsets.only(
              top: 22.0,
              right: 16.0,
              left: 16.0,
            ),
            itemCount: _wantedSights.length,
            physics: Platform.isIOS ? BouncingScrollPhysics() : ClampingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              Sight sight = _wantedSights[index];

              return Dismissible(
                key: ValueKey(sight.name),
                direction: DismissDirection.endToStart,
                onDismissed: (_) {
                  setState(() {
                    _wantedSights.remove(sight);
                  });
                },
                background: RemoveBackground(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: SightWantedCard(
                    key: ValueKey(sight.name),
                    sight: sight,
                    removeHandler: () {
                      setState(() {
                        _wantedSights.remove(sight);
                      });
                    },
                  ),
                ),
              );
            },
            onReorder: (int oldIndex, int newIndex) {
              if (oldIndex < newIndex) {
                newIndex -= 1;
              }

              final Sight sight = _wantedSights.removeAt(oldIndex);
              _wantedSights.insert(newIndex, sight);
            },
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

  Widget _buildVisitedList() {
    return _visitedSights.length > 0
        ? ReorderableListView.builder(
            padding: const EdgeInsets.only(
              top: 22.0,
              right: 16.0,
              left: 16.0,
            ),
            itemCount: _visitedSights.length,
            physics: Platform.isIOS ? BouncingScrollPhysics() : ClampingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              Sight sight = _visitedSights[index];

              return Dismissible(
                key: ValueKey(sight.name),
                direction: DismissDirection.endToStart,
                onDismissed: (_) {
                  setState(() {
                    _visitedSights.remove(sight);
                  });
                },
                background: RemoveBackground(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: SightVisitedCard(
                    key: ValueKey(sight.name),
                    sight: sight,
                    removeHandler: () {
                      setState(() {
                        _visitedSights.remove(sight);
                      });
                    },
                  ),
                ),
              );
            },
            onReorder: (int oldIndex, int newIndex) {
              if (oldIndex < newIndex) {
                newIndex -= 1;
              }

              final Sight sight = _visitedSights.removeAt(oldIndex);
              _visitedSights.insert(newIndex, sight);
            },
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
}

class RemoveBackground extends StatelessWidget {
  const RemoveBackground({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: Container(
        alignment: AlignmentDirectional.centerEnd,
        color: Colors.red,
        child: Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(iconBucket),
              SizedBox(height: 8.0),
              Text(
                'Удалить',
                style: subtitle2.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
