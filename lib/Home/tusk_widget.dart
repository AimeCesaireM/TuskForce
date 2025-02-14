import 'package:flutter/material.dart';

class TuskWidget extends StatefulWidget {
  final String tuskTitle;
  final String tuskDescription;
  final String tuskPrice;
  final String tuskID;
  final String tuskCategory;
  final String uploaderEmail;
  final String uploaderName;
  final String uploaderID;
  final String tuskImage;
  final String uploaderProfilePhoto;
  final String isService;
  final List<String> tuskTags;
  final bool isListView;

  const TuskWidget({
    super.key,
    required this.tuskTitle,
    required this.tuskDescription,
    required this.tuskPrice,
    required this.tuskID,
    required this.tuskCategory,
    required this.uploaderEmail,
    required this.uploaderName,
    required this.uploaderID,
    required this.tuskImage,
    required this.uploaderProfilePhoto,
    required this.isService,
    required this.tuskTags,
    required this.isListView,
  });

  @override
  State<TuskWidget> createState() => _TuskWidgetState();
}

class _TuskWidgetState extends State<TuskWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.isListView
        ? ListTile(
            leading: Image.network(
              widget.tuskImage,
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return SizedBox(
                  width: 100,
                  height: 400,
                );
              },
              width: 100,
              height: 400,
              fit: BoxFit.cover,
            ),
            title: Text(
              widget.tuskTitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            subtitle:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                widget.uploaderName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text('Price: ${widget.tuskPrice}',
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  )),
              Divider(
                color: Colors.grey,
                thickness: 1,
                indent: 0,
                endIndent: 0,
              )
            ]))
        : Card(
            margin: EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
              side: BorderSide.none,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.network(
                  widget.tuskImage,
                  fit: BoxFit.cover,
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    return SizedBox(
                      width: 70,
                      height: 150,
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Text(
                    widget.tuskTitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Text(
                    'Price: ${widget.tuskPrice}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
