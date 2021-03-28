import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/icons.dart';
import 'package:places/ui/res/text_styles.dart';

class AddSightScreen extends StatefulWidget {
  @override
  _AddSightScreenState createState() => _AddSightScreenState();
}

class _AddSightScreenState extends State<AddSightScreen> {
  List<UploadImage> _uploadImages = [];
  TextEditingController _titleTextEditingController = TextEditingController();
  TextEditingController _latTextEditingController = TextEditingController();
  TextEditingController _lonTextEditingController = TextEditingController();
  TextEditingController _detailsTextEditingController = TextEditingController();
  FocusNode _titleFocusNode = FocusNode();
  FocusNode _latFocusNode = FocusNode();
  FocusNode _lonFocusNode = FocusNode();
  FocusNode _detailsFocusNode = FocusNode();
  bool get isValidSightCreateForm {
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

  Sight createSightFromState() {
    return Sight(
      name: _titleTextEditingController.text,
      lat: double.parse(_latTextEditingController.text),
      lon: double.parse(_lonTextEditingController.text),
      url: '',
      details: '',
      type: '',
    );
  }

  void addSightFromStateToStore() {
    Sight sight = createSightFromState();
    SightStorage.sights.add(sight);
    print('Total sights: ${SightStorage.sights.length}, last: ${SightStorage.sights.last}');
  }

  void _addUploadImage() {
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
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SizedBox(
            width: double.infinity,
            height: 48.0,
            child: ElevatedButton(
              onPressed: isValidSightCreateForm ? addSightFromStateToStore : null,
              child: Text('СОЗДАТЬ'),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageRow() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 16.0,
          right: 8.0,
          left: 8.0,
        ),
        child: Row(
          children: [
            for (var uploadImage in _uploadImages) uploadImage,
          ],
        ),
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: isCreator
          ?
          // TODO реализация нулеовго элемента через OutlinedButton
          //
          // Container(
          //     width: 72.0,
          //     height: 72.0,
          //     child: OutlinedButton(
          //       onPressed: () {
          //         if (addUploadImage != null) {
          //           addUploadImage!();
          //         }
          //       },
          //       child: SvgPicture.asset(iconPlus),
          //       style: OutlinedButton.styleFrom(
          //         primary: successColor,
          //         side: BorderSide(
          //           width: 2.0,
          //           color: successColor.withOpacity(0.48),
          //         ),
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(12.0),
          //         ),
          //       ),
          //     ),
          //   )
          GestureDetector(
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
                        color: overlayBgColor,
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
            ),
    );
  }
}
