// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:melikaahmadian/app/core/widget/app_back_button.dart';
// import 'package:melikaahmadian/app/core/widget/app_background.dart';
// import 'package:uuid/uuid.dart';
// import 'package:http/http.dart' as http;
// import 'package:geocoding/geocoding.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:get/get.dart';
//
// import '../../../../routes/app_pages.dart';
// import '../controllers/add_details_controller.dart';
// import 'add_details_view.dart';
//
// class PleaseSearch extends StatefulWidget {
//   int? selecteddrop;
//   PleaseSearch({super.key, this.selecteddrop});
//
//   @override
//   State<PleaseSearch> createState() => _PleaseSearchState();
// }
//
// class _PleaseSearchState extends State<PleaseSearch> {
//   final addcontroller = Get.find<AddDetailsController>();
//
//   TextEditingController controller = TextEditingController();
//
//   var uuid = Uuid();
//
//   List<dynamic> _pleasesList = [];
//
//   String _sessontoken = "123456";
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//
//     controller.addListener(() {
//       onChanged();
//     });
//   }
//
//   void onChanged() {
//     // if(_sessontoken == null){
//     //   setState(() {
//     //     _sessontoken = uuid.v4();
//     //   });
//     // }
//
//     getSuggestion(controller.text);
//   }
//
//   void getSuggestion(String input) async {
//     String placesApiKey = "AIzaSyBxtzHCf2JEjUgx8aS6eFNpV_-s9vGNfo0";
//     String baseURL =
//         'https://maps.googleapis.com/maps/api/place/autocomplete/json';
//     String request =
//         '$baseURL?input=$input&key=$placesApiKey&sessiontoken=$_sessontoken';
//
//     var response = await http.get(Uri.parse(request));
//
//     if (response.statusCode == 200) {
//       print("response:" + response.body.toString());
//       setState(() {
//         _pleasesList = jsonDecode(response.body.toString())["predictions"];
//       });
//     } else {
//       print("erorrr:${response.statusCode}");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: AppBackground(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             AppBackButton(),
//             TextFormField(controller: controller),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: _pleasesList.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     title: Text(_pleasesList[index]["description"]),
//                     onTap: () async {
//                       try {
//                         List<Location> locations = await locationFromAddress(
//                           _pleasesList[index]["description"],
//                         );
//                         print(
//                           "${locations.last.latitude} ${locations.last.longitude}",
//                         );
//                         if (widget.selecteddrop == 1) {
//                           addcontroller.dropLatitude.value = locations
//                               .last
//                               .latitude
//                               .toString();
//                           addcontroller.dropLongitude.value = locations
//                               .last
//                               .longitude
//                               .toString();
//                           addcontroller.dropAddress.value =
//                               _pleasesList[index]["description"];
//                           debugPrint(
//                             "drop address ${addcontroller.dropAddress.value}",
//                           );
//                           _pleasesList.clear();
//
//                           Get.to(AddDetailsView());
//                         } else {
//                           addcontroller.picupLatitude.value = locations
//                               .last
//                               .latitude
//                               .toString();
//                           addcontroller.picupLongitude.value = locations
//                               .last
//                               .longitude
//                               .toString();
//                           addcontroller.picupAddress.value =
//                               _pleasesList[index]["description"];
//                           debugPrint(
//                             "pic address ${addcontroller.picupAddress.value}",
//                           );
//                           _pleasesList.clear();
//                           Get.toNamed(Routes.ADD_DETAILS);
//                         }
//                       } catch (e) {
//                         print("Error: $e");
//                         // You can also show a snackbar/toast here
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(content: Text("Failed to get location")),
//                         );
//                       }
//                     },
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:get_cli/common/utils/json_serialize/json_ast/utils/grapheme_splitter.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import 'package:melikaahmadian/app/core/widget/app_back_button.dart';
import 'package:melikaahmadian/app/core/widget/app_background.dart';
import 'package:melikaahmadian/app/core/const/app_colors.dart';
import '../controllers/add_details_controller.dart';

class PleaseSearch extends StatefulWidget {
  final int? selecteddrop;
  const PleaseSearch({super.key, this.selecteddrop});

  @override
  State<PleaseSearch> createState() => _PleaseSearchState();
}

class _PleaseSearchState extends State<PleaseSearch> {
  late AddDetailsController addcontroller;
  late TextEditingController searchController;
  final uuid = Uuid();

  List<dynamic> suggestions = [];
  String sessionToken = "";
  bool isLoading = false;
  String? errorMessage;

 // static const String _placesApiKey = "AIzaSyBxtzHCf2JEjUgx8aS6eFNpV_-s9vGNfo0";
  static const String _placesApiKey = "AIzaSyAgWfx3lfVIs3jVJHTsxsniY9ogTZpCjrA";
  static const String _baseURL =
      'https://maps.googleapis.com/maps/api/place/autocomplete/json';

  @override
  void initState() {
    super.initState();
    addcontroller = Get.find<AddDetailsController>();
    searchController = TextEditingController();
    sessionToken = uuid.v4();

    searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final input = searchController.text.trim();
    if (input.isNotEmpty) {
      _getSuggestions(input);
    } else {
      setState(() {
        suggestions = [];
        errorMessage = null;
      });
    }
  }

  Future<void> _getSuggestions(String input) async {
    if (input.isEmpty) return;

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final String url =
          '$_baseURL?input=$input&key=$_placesApiKey&sessiontoken=$sessionToken';

      final response = await http
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        if (mounted) {
          setState(() {
            suggestions = json["predictions"] ?? [];
            isLoading = false;
            if (suggestions.isEmpty) {
              errorMessage = "No results found";
            }
          });
        }
      } else {
        if (mounted) {
          setState(() {
            errorMessage = "Error: ${response.statusCode}";
            isLoading = false;
          });
        }
      }
    } on TimeoutException {
      if (mounted) {
        setState(() {
          errorMessage = "Request timed out";
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          errorMessage = "Error: $e";
          isLoading = false;
        });
      }
    }
  }

  Future<void> _handleLocationSelection(String description) async {
    try {
      // Show loading indicator
      Get.dialog(
        Dialog(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 12.h),
                Text("Getting location details..."),
              ],
            ),
          ),
        ),
        barrierDismissible: false,
      );

      final locations = await locationFromAddress(description);

      if (locations.isEmpty) {
        Get.back();
        _showErrorSnackbar("Location not found");
        return;
      }

      final location = locations.last;

      if (widget.selecteddrop == 1) {
        addcontroller.dropLatitude.value = location.latitude.toString();
        addcontroller.dropLongitude.value = location.longitude.toString();
        addcontroller.dropAddress.value = description;
      } else {
        addcontroller.picupLatitude.value = location.latitude.toString();
        addcontroller.picupLongitude.value = location.longitude.toString();
        addcontroller.picupAddress.value = description;
      }

      Get.back(); // Close loading dialog
      Get.back(); // Close search screen

      // Reset session token for next search
      sessionToken = uuid.v4();
    } catch (e) {
      Get.back();
      _showErrorSnackbar("Failed to get location: $e");
    }
  }

  void _showErrorSnackbar(String message) {
    Get.snackbar(
      "Error",
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      duration: Duration(seconds: 3),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBackButton(),
              Row(
                children: [
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      widget.selecteddrop == 1
                          ? "Drop-off Address"
                          : "Pickup Address",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),

              // Search TextField
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: "Search location...",
                    prefixIcon: Icon(
                      Icons.location_on_outlined,
                      color: AppColors.secoundaryColor,
                    ),
                    suffixIcon: searchController.text.isNotEmpty
                        ? IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              searchController.clear();
                              setState(() {
                                suggestions = [];
                                errorMessage = null;
                              });
                            },
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.w),
                      borderSide: BorderSide(color: AppColors.secoundaryColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.w),
                      borderSide: BorderSide(color: AppColors.secoundaryColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.w),
                      borderSide: BorderSide(
                        color: AppColors.secoundaryColor,
                        width: 2,
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                  ),
                  onChanged: (_) => setState(() {}),
                ),
              ),
              SizedBox(height: 12.h),

              // Suggestions List
              Expanded(child: _buildSuggestionsList()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSuggestionsList() {
    if (isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 12.h),
            Text("Searching..."),
          ],
        ),
      );
    }

    if (errorMessage != null && suggestions.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 48, color: Colors.grey),
            SizedBox(height: 12.h),
            Text(errorMessage!),
          ],
        ),
      );
    }

    if (suggestions.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_searching, size: 48, color: Colors.grey),
            SizedBox(height: 12.h),
            Text("Type to search for a location"),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: suggestions.length,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];
        final description = suggestion["description"] ?? "";
        final mainText = suggestion["main_text"] ?? "";
        final secondaryText = suggestion["secondary_text"] ?? "";

        return Card(
          margin: EdgeInsets.symmetric(vertical: 6.h),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.w),
            side: BorderSide(color: AppColors.secoundaryColor.withOpacity(0.3)),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 8.h,
            ),
            leading: Icon(
              Icons.location_on,
              color: AppColors.secoundaryColor,
              size: 24,
            ),
            title: Text(
              mainText,
              style: TextStyle(fontWeight: FontWeight.w600),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              secondaryText.isNotEmpty ? secondaryText : description,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12.sp),
            ),
            onTap: () => _handleLocationSelection(description),
          ),
        );
      },
    );
  }
}
