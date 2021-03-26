import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/res/text_styles.dart';

/// Карточка достопримечательности, отображается на экране поиска
class SightSearchCard extends StatelessWidget {
  final Sight sight;
  final String highlight;

  SightSearchCard({
    required this.sight,
    this.highlight = '',
  });

  List<String> sliceStringBySubstring(String text, String subtext) {
    int index = text.toLowerCase().indexOf(subtext.toLowerCase());
    List<String> resultList = [];
    if (index >= 0 && subtext.length > 0) {
      resultList.add(text.substring(0, index));
      resultList.add(text.substring(index, index + subtext.length));
      resultList.addAll(sliceStringBySubstring(text.substring(index + subtext.length), subtext));
      return resultList;
    }

    return [text];
  }

  Widget renderTitle({
    required String title,
    required String hightlightText,
  }) {
    List<String> textList = sliceStringBySubstring(title, hightlightText);
    return Text.rich(
      TextSpan(
        children: [
          for (var text in textList)
            text.toLowerCase() == hightlightText.toLowerCase()
                ? TextSpan(text: text, style: subtitle1.copyWith(fontWeight: FontWeight.w500))
                : TextSpan(text: text)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: renderTitle(
        title: sight.name,
        hightlightText: highlight,
      ),
      subtitle: Text(sight.type),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: Container(
          width: 56.0,
          height: 56.0,
          child: Image.network(
            sight.url,
            fit: BoxFit.cover,
            loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CupertinoActivityIndicator.partiallyRevealed(
                  progress: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                      : 1,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
