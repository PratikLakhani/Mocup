import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:plug2go/utils/app_colors.dart';
import 'package:plug2go/utils/app_common_functions.dart';
import 'package:plug2go/widgets/app_appbar.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({required this.myLocationAddress, required this.locTextContoller, super.key});
  final String myLocationAddress;
  final TextEditingController locTextContoller;

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  GoogleMapController? _controller;
  String address = '';
  List<geo.Placemark> placeMarks = [];
  String textFiledAddress = '';
  TextEditingController textEditingController = TextEditingController();

  final Set<Marker> _markers = {};

  Future<void> getLocation() async {
    try {
      final location = await Geolocator.getCurrentPosition();
      if (mounted) {
        await _controller?.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(location.latitude, location.longitude),
              zoom: 12,
            ),
          ),
        );
        try {
          placeMarks = [];
          placeMarks = await geo.placemarkFromCoordinates(location.latitude, location.longitude);
          final place = placeMarks[0];
          textEditingController.text =
              '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
        } on Exception {}
        setState(() {
          _markers
            ..clear()
            ..add(
              Marker(
                markerId: const MarkerId('Home'),
                position: LatLng(location.latitude, location.longitude),
                infoWindow: InfoWindow(title: address),
              ),
            );
          Timer(const Duration(milliseconds: 300), () async {
            await _controller!.showMarkerInfoWindow(_markers.elementAt(0).markerId);
          });
        });
      }
    } on Exception {}
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      textEditingController.text = widget.myLocationAddress;
      final data = await AppCommonFunctions.getLatLongFromAddress(address: widget.myLocationAddress);
      if (mounted) {
        await _controller?.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(data?.latitude ?? 0.0, data?.longitude ?? 0.0),
              zoom: 12,
            ),
          ),
        );
        try {
          placeMarks = [];
          placeMarks = await geo.placemarkFromCoordinates(data?.latitude ?? 0.0, data?.longitude ?? 0.0);
          final place = placeMarks[0];
          textEditingController.text =
              '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
        } on Exception {}
        setState(() {
          _markers
            ..clear()
            ..add(
              Marker(
                markerId: const MarkerId('Home'),
                position: LatLng(data?.latitude ?? 0.0, data?.longitude ?? 0.0),
                infoWindow: InfoWindow(title: address),
              ),
            );
          Timer(const Duration(milliseconds: 300), () async {
            await _controller!.showMarkerInfoWindow(_markers.elementAt(0).markerId);
          });
        });
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const AppAppbar(title: 'Search location'),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Expanded(
                child: Stack(
                  children: <Widget>[
                    SizedBox(
                      child: GoogleMap(
                        zoomControlsEnabled: false,
                        onMapCreated: (GoogleMapController controller) async {
                          _controller = controller;
                        },
                        markers: _markers,
                        initialCameraPosition: const CameraPosition(target: LatLng(19.018255973653343, 72.84793849278007)),
                      ),
                    ),
                    // Container(
                    //   // padding: EdgeInsets.only(
                    //   //   left: AppSize.w20,
                    //   //   right: AppSize.w20,
                    //   //   bottom: AppSize.h20,
                    //   // ),
                    //   margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
                    //   child: AppTextFormField(
                    //     readOnly: true,
                    //     controller: textEditingController,
                    //     hintText: 'Search location...',
                    //     suffixIcon: Row(
                    //       mainAxisSize: MainAxisSize.min,
                    //       children: <Widget>[
                    //         Assets.icons.icLocationPin.svg(
                    //           height: 22.h,
                    //           width: 22.w,
                    //         ),
                    //       ],
                    //     ),
                    //     // onSubmit: (p0) {
                    //     //   FocusScope.of(context).requestFocus(FocusNode());
                    //     // },
                    //     onTap: () async {
                    //       final result = await showSearch(
                    //         context: context,
                    //         delegate: AddressSearch(),
                    //       );

                    //       if (result!.placeId.isNotEmpty) {
                    //         final url =
                    //             'https://maps.googleapis.com/maps/api/place/details/json?place_id=${result.placeId}&key=AIzaSyBNp2xYml049Vx0R4QjcRm9Q5_mjPjgaeo';
                    //         final response = await http.get(Uri.parse(url));
                    //         final jsonData = json.decode(response.body);
                    //         final jsonResult = jsonData['result']['geometry']['location'] as Map<String, dynamic>;
                    //         await _controller?.animateCamera(
                    //           CameraUpdate.newCameraPosition(
                    //             CameraPosition(
                    //               target: LatLng(
                    //                 double.parse(jsonResult.values.elementAt(0).toString()),
                    //                 double.parse(jsonResult.values.elementAt(1).toString()),
                    //               ),
                    //               zoom: 12,
                    //             ),
                    //           ),
                    //         );
                    //         setState(() {
                    //           _markers
                    //             ..clear()
                    //             ..add(
                    //               Marker(
                    //                 markerId: const MarkerId('Home'),
                    //                 position: LatLng(
                    //                   double.parse(jsonResult.values.elementAt(0).toString()),
                    //                   double.parse(jsonResult.values.elementAt(1).toString()),
                    //                 ),
                    //                 infoWindow: InfoWindow(title: result.description),
                    //               ),
                    //             );
                    //           textEditingController.text = result.description;
                    //         });
                    //       }
                    //     },
                    //   ),
                    // ),
                    // Positioned(
                    //   bottom: 62.h,
                    //   right: 6.w,
                    //   child: GestureDetector(
                    //     onTap: getLocation,
                    //     child: Card(
                    //       elevation: 15.sp,
                    //       child: Container(
                    //         decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(5.r)),
                    //         height: 42.h,
                    //         child: Padding(
                    //           padding: EdgeInsets.symmetric(horizontal: 10.w),
                    //           child: const Center(
                    //             child: Icon(
                    //               Icons.location_on_outlined,
                    //               size: 30,
                    //               color: AppColors.black,
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // Positioned(
                    //   bottom: 0,
                    //   child: GestureDetector(
                    //     onTap: () async {
                    //       Navigator.pop(context);

                    //       widget.locTextContoller.text = textEditingController.text;
                    //     },
                    //     child: Container(
                    //       height: 50.h,
                    //       padding: EdgeInsets.only(
                    //         left: AppSize.w20,
                    //         right: AppSize.w20,
                    //         bottom: AppSize.h20,
                    //       ),
                    //       width: MediaQuery.of(context).size.width,
                    //       color: AppColors.primaryColor,
                    //       child: Padding(
                    //         padding: EdgeInsets.symmetric(horizontal: 10.w),
                    //         child: Center(
                    //           child: Text(
                    //             'Select location',
                    //             style: TextStyle(color: Colors.white, fontSize: 17.sp),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddressSearch extends SearchDelegate<Suggestion> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(
          Icons.clear,
        ),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final theme = Theme.of(context);
    return theme.copyWith(
      brightness: Brightness.light,
      textTheme: theme.textTheme.copyWith(
        titleLarge: theme.textTheme.titleSmall?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
        titleMedium: theme.textTheme.titleSmall?.copyWith(color: Colors.black),
      ),
      inputDecorationTheme: theme.inputDecorationTheme.copyWith(
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        hintStyle: theme.textTheme.titleSmall?.copyWith(color: Colors.grey),
        labelStyle: theme.textTheme.titleSmall?.copyWith(color: Colors.black),
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Colors.grey, width: 0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Colors.grey, width: 0),
        ),
      ),
      appBarTheme: theme.appBarTheme.copyWith(
        backgroundColor: AppColors.white,
        titleSpacing: 0,
      ),
    );
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.arrow_back,
      ),
      onPressed: () {
        close(context, Suggestion('', ''));
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: query == ''
          ? null
          : PlaceApiProvider().fetchSuggestions(
              input: query,
              lang: Localizations.localeOf(context).languageCode,
            ),
      builder: (context, AsyncSnapshot<List<Suggestion>> snapshot) {
        return query == ''
            ? Container(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                color: Colors.white,
                padding: const EdgeInsets.all(16),
                child: const Text('Enter your address'),
              )
            : snapshot.hasData
                ? ColoredBox(
                    color: Colors.white,
                    child: ListView.builder(
                      itemBuilder: (context, index) => ListTile(
                        title: Text(snapshot.data![index].description),
                        onTap: () {
                          close(context, snapshot.data![index]);
                        },
                      ),
                      itemCount: snapshot.data!.length,
                    ),
                  )
                : Container(
                    height: MediaQuery.of(context).size.height,
                    width: double.infinity,
                    color: Colors.white,
                    child: const Text('Loading...'),
                  );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: const Text('Your address not found'),
    );
  }
}

class Suggestion {
  Suggestion(this.placeId, this.description);
  final String placeId;
  final String description;

  @override
  String toString() {
    return 'Suggestion(description: $description, placeId: $placeId)';
  }
}

class PlaceApiProvider {
  final client = Client();
  final String apiKey = 'AIzaSyBNp2xYml049Vx0R4QjcRm9Q5_mjPjgaeo';

  Future<List<Suggestion>> fetchSuggestions({
    required String input,
    required String lang,
  }) async {
    final request = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&language=$lang&key=$apiKey';
    // 'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&types=geocode&language=$lang&key=$apiKey';
    log(request);
    final response = await client.get(Uri.parse(request));

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        return (result['predictions'] as List)
            .map<Suggestion>((p) => Suggestion(p['place_id'].toString(), p['description'].toString()))
            .toList();
      }
      if (result['status'] == 'ZERO_RESULTS') {
        return [];
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }
}

// import 'dart:async';
// import 'dart:convert';
// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:geocoding/geocoding.dart' as geo;
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:http/http.dart' as http;
// import 'package:http/http.dart';
// import 'package:plug2go/gen/assets.gen.dart';
// import 'package:plug2go/utils/app_colors.dart';
// import 'package:plug2go/utils/app_common_functions.dart';
// import 'package:plug2go/utils/app_size.dart';
// import 'package:plug2go/widgets/app_textfield.dart';

// class GoogleMapScreen extends StatefulWidget {
//   const GoogleMapScreen({required this.myLocationAddress, required this.locTextContoller, super.key});
//   final String myLocationAddress;
//   final TextEditingController locTextContoller;

//   @override
//   State<GoogleMapScreen> createState() => _GoogleMapScreenState();
// }

// class _GoogleMapScreenState extends State<GoogleMapScreen> {
//   GoogleMapController? _controller;
//   String address = '';
//   List<geo.Placemark> placeMarks = [];
//   String textFiledAddress = '';
//   TextEditingController textEditingController = TextEditingController();

//   final Set<Marker> _markers = {};

//   Future<void> getLocation() async {
//     try {
//       final location = await Geolocator.getCurrentPosition();
//       if (mounted) {
//         await _controller?.animateCamera(
//           CameraUpdate.newCameraPosition(
//             CameraPosition(
//               target: LatLng(location.latitude, location.longitude),
//               zoom: 12,
//             ),
//           ),
//         );
//         try {
//           placeMarks = [];
//           placeMarks = await geo.placemarkFromCoordinates(location.latitude, location.longitude);
//           final place = placeMarks[0];
//           textEditingController.text =
//               '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
//         } on Exception {}
//         setState(() {
//           _markers
//             ..clear()
//             ..add(
//               Marker(
//                 markerId: const MarkerId('Home'),
//                 position: LatLng(location.latitude, location.longitude),
//                 infoWindow: InfoWindow(title: address),
//               ),
//             );
//           Timer(const Duration(milliseconds: 300), () async {
//             await _controller!.showMarkerInfoWindow(_markers.elementAt(0).markerId);
//           });
//         });
//       }
//     } on Exception {}
//   }

//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
//       textEditingController.text = widget.myLocationAddress;
//       final data = await AppCommonFunctions.getLatLongFromAddress(address: widget.myLocationAddress);
//       if (mounted) {
//         await _controller?.animateCamera(
//           CameraUpdate.newCameraPosition(
//             CameraPosition(
//               target: LatLng(data?.latitude ?? 0.0, data?.longitude ?? 0.0),
//               zoom: 12,
//             ),
//           ),
//         );
//         try {
//           placeMarks = [];
//           placeMarks = await geo.placemarkFromCoordinates(data?.latitude ?? 0.0, data?.longitude ?? 0.0);
//           final place = placeMarks[0];
//           textEditingController.text =
//               '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
//         } on Exception {}
//         setState(() {
//           _markers
//             ..clear()
//             ..add(
//               Marker(
//                 markerId: const MarkerId('Home'),
//                 position: LatLng(data?.latitude ?? 0.0, data?.longitude ?? 0.0),
//                 infoWindow: InfoWindow(title: address),
//               ),
//             );
//           Timer(const Duration(milliseconds: 300), () async {
//             await _controller!.showMarkerInfoWindow(_markers.elementAt(0).markerId);
//           });
//         });
//       }
//     });

//     super.initState();
//   }

//   @override
//   void dispose() {
//     _controller!.dispose();
//     textEditingController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         FocusScope.of(context).requestFocus(FocusNode());
//       },
//       child: Scaffold(
//         resizeToAvoidBottomInset: false,
//         body: SizedBox(
//           height: MediaQuery.of(context).size.height,
//           child: Column(
//             children: <Widget>[
//               Padding(
//                 padding: EdgeInsets.symmetric(vertical: 20.h),
//                 child: Stack(
//                   children: <Widget>[
//                     Align(
//                       child: SizedBox(
//                         width: 200.w,
//                         child: Center(
//                           child: Text(
//                             'Search location',
//                             maxLines: 2,
//                             style: Theme.of(context).textTheme.titleMedium!.copyWith(overflow: TextOverflow.ellipsis),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Positioned(
//                       left: 20.w,
//                       child: GestureDetector(
//                         onTap: () {
//                           Navigator.pop(context);
//                         },
//                         child: const Icon(
//                           Icons.arrow_back_sharp,
//                           color: AppColors.black,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               // CommonWidgets.commonAppBar(
//               //     context: context, title: AppLocalizations.of(context)!.searchLocation, isBackButton: true),
//               Expanded(
//                 child: Stack(
//                   children: <Widget>[
//                     SizedBox(
//                       child: GoogleMap(
//                         zoomControlsEnabled: false,
//                         onMapCreated: (GoogleMapController controller) async {
//                           _controller = controller;
//                         },
//                         markers: _markers,
//                         initialCameraPosition: const CameraPosition(target: LatLng(19.018255973653343, 72.84793849278007)),
//                       ),
//                     ),
//                     Container(
//                       // padding: EdgeInsets.only(
//                       //   left: AppSize.w20,
//                       //   right: AppSize.w20,
//                       //   bottom: AppSize.h20,
//                       // ),
//                       margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
//                       child: AppTextFormField(
//                         readOnly: true,
//                         controller: textEditingController,
//                         hintText: 'Search location...',
//                         suffixIcon: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: <Widget>[
//                             Assets.icons.icLocationPin.svg(
//                               height: 22.h,
//                               width: 22.w,
//                             ),
//                           ],
//                         ),
//                         // onSubmit: (p0) {
//                         //   FocusScope.of(context).requestFocus(FocusNode());
//                         // },
//                         onTap: () async {
//                           final result = await showSearch(
//                             context: context,
//                             delegate: AddressSearch(),
//                           );

//                           if (result!.placeId.isNotEmpty) {
//                             final url =
//                                 'https://maps.googleapis.com/maps/api/place/details/json?place_id=${result.placeId}&key=AIzaSyBNp2xYml049Vx0R4QjcRm9Q5_mjPjgaeo';
//                             final response = await http.get(Uri.parse(url));
//                             final jsonData = json.decode(response.body);
//                             final jsonResult = jsonData['result']['geometry']['location'] as Map<String, dynamic>;
//                             await _controller?.animateCamera(
//                               CameraUpdate.newCameraPosition(
//                                 CameraPosition(
//                                   target: LatLng(
//                                     double.parse(jsonResult.values.elementAt(0).toString()),
//                                     double.parse(jsonResult.values.elementAt(1).toString()),
//                                   ),
//                                   zoom: 12,
//                                 ),
//                               ),
//                             );
//                             setState(() {
//                               _markers
//                                 ..clear()
//                                 ..add(
//                                   Marker(
//                                     markerId: const MarkerId('Home'),
//                                     position: LatLng(
//                                       double.parse(jsonResult.values.elementAt(0).toString()),
//                                       double.parse(jsonResult.values.elementAt(1).toString()),
//                                     ),
//                                     infoWindow: InfoWindow(title: result.description),
//                                   ),
//                                 );
//                               textEditingController.text = result.description;
//                             });
//                           }
//                         },
//                       ),
//                     ),
//                     Positioned(
//                       bottom: 62.h,
//                       right: 6.w,
//                       child: GestureDetector(
//                         onTap: getLocation,
//                         child: Card(
//                           elevation: 15.sp,
//                           child: Container(
//                             decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(5.r)),
//                             height: 42.h,
//                             child: Padding(
//                               padding: EdgeInsets.symmetric(horizontal: 10.w),
//                               child: const Center(
//                                 child: Icon(
//                                   Icons.location_on_outlined,
//                                   size: 30,
//                                   color: AppColors.black,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Positioned(
//                       bottom: 0,
//                       child: GestureDetector(
//                         onTap: () async {
//                           Navigator.pop(context);

//                           widget.locTextContoller.text = textEditingController.text;
//                         },
//                         child: Container(
//                           height: 50.h,
//                           padding: EdgeInsets.only(
//                             left: AppSize.w20,
//                             right: AppSize.w20,
//                             bottom: AppSize.h20,
//                           ),
//                           width: MediaQuery.of(context).size.width,
//                           color: AppColors.primaryColor,
//                           child: Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 10.w),
//                             child: Center(
//                               child: Text(
//                                 'Select location',
//                                 style: TextStyle(color: Colors.white, fontSize: 17.sp),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class AddressSearch extends SearchDelegate<Suggestion> {
//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: const Icon(
//           Icons.clear,
//         ),
//         onPressed: () {
//           query = '';
//         },
//       ),
//     ];
//   }

//   @override
//   ThemeData appBarTheme(BuildContext context) {
//     final theme = Theme.of(context);
//     return theme.copyWith(
//       brightness: Brightness.light,
//       textTheme: theme.textTheme.copyWith(
//         titleLarge: theme.textTheme.titleSmall?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
//         titleMedium: theme.textTheme.titleSmall?.copyWith(color: Colors.black),
//       ),
//       inputDecorationTheme: theme.inputDecorationTheme.copyWith(
//         contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
//         hintStyle: theme.textTheme.titleSmall?.copyWith(color: Colors.grey),
//         labelStyle: theme.textTheme.titleSmall?.copyWith(color: Colors.black),
//         isDense: true,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(5),
//           borderSide: const BorderSide(color: Colors.grey, width: 0),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(5),
//           borderSide: const BorderSide(color: Colors.grey, width: 0),
//         ),
//       ),
//       appBarTheme: theme.appBarTheme.copyWith(
//         backgroundColor: AppColors.white,
//         titleSpacing: 0,
//       ),
//     );
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       icon: const Icon(
//         Icons.arrow_back,
//       ),
//       onPressed: () {
//         close(context, Suggestion('', ''));
//       },
//     );
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     return FutureBuilder(
//       future: query == ''
//           ? null
//           : PlaceApiProvider().fetchSuggestions(
//               input: query,
//               lang: Localizations.localeOf(context).languageCode,
//             ),
//       builder: (context, AsyncSnapshot<List<Suggestion>> snapshot) {
//         return query == ''
//             ? Container(
//                 height: MediaQuery.of(context).size.height,
//                 width: double.infinity,
//                 color: Colors.white,
//                 padding: const EdgeInsets.all(16),
//                 child: const Text('Enter your address'),
//               )
//             : snapshot.hasData
//                 ? ColoredBox(
//                     color: Colors.white,
//                     child: ListView.builder(
//                       itemBuilder: (context, index) => ListTile(
//                         title: Text(snapshot.data![index].description),
//                         onTap: () {
//                           close(context, snapshot.data![index]);
//                         },
//                       ),
//                       itemCount: snapshot.data!.length,
//                     ),
//                   )
//                 : Container(
//                     height: MediaQuery.of(context).size.height,
//                     width: double.infinity,
//                     color: Colors.white,
//                     child: const Text('Loading...'),
//                   );
//       },
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).size.height,
//       width: double.infinity,
//       color: Colors.white,
//       padding: const EdgeInsets.all(16),
//       child: const Text('Your address not found'),
//     );
//   }
// }

// class Suggestion {
//   Suggestion(this.placeId, this.description);
//   final String placeId;
//   final String description;

//   @override
//   String toString() {
//     return 'Suggestion(description: $description, placeId: $placeId)';
//   }
// }

// class PlaceApiProvider {
//   final client = Client();
//   final String apiKey = 'AIzaSyBNp2xYml049Vx0R4QjcRm9Q5_mjPjgaeo';

//   Future<List<Suggestion>> fetchSuggestions({
//     required String input,
//     required String lang,
//   }) async {
//     final request = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&language=$lang&key=$apiKey';
//     // 'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&types=geocode&language=$lang&key=$apiKey';
//     log(request);
//     final response = await client.get(Uri.parse(request));

//     if (response.statusCode == 200) {
//       final result = json.decode(response.body);
//       if (result['status'] == 'OK') {
//         return (result['predictions'] as List)
//             .map<Suggestion>((p) => Suggestion(p['place_id'].toString(), p['description'].toString()))
//             .toList();
//       }
//       if (result['status'] == 'ZERO_RESULTS') {
//         return [];
//       }
//       throw Exception(result['error_message']);
//     } else {
//       throw Exception('Failed to fetch suggestion');
//     }
//   }
// }