import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:melikaahmadian/app/core/widget/app_back_button.dart';
import 'package:melikaahmadian/app/core/widget/app_background.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart'as http;
import 'package:geocoding/geocoding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';
import '../controllers/add_details_controller.dart';
import 'add_details_view.dart';
class PleaseSearch extends StatefulWidget {
  int? selecteddrop  ;
   PleaseSearch({super.key,this.selecteddrop});

  @override
  State<PleaseSearch> createState() => _PleaseSearchState();
}

class _PleaseSearchState extends State<PleaseSearch> {

  final addcontroller = Get.put(AddDetailsController());

  TextEditingController controller = TextEditingController();

  var uuid = Uuid();

  List<dynamic> _pleasesList = [];

  String _sessontoken = "123456";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller.addListener((){
     onChanged();
    });

  }
  void onChanged(){
    // if(_sessontoken == null){
    //   setState(() {
    //     _sessontoken = uuid.v4();
    //   });
    // }

   getSuggestion(controller.text);

  }

  void getSuggestion(String input)async{

    String placesApiKey = "AIzaSyBxtzHCf2JEjUgx8aS6eFNpV_-s9vGNfo0";
    String baseURL ='https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request = '$baseURL?input=$input&key=$placesApiKey&sessiontoken=$_sessontoken';

    var response = await http.get(Uri.parse(request));

    if(response.statusCode == 200){
      print("response:"+response.body.toString());
      setState(() {
        _pleasesList = jsonDecode(response.body.toString())["predictions"];
      });
    }else{
      print("erorrr:${response.statusCode}");
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBackButton(),
            TextFormField(
              controller: controller,
            ),
            Expanded(child: ListView.builder(
              itemCount: _pleasesList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_pleasesList[index]["description"]),
                  onTap: ()async{
                    try {
                      List<Location> locations = await locationFromAddress(
                        _pleasesList[index]["description"],
                      );
                      print("${locations.last.latitude} ${locations.last.longitude}");
                      if(widget.selecteddrop == 1){
                        addcontroller.dropLatitude.value = locations.last.latitude.toString();
                        addcontroller.dropLongitude.value = locations.last.longitude.toString();
                        addcontroller.dropAddress.value = _pleasesList[index]["description"];
                        debugPrint("drop address ${addcontroller.dropAddress.value}");
                        _pleasesList.clear();

                        Get.to(AddDetailsView());
                      }else{
                        addcontroller.picupLatitude.value = locations.last.latitude.toString();
                        addcontroller.picupLongitude.value = locations.last.longitude.toString();
                        addcontroller.picupAddress.value = _pleasesList[index]["description"];
                        debugPrint("pic address ${addcontroller.picupAddress.value}");
                        _pleasesList.clear();
                        //Get.toNamed(Routes.ADD_DETAILS, arguments: {'video':  videoPath});
                      }

                    } catch (e) {
                      print("Error: $e");
                      // You can also show a snackbar/toast here
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Failed to get location")),
                      );
                    }

                  },
                );

              },)),

          ],
        ),
      ),
    );
  }
}
