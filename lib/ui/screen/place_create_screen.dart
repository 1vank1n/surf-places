import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/data/mwwm/place_create_wm.dart';
import 'package:places/data/redux/store.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/icons.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/screen/res/themes.dart';
import 'package:redux/redux.dart';
import 'package:relation/relation.dart';

class PlaceCreateScreen extends CoreMwwmWidget {
  PlaceCreateScreen({
    required WidgetModelBuilder widgetModelBuilder,
  }) : super(widgetModelBuilder: widgetModelBuilder);

  @override
  _PlaceCreateScreenState createState() => _PlaceCreateScreenState();
}

class _PlaceCreateScreenState extends WidgetState<PlaceCreateWidgetModel> {
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
          child: Text(
            'Отмена',
            style: subtitle1.copyWith(color: secondaryTextColor),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        leadingWidth: 100.0,
      ),
      body: ListView(
        physics: Platform.isIOS ? BouncingScrollPhysics() : ClampingScrollPhysics(),
        children: [
          _buildImageRow(),
          ListTile(
            subtitle: Text('КАТЕГОРИЯ'),
          ),
          ListTile(
            title: Text('Не выбрано'),
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
              color: Theme.of(context).primaryColor,
              size: 16,
            ),
            onTap: () {},
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Divider(color: dividerColor),
          ),
          ListTile(
            subtitle: Text('НАЗВАНИЕ'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              focusNode: wm.titleFocusNode,
              controller: wm.titleTextEditingController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: wm.requiredValidator,
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) {
                wm.latFocusNode.requestFocus();
              },
              decoration: InputDecoration(
                suffixIcon: wm.titleTextEditingController.text.isNotEmpty
                    ? IconButton(
                        padding: EdgeInsets.zero,
                        iconSize: 20.0,
                        icon: SvgPicture.asset(
                          iconClear,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: () {
                          wm.titleTextEditingController.text = '';
                        },
                      )
                    : null,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        subtitle: Text('ШИРОТА'),
                      ),
                      TextFormField(
                        focusNode: wm.latFocusNode,
                        controller: wm.latTextEditingController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: wm.requiredValidator,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]')),
                        ],
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          wm.lonFocusNode.requestFocus();
                        },
                        decoration: InputDecoration(
                          suffixIcon: wm.latTextEditingController.text.isNotEmpty
                              ? IconButton(
                                  padding: EdgeInsets.zero,
                                  iconSize: 20.0,
                                  icon: SvgPicture.asset(
                                    iconClear,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  onPressed: () {
                                    wm.latTextEditingController.text = '';
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
                        focusNode: wm.lonFocusNode,
                        controller: wm.lonTextEditingController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: wm.requiredValidator,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]')),
                        ],
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          wm.detailsFocusNode.requestFocus();
                        },
                        decoration: InputDecoration(
                          suffixIcon: wm.lonTextEditingController.text.isNotEmpty
                              ? IconButton(
                                  padding: EdgeInsets.zero,
                                  iconSize: 20.0,
                                  icon: SvgPicture.asset(
                                    iconClear,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  onPressed: () {
                                    wm.latTextEditingController.text = '';
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
            child: Container(
              alignment: Alignment.topLeft,
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
          ),
          ListTile(
            subtitle: Text('ОПИСАНИЕ'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              focusNode: wm.detailsFocusNode,
              controller: wm.detailsTextEditingController,
              validator: wm.requiredValidator,
              maxLines: 4,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) {
                wm.detailsFocusNode.unfocus();
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(16.0),
                hintText: 'Введите текст',
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SizedBox(
            width: double.infinity,
            height: 48.0,
            child: StreamedStateBuilder<bool>(
              streamedState: wm.isValidPlaceCreateState,
              builder: (BuildContext context, bool? isValid) {
                return ElevatedButton(
                  onPressed: (isValid ?? false) ? wm.addPlaceFromStateToRepository : null,
                  child: Text('СОЗДАТЬ'),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageRow() {
    return Container(
      height: 72.0,
      margin: const EdgeInsets.only(
        top: 24.0,
        right: 16.0,
        left: 16.0,
      ),
      child: StreamedStateBuilder<List<UploadImage>>(
        streamedState: wm.uploadImageListState,
        builder: (BuildContext context, List<UploadImage>? uploadImageList) {
          final uploadImages = uploadImageList ?? [];

          return ListView.separated(
            itemCount: uploadImages.length,
            physics: Platform.isIOS ? BouncingScrollPhysics() : ClampingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return uploadImages[index];
            },
            separatorBuilder: (BuildContext context, int index) => SizedBox(width: 16.0),
          );
        },
      ),
    );
  }
}

class ImageSourceDialog extends StatelessWidget {
  const ImageSourceDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Store<AppState> store = StoreProvider.of<AppState>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 6.0,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: store.state.settingsState.isDark ? deepDarkColor : Colors.white,
            ),
            child: Material(
              color: Colors.transparent,
              child: Column(
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                    leading: SvgPicture.asset(
                      iconCamera,
                      color: store.state.settingsState.isDark ? Colors.white : secondaryTextColor,
                    ),
                    minLeadingWidth: 0,
                    title: Text('Камера'),
                    onTap: () {
                      Navigator.of(context).pop(true);
                    },
                  ),
                  Divider(),
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                    leading: SvgPicture.asset(
                      iconPhoto,
                      color: store.state.settingsState.isDark ? Colors.white : secondaryTextColor,
                    ),
                    minLeadingWidth: 0,
                    title: Text('Фотография'),
                    onTap: () {
                      Navigator.of(context).pop(true);
                    },
                  ),
                  Divider(),
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                    leading: SvgPicture.asset(
                      iconFile,
                      color: store.state.settingsState.isDark ? Colors.white : secondaryTextColor,
                    ),
                    minLeadingWidth: 0,
                    title: Text('Файл'),
                    onTap: () {
                      Navigator.of(context).pop(true);
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 8.0),
          SizedBox(
            width: double.infinity,
            height: 48.0,
            child: Theme(
              data: ThemeData(
                elevatedButtonTheme: store.state.settingsState.isDark
                    ? darkCancelElevatedButton
                    : lightCancelElevatedButton,
              ),
              child: ElevatedButton(
                child: Text('ОТМЕНА'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class UploadImage extends StatelessWidget {
  final bool isCreator;
  final Function? addUploadImage;
  final Function? deleteUploadImage;

  String get _generateRandomImage =>
      'http://source.unsplash.com/random/72x72?sig=${Random().nextInt(100)}';

  const UploadImage({
    Key? key,
    this.isCreator = false,
    this.addUploadImage,
    this.deleteUploadImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isCreator
        ? GestureDetector(
            onTap: () {
              if (addUploadImage != null) {
                addUploadImage!();
              }
            },
            child: Container(
              width: 72.0,
              height: 72.0,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2.0,
                  color: successColor.withOpacity(0.48),
                ),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Center(child: SvgPicture.asset(iconPlus)),
            ),
          )
        : Dismissible(
            key: key ?? ValueKey('default'),
            direction: DismissDirection.up,
            onDismissed: (_) {
              if (deleteUploadImage != null) {
                deleteUploadImage!(key);
              }
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Stack(
                children: [
                  Container(
                    width: 72.0,
                    height: 72.0,
                    color: Colors.black12,
                    child: Image.network(
                      _generateRandomImage,
                      fit: BoxFit.cover,
                      loadingBuilder:
                          (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return CupertinoActivityIndicator();
                      },
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      color: overlayBgColor.withOpacity(0.24),
                    ),
                  ),
                  Positioned(
                    top: 6.0,
                    right: 6.0,
                    child: Container(
                      width: 20.0,
                      height: 20.0,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        iconSize: 20.0,
                        icon: SvgPicture.asset(
                          iconClear,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          if (deleteUploadImage != null) {
                            deleteUploadImage!(key);
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
