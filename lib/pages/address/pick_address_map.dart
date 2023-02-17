import 'package:flutter/material.dart';
import 'package:food_delivery_demo/controllers/location_controller.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../base/custom_button.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';

class PickAddressMap extends StatefulWidget {
  final fromSignUp;
  final fromAddress;
  final GoogleMapController? googleMapController;

  const PickAddressMap({Key? key, required this.fromSignUp, required this.fromAddress, this.googleMapController}) : super(key: key);

  @override
  State<PickAddressMap> createState() => _PickAddressMapState();
}

class _PickAddressMapState extends State<PickAddressMap> {
  late LatLng _initialPosition;
  late GoogleMapController _googleMapController;
  late CameraPosition _cameraPosition;

  @override
  void initState() {
    super.initState();
    if(Get.find<LocationController>().addressList.isEmpty) {
      _initialPosition = LatLng(45.521563, -122.677433);
      _cameraPosition = CameraPosition(target: _initialPosition, zoom: 17);
    } else {
      if(Get.find<LocationController>().addressList.isNotEmpty) {
        _initialPosition = LatLng(double.parse(Get.find<LocationController>().getAddress["latitude"]), double.parse(Get.find<LocationController>().getAddress["longitude"]));
      }
    }
}

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(builder: (locationController) {
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: SizedBox(
              width: double.maxFinite,
              child: Stack(
                children: [
                  GoogleMap(initialCameraPosition: CameraPosition(
                      target: _initialPosition, zoom: 17
                  ),
                    zoomControlsEnabled: false,
                    onCameraMove: (CameraPosition cameraPosition) {
                      _cameraPosition = cameraPosition;
                    },
                    onCameraIdle: () {
                      Get.find<LocationController>().updatePosition(_cameraPosition, false);
                    },
                  ),
                  Center(
                    child: !locationController.isLoading?Image.asset("assets/image/pick_marker.png",
                    height: Dimensions.height20+30, width: Dimensions.width30+20
                    ): const CircularProgressIndicator()
                  ),
                  Positioned(
                      top: Dimensions.width45,
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
                        height: Dimensions.height45+5,
                        decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius: BorderRadius.circular(Dimensions.radius20-10)
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on, size: Dimensions.width20+5, color: AppColors.yellowColor,
                            ),
                            Expanded(child: Text('${locationController.pickplacemark.name??''}', style:
                            TextStyle(
                                color: Colors.white,
                                fontSize: Dimensions.font16),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis
                              ,),)
                          ],
                        ),
                      )
                  ),
                  Positioned(
                    bottom: Dimensions.height100*2,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    child: CustomButton(
                      buttonText: 'Pick Address',
                      onPressed: locationController.isLoading?null:() {
                        if(locationController.pickPosition.latitude!=0&&locationController.pickplacemark.name!=null) {
                          if(widget.fromAddress) {
                            if(widget.googleMapController!=null) {
                              print("you clicked on this");
                            }
                          }
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
