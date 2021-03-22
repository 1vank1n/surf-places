import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/icons.dart';
import 'package:places/ui/res/text_styles.dart';

class AddSightScreen extends StatefulWidget {
  @override
  _AddSightScreenState createState() => _AddSightScreenState();
}

class _AddSightScreenState extends State<AddSightScreen> {
  late TextEditingController _titleTextEditingController;
  late TextEditingController _latTextEditingController;
  late TextEditingController _lonTextEditingController;

  @override
  void initState() {
    super.initState();

    _titleTextEditingController = TextEditingController();
    _titleTextEditingController.addListener(() {
      setState(() {});
    });

    _latTextEditingController = TextEditingController();
    _latTextEditingController.addListener(() {
      setState(() {});
    });

    _lonTextEditingController = TextEditingController();
    _lonTextEditingController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Новое место',
          style: Theme.of(context).textTheme.headline3,
        ),
        leading: TextButton(
          onPressed: () {},
          child: Text(
            'Отмена',
            style: subtitle1.copyWith(color: secondaryTextColor),
          ),
        ),
        leadingWidth: 100.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              subtitle: Text('КАТЕГОРИЯ'),
            ),
            ListTile(
              title: Text('Не выбрано'),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                color: primaryColor,
              ),
              onTap: () {},
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Divider(
                color: dividerColor,
              ),
            ),
            ListTile(
              subtitle: Text('НАЗВАНИЕ'),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                height: 40.0,
                child: TextFormField(
                  controller: _titleTextEditingController,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    suffixIcon: _titleTextEditingController.text.isNotEmpty
                        ? IconButton(
                            padding: EdgeInsets.zero,
                            iconSize: 20.0,
                            icon: SvgPicture.asset(iconClear),
                            onPressed: () {
                              _titleTextEditingController.text = '';
                            },
                          )
                        : null,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          subtitle: Text('ШИРОТА'),
                        ),
                        TextFormField(
                          controller: _latTextEditingController,
                          decoration: InputDecoration(
                            suffixIcon: _latTextEditingController.text.isNotEmpty
                                ? IconButton(
                                    padding: EdgeInsets.zero,
                                    iconSize: 20.0,
                                    icon: SvgPicture.asset(iconClear),
                                    onPressed: () {
                                      _latTextEditingController.text = '';
                                    },
                                  )
                                : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 16.0,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          subtitle: Text('ДОЛГОТА'),
                        ),
                        TextFormField(
                          controller: _lonTextEditingController,
                          decoration: InputDecoration(
                            suffixIcon: _lonTextEditingController.text.isNotEmpty
                                ? IconButton(
                                    padding: EdgeInsets.zero,
                                    iconSize: 20.0,
                                    icon: SvgPicture.asset(iconClear),
                                    onPressed: () {
                                      _lonTextEditingController.text = '';
                                    },
                                  )
                                : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: TextButton(
                child: Text(
                  'Указать на карте',
                  style: subtitle1.copyWith(
                    fontWeight: FontWeight.w500,
                    color: successColor,
                  ),
                ),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 0.0),
                ),
                onPressed: () {
                  print('Pressed map button');
                },
              ),
            ),
            ListTile(
              subtitle: Text('ОПИСАНИЕ'),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: TextFormField(
                maxLines: 4,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(16.0),
                  hintText: 'Введите текст',
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SizedBox(
            width: double.infinity,
            height: 48.0,
            child: ElevatedButton(
              onPressed: null,
              child: Text('СОЗДАТЬ'),
            ),
          ),
        ),
      ),
    );
  }
}
