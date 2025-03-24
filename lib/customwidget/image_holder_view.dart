import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageHolderView extends StatelessWidget {
  final Widget child;
  final String url;
  final Function(String) onImagePressed;
  const ImageHolderView({Key? key, required this.child, required this.url, required this.onImagePressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(0),
      width: 80,
      height: 80,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1.5)
      ),
      child: url.isEmpty?child:
      InkWell(
        onTap: (){
          onImagePressed(url);
        },
        child: CachedNetworkImage(
          width: double.infinity,
          height: 200,
          imageUrl: url,
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
