import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/location_controller.dart';
import '../../controllers/user_controller.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({Key? key}) : super(key: key);

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  final TextEditingController _address = TextEditingController();
  final TextEditingController _contactPersonName = TextEditingController();
  final TextEditingController _contactPhoneNumber = TextEditingController();
  late bool _isLoggedIn;
  CameraPosition _cameraPosition = const CameraPosition(target: LatLng(
      45.51563, -122.677433
  ), zoom: 17);
  late LatLng _initialPosition = const LatLng(
      45.51563, -122.677433
  );

  @override
  void initState() {
    super.initState();
    _isLoggedIn = Get.find<AuthController>().isLoggedIn();
    if(_isLoggedIn&&Get.find<UserController>().userModel==null) {
      Get.find<UserController>().getUserInfo();
    }
    if(Get.find<LocationController>().addressList.isNotEmpty) {
      _cameraPosition = CameraPosition(target: LatLng(
        double.parse(Get.find<LocationController>().getAddress["latitude"]),
        double.parse(Get.find<LocationController>().getAddress["longitude"])
      ));
      _initialPosition = LatLng(
          double.parse(Get.find<LocationController>().getAddress["latitude"]),
          double.parse(Get.find<LocationController>().getAddress["longitude"])
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Address Page"),
        backgroundColor: AppColors.mainColor,
      ),
      body: GetBuilder<LocationController>(builder: (locationController){
        _address.text = '${locationController.placemark.name??''}'
        '${locationController.placemark.postalCode}'
        '${locationController.placemark.locality}'
        '${locationController.placemark.country}';
        print("address in my view is " + _address.text);
        return Column(
          children: [
            Container(
              height: 140,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(left: Dimensions.width10-5, right: Dimensions.width10-5, top: Dimensions.height10-5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                      width: 2, color: Theme.of(context).primaryColor
                  )
              ),
              child: Stack(
                children: [
                  GoogleMap(initialCameraPosition:
                  CameraPosition(
                      target: _initialPosition,
                      zoom: 20
                  ),
                    zoomControlsEnabled: false,
                    mapToolbarEnabled: false,
                    indoorViewEnabled: true,
                    compassEnabled: false,
                    onCameraIdle: () {
                      locationController.updatePosition(_cameraPosition, true);
                    },
                    onCameraMove: ((position)=>_cameraPosition=position),
                    onMapCreated: (GoogleMapController controller) {
                      locationController.setMapController(controller);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: Dimensions.height20),
            BigText(text: "Delivery Address"),
            SizedBox(height: Dimensions.height20),

          ],
        );
      }),
    );
  }
}
