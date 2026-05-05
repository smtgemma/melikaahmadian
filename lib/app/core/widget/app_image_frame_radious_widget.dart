import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'shimmer_loader.dart';

class AppImageFrameRadiousWidget extends StatelessWidget {
  final String? imageLink;
  final double? radious;
  
  const AppImageFrameRadiousWidget({super.key, this.imageLink, this.radious});

  @override
  Widget build(BuildContext context) {
    double r = radious ?? 50;
    double size = r * 2;
    
    bool hasImage = imageLink != null && imageLink!.isNotEmpty;
    
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[200],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size),
        child: hasImage 
          ? CachedNetworkImage(
              imageUrl: imageLink!,
              fit: BoxFit.cover,
              placeholder: (context, url) => ShimmerWidget.circular(height: size, width: size),
              errorWidget: (context, url, error) => Center(
                child: Icon(Icons.person, color: Colors.grey, size: size * 0.6),
              ),
            )
          : Center(
              child: Icon(Icons.person, color: Colors.grey, size: size * 0.6),
            ),
      ),
    );
  }
}
