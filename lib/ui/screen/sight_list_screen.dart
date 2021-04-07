import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/main.dart' show AppRouter;
import 'package:places/mocks.dart';
import 'package:places/ui/common/widgets/sight_card.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/screen/widgets/search_bar.dart';

class SightListScreen extends StatefulWidget {
  @override
  _SightListScreenState createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  ScrollController _scrollController = ScrollController();
  double _titleOpacity = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        if (_scrollController.offset > 200) {
          _titleOpacity = 1;
        } else if (_scrollController.offset < 100) {
          _titleOpacity = 0;
        } else {
          _titleOpacity = (_scrollController.offset - 100) / 100;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            elevation: 0,
            pinned: true,
            title: Opacity(
              opacity: _titleOpacity,
              child: Text(
                'Список интересных мест',
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            expandedHeight: 142.0 + MediaQuery.of(context).padding.top,
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Список\nинтересных мест',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    SizedBox(height: 30.0),
                    SearchBar(
                      searchTextEditingController: TextEditingController(),
                      isButton: true,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 24.0),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                Sight sight = SightStorage.sights[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 12.0,
                  ),
                  child: SightCard(
                    key: ValueKey(sight),
                    sight: sight,
                  ),
                );
              },
              childCount: SightStorage.sights.length,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
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
        onPressed: () {
          Navigator.of(context).pushNamed(AppRouter.sightCreate);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
