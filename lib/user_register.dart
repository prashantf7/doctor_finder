import 'dart:io';

// import 'package:doctor_finder/api_key.dart';
import 'package:doctor_finder/app_styles.dart';
import 'package:doctor_finder/common_button.dart';
import 'package:doctor_finder/common_container.dart';
import 'package:doctor_finder/common_text_field.dart';
import 'package:doctor_finder/routes.dart';
import 'package:doctor_finder/size_config.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
// import 'package:google_places_flutter/google_places_flutter.dart';
// import 'package:google_places_flutter/model/prediction.dart';
import 'package:image_picker/image_picker.dart';

class UserRegister extends ConsumerStatefulWidget {
  const UserRegister({super.key});

  @override
  ConsumerState<UserRegister> createState() => _UserRegisterState();
}

class _UserRegisterState extends ConsumerState<UserRegister> {
  final _emailEditingController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _locationController = TextEditingController();

  File? _selectedImage;
  // double? _latitude;
  // double? _longitude;
  void _takePicture() async {
    final imagePicker = ImagePicker();

    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage == null) {
      return;
    }

    setState(() {
      _selectedImage = File(pickedImage.path);
    });
  }

  @override
  void dispose() {
    _emailEditingController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _phoneNumberController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppStyles.mainColor,
        body: Padding(
          padding: EdgeInsets.fromLTRB(
            SizeConfig.getProportionateWidth(10),
            SizeConfig.getProportionateHeight(50),
            SizeConfig.getProportionateWidth(10),
            SizeConfig.getProportionateHeight(10),
          ),
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const Divider(color: Colors.black, thickness: 2),

                  SizedBox(height: SizeConfig.getProportionateHeight(15)),

                  const Text(
                    'Tap to add a profile image',
                    style: TextStyle(
                      color: Colors.black,
                      fontStyle: FontStyle.italic,
                      fontSize: 13,
                    ),
                  ),

                  GestureDetector(
                    onTap: _takePicture,
                    child: CircleAvatar(
                      backgroundImage: _selectedImage != null
                          ? FileImage(_selectedImage!)
                          : const AssetImage('assets/images/placeholder.png')
                                as ImageProvider,
                      radius: SizeConfig.getProportionateHeight(60),
                    ),
                  ),

                  SizedBox(height: SizeConfig.getProportionateHeight(10)),

                  CommonTextField(
                    hintText: 'Enter Name...',
                    textInputType: TextInputType.name,
                    controller: _nameController,
                  ),

                  SizedBox(height: SizeConfig.getProportionateHeight(10)),

                  CommonTextField(
                    hintText: 'Enter Phone Number...',
                    textInputType: TextInputType.phone,
                    controller: _phoneNumberController,
                  ),

                  SizedBox(height: SizeConfig.getProportionateHeight(10)),
                  SizedBox(height: SizeConfig.getProportionateHeight(10)),

                  CommonTextField(
                    hintText: 'Enter Email...',
                    textInputType: TextInputType.emailAddress,
                    controller: _emailEditingController,
                  ),

                  SizedBox(height: SizeConfig.getProportionateHeight(10)),

                  CommonTextField(
                    hintText: 'Enter Password...',
                    textInputType: TextInputType.text,
                    obscureText: true,
                    controller: _passwordController,
                  ),

                  SizedBox(height: SizeConfig.getProportionateHeight(20)),

                  CommonButton(
                    onTap: () {
                      // Register logic here
                    },
                    title: 'Register Me',
                    isLoading: false,
                  ),

                  SizedBox(height: SizeConfig.getProportionateHeight(15)),

                  Text(
                    'OR',
                    style: AppStyles.titleTextStyle.copyWith(
                      color: Colors.black,
                    ),
                  ),

                  SizedBox(height: SizeConfig.getProportionateHeight(15)),

                  CommonContainer(
                    onTap: () {
                      context.goNamed(AppRoutes.signIn.name);
                    },
                    text: 'Sign In to my Account',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//                   GooglePlaceAutoCompleteTextField(
//   textEditingController: _locationController,
//   googleAPIKey: Apikeys.apiKey,
//   debounceTime: 400,
//   isLatLngRequired: true,

//   inputDecoration: InputDecoration(
//     hintText: 'Enter your Location',
//     hintStyle: AppStyles.normalTextStyle.copyWith(
//       color: Colors.black,
//     ),
//     labelStyle: AppStyles.normalTextStyle.copyWith(
//       color: Colors.black,
//     ),
//   ),

//   itemClick: (Prediction prediction) async {
//     _locationController.text = prediction.description ?? "";

//     final detail = await _places.getDetailsByPlaceId(
//       prediction.placeId!,
//     );

//     setState(() {
//       _latitude = detail.result.geometry?.location?.lat;
//       _longitude = detail.result.geometry?.location?.lng;
//     });

//     _locationController.selection = TextSelection.fromPosition(
//       TextPosition(
//         offset: _locationController.text.length,
//       ),
//     );
//   },

//   itemBuilder: (context, index, Prediction prediction) {
//     return Container(
//       padding: const EdgeInsets.all(10),
//       child: Row(
//         children: [
//           const Icon(Icons.location_on),
//           const SizedBox(width: 7),
//           Expanded(
//             child: Text(
//               prediction.description ?? "",
//             ),
//           ),
//         ],
//       ),
//     );
//   },
// )
// ,



// Yes. You do not need google_maps_webservice to store latitude/longitude or to save a place in Firestore.

// The cleanest solution for your current project is:

// Use google_maps_flutter only if you want to display a map.

// Use a Places autocomplete package/API to let the user select a place.

// Get the selected place's place_id.

// Request its latitude/longitude using the Google Places REST API with the normal http package.

// Save location, latitude, and longitude in your AppUser.

// This avoids the old google_maps_webservice package and its http ^0.13 conflict.

// 1. Keep your model
// Use:

// final String location;
// final double latitude;
// final double longitude;

// and Firestore:

// {
//   'location': location,
//   'latitude': latitude,
//   'longitude': longitude,
// }

// 2. Get latitude/longitude from Google Places
// You already have:

// prediction.placeId
// prediction.description

// When the user taps a suggestion, call:

// import 'dart:convert';
// import 'package:http/http.dart' as http;

// Then:

// Future<Map<String, double>?> getPlaceLatLng(String placeId) async {
//   final url = Uri.parse(
//     'https://maps.googleapis.com/maps/api/place/details/json'
//     '?place_id=$placeId'
//     '&fields=geometry'
//     '&key=${AppKeys.apiKey2}',
//   );

//   final response = await http.get(url);

//   if (response.statusCode != 200) {
//     return null;
//   }

//   final data = jsonDecode(response.body);

//   if (data['status'] != 'OK') {
//     return null;
//   }

//   final location = data['result']['geometry']['location'];

//   return {
//     'latitude': (location['lat'] as num).toDouble(),
//     'longitude': (location['lng'] as num).toDouble(),
//   };
// }

// Then your autocomplete selection can be:

// itemClick: (Prediction prediction) async {
//   final selectedLocation = prediction.description ?? '';

//   _locationController.text = selectedLocation;

//   if (prediction.placeId != null) {
//     final coordinates = await getPlaceLatLng(
//       prediction.placeId!,
//     );

//     if (coordinates != null) {
//       setState(() {
//         _latitude = coordinates['latitude']!;
//         _longitude = coordinates['longitude']!;
//       });
//     }
//   }

//   _locationController.selection = TextSelection.fromPosition(
//     TextPosition(
//       offset: _locationController.text.length,
//     ),
//   );
// },

// So you end up with:

// User selects:
// "Jaipur, Rajasthan, India"

//         ↓

// Google Places

//         ↓

// location = "Jaipur, Rajasthan, India"
// latitude = 26.9124
// longitude = 75.7873

//         ↓

// Firestore

// 3. Your AppUser becomes easy to create
// For example:

// final user = AppUser(
//   email: emailController.text.trim(),
//   name: nameController.text.trim(),
//   phoneNumber: phoneController.text.trim(),
//   imageUrl: '',
//   location: _locationController.text.trim(),
//   latitude: _latitude,
//   longitude: _longitude,
//   userId: FirebaseAuth.instance.currentUser!.uid,
//   type: 'doctor',
// );

// Then:

// await FirebaseFirestore.instance
//     .collection('users')
//     .doc(user.userId)
//     .set(user.toMap());

// 4. You don't actually need a Google Map
// This is an important distinction.

// If your requirement is just:

// "Doctor enters/selects their location and I save it."

// Then you don't need google_maps_flutter at all.

// You only need:

// Places Autocomplete
//         ↓
// place_id
//         ↓
// Places Details REST API
//         ↓
// latitude + longitude
//         ↓
// Firestore

// If later you want:

// "Show doctors near me"

// then the stored latitude/longitude becomes very useful.

// If you want:

// "Show a map with doctor markers"

// then add google_maps_flutter separately.

// One warning
// Your Google API key must have the appropriate Places API enabled in Google Cloud, and its API restrictions must permit the API you're calling. Otherwise the code can compile perfectly but Google will return an API error.

// If you show me the exact package you're currently using for GooglePlaceAutoCompleteTextField (the import at the top of that Dart file), I can give you the exact working autocomplete code for that package without google_maps_webservice.


// ChatGPT is AI and can make mistakes.

// No file chosenNo file chosenNo file chosen

// Chat with ChatGPT
