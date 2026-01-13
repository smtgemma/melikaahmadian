import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:melikaahmadian/app/core/const/app_colors.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    var textStyele = TextTheme.of(context);

    return Container(
      decoration: BoxDecoration(color: AppColors.cardColor,borderRadius: BorderRadius.circular(12)),
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("About",style: textStyele.titleLarge,),
          Text("Professional mover with 5+ years of work experience. Specialized in residential and commercial moves. Background verified and fully insured. Committed to  safe, efficient, and stress-free moving services.",style: textStyele.bodyMedium,)

      ],),
    );
  }
}
