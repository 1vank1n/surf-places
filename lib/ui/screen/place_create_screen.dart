import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/main.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/icons.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/screen/res/themes.dart';
import 'package:provider/provider.dart';

class PlaceCreateScreen extends StatefulWidget {
  @override
  _PlaceCreateScreenState createState() => _PlaceCreateScreenState();
}

class _PlaceCreateScreenState extends State<PlaceCreateScreen> {
  final PlaceInteractor _placeInteractor = PlaceInteractor();
  List<UploadImage> _uploadImages = [];
  TextEditingController _titleTextEditingController = TextEditingController();
  TextEditingController _latTextEditingController = TextEditingController();
  TextEditingController _lonTextEditingController = TextEditingController();
  TextEditingController _detailsTextEditingController = TextEditingController();
  FocusNode _titleFocusNode = FocusNode();
  FocusNode _latFocusNode = FocusNode();
  FocusNode _lonFocusNode = FocusNode();
  FocusNode _detailsFocusNode = FocusNode();
  bool get isValidPlaceCreateForm {
    return _titleTextEditingController.text.isNotEmpty &&
        _latTextEditingController.text.isNotEmpty &&
        _lonTextEditingController.text.isNotEmpty;
  }

  @override
  void initState() {
    super.initState();

    _titleTextEditingController.addListener(() {
      setState(() {});
    });

    _latTextEditingController.addListener(() {
      setState(() {});
    });

    _lonTextEditingController.addListener(() {
      setState(() {});
    });

    _detailsTextEditingController.addListener(() {
      setState(() {});
    });

    _uploadImages.add(
      UploadImage(
        isCreator: true,
        addUploadImage: _addUploadImage,
      ),
    );
  }

  String? requiredValidator(String? value) {
    if (value != null && value.length > 0) {
      return null;
    } else {
      return 'Поле обязательно';
    }
  }

  Place createPlaceFromState() {
    return Place(
      id: 0,
      name: _titleTextEditingController.text,
      lat: double.parse(_latTextEditingController.text),
      lng: double.parse(_lonTextEditingController.text),
      urls: [],
      description: _detailsTextEditingController.text,
      placeType: '',
    );
  }

  void addPlaceFromStateToRepository() {
    Place place = createPlaceFromState();
    _placeInteractor.addNewPlace(place);
  }

  void _addUploadImage() async {
    bool? isCreate = await showDialog<bool>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return ImageSourceDialog();
      },
    );

    if (isCreate ?? false) {
      ValueKey<int> key = ValueKey(Random().nextInt(100));

      setState(() {
        _uploadImages.insert(
          1,
          UploadImage(
            key: key,
            deleteUploadImage: _deleteUploadImage,
          ),
        );
      });
    }
  }

  void _deleteUploadImage(ValueKey<int> key) {
    setState(() {
      _uploadImages.removeWhere((UploadImage uploadImage) => uploadImage.key == key);
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
              focusNode: _titleFocusNode,
              controller: _titleTextEditingController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: requiredValidator,
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) {
                _latFocusNode.requestFocus();
              },
              decoration: InputDecoration(
                suffixIcon: _titleTextEditingController.text.isNotEmpty
                    ? IconButton(
                        padding: EdgeInsets.zero,
                        iconSize: 20.0,
                        icon: SvgPicture.asset(
                          iconClear,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: () {
                          _titleTextEditingController.text = '';
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
                        focusNode: _latFocusNode,
                        controller: _latTextEditingController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: requiredValidator,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]')),
                        ],
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          _lonFocusNode.requestFocus();
                        },
                        decoration: InputDecoration(
                          suffixIcon: _latTextEditingController.text.isNotEmpty
                              ? IconButton(
                                  padding: EdgeInsets.zero,
                                  iconSize: 20.0,
                                  icon: SvgPicture.asset(
                                    iconClear,
                                    color: Theme.of(context).primaryColor,
                                  ),
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
                        focusNode: _lonFocusNode,
                        controller: _lonTextEditingController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: requiredValidator,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]')),
                        ],
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          _detailsFocusNode.requestFocus();
                        },
                        decoration: InputDecoration(
                          suffixIcon: _lonTextEditingController.text.isNotEmpty
                              ? IconButton(
                                  padding: EdgeInsets.zero,
                                  iconSize: 20.0,
                                  icon: SvgPicture.asset(
                                    iconClear,
                                    color: Theme.of(context).primaryColor,
                                  ),
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
              focusNode: _detailsFocusNode,
              controller: _detailsTextEditingController,
              maxLines: 4,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) {
                _detailsFocusNode.unfocus();
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
            child: ElevatedButton(
              onPressed: isValidPlaceCreateForm ? addPlaceFromStateToRepository : null,
              child: Text('СОЗДАТЬ'),
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
      child: ListView.separated(
        itemCount: _uploadImages.length,
        physics: Platform.isIOS ? BouncingScrollPhysics() : ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return _uploadImages[index];
        },
        separatorBuilder: (BuildContext context, int index) => SizedBox(width: 16.0),
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
              color: Provider.of<AppModel>(context).theme == lightThemeData
                  ? Colors.white
                  : deepDarkColor,
            ),
            child: Material(
              color: Colors.transparent,
              child: Column(
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                    leading: SvgPicture.asset(
                      iconCamera,
                      color: Provider.of<AppModel>(context).theme == lightThemeData
                          ? secondaryTextColor
                          : Colors.white,
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
                      color: Provider.of<AppModel>(context).theme == lightThemeData
                          ? secondaryTextColor
                          : Colors.white,
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
                      color: Provider.of<AppModel>(context).theme == lightThemeData
                          ? secondaryTextColor
                          : Colors.white,
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
                elevatedButtonTheme: Provider.of<AppModel>(context).theme == lightThemeData
                    ? lightCancelElevatedButton
                    : darkCancelElevatedButton,
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
