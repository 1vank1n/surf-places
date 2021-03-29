import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/common/widgets/sight_navigation_bar.dart';
import 'package:places/ui/common/widgets/sight_visited_card.dart';
import 'package:places/ui/common/widgets/sight_wanted_card.dart';
import 'package:places/ui/res/icons.dart';
import 'package:places/ui/res/text_styles.dart';

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
            //
            // Wanted
            //
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (var i = 0; i < _wantedSights.length; i++)
                      Column(
                        children: [
                          LongPressDraggable<Sight>(
                            key: ValueKey(_wantedSights[i].name),
                            data: _wantedSights[i],
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16.0),
                              child: Dismissible(
                                key: ValueKey(_wantedSights[i].name),
                                direction: DismissDirection.endToStart,
                                onDismissed: (_) {
                                  setState(() {
                                    _wantedSights.remove(_wantedSights[i]);
                                  });
                                },
                                background: RemoveBackground(),
                                child: SightWantedCard(
                                  key: ValueKey(_wantedSights[i].name),
                                  sight: _wantedSights[i],
                                ),
                              ),
                            ),
                            feedback: ClipRRect(
                              borderRadius: BorderRadius.circular(16.0),
                              child: Material(
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxWidth: double.infinity,
                                    maxHeight: (MediaQuery.of(context).size.width - 24) * 2 / 3,
                                  ),
                                  child: SightWantedCard(
                                    key: ValueKey(_wantedSights[i].name),
                                    sight: _wantedSights[i],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          DragTarget<Sight>(
                            onAccept: (Sight? sight) {
                              setState(() {
                                _wantedSights.remove(sight!);
                                _wantedSights.insert(i + 1, sight);
                              });
                            },
                            builder: (BuildContext context, List<Sight?> candidates, rejects) {
                              if (candidates.length > 0 && candidates.first != null) {
                                return SightWantedCard(
                                  key: ValueKey(candidates.first!.name),
                                  sight: candidates.first!,
                                );
                              }
                              return Container(
                                width: double.infinity,
                                height: 24.0,
                              );
                            },
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
            //
            // Visited
            //
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (var i = 0; i < _visitedSights.length; i++)
                      Column(
                        children: [
                          LongPressDraggable<Sight>(
                            key: ValueKey(_visitedSights[i].name),
                            data: _visitedSights[i],
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16.0),
                              child: Dismissible(
                                key: ValueKey(_visitedSights[i].name),
                                direction: DismissDirection.endToStart,
                                onDismissed: (_) {
                                  setState(() {
                                    _visitedSights.remove(_visitedSights[i]);
                                  });
                                },
                                background: RemoveBackground(),
                                child: SightWantedCard(
                                  key: ValueKey(_visitedSights[i].name),
                                  sight: _visitedSights[i],
                                ),
                              ),
                            ),
                            feedback: ClipRRect(
                              borderRadius: BorderRadius.circular(16.0),
                              child: Material(
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxWidth: double.infinity,
                                    maxHeight: (MediaQuery.of(context).size.width - 24) * 2 / 3,
                                  ),
                                  child: SightVisitedCard(
                                    key: ValueKey(_visitedSights[i].name),
                                    sight: _visitedSights[i],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          DragTarget<Sight>(
                            onAccept: (Sight? sight) {
                              setState(() {
                                _visitedSights.remove(sight!);
                                _visitedSights.insert(i + 1, sight);
                              });
                            },
                            builder: (BuildContext context, List<Sight?> candidates, rejects) {
                              if (candidates.length > 0 && candidates.first != null) {
                                return SightVisitedCard(
                                  key: ValueKey(candidates.first!.name),
                                  sight: candidates.first!,
                                );
                              }
                              return Container(
                                width: double.infinity,
                                height: 24.0,
                              );
                            },
                          ),
                        ],
                      ),
                  ],
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

class RemoveBackground extends StatelessWidget {
  const RemoveBackground({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
