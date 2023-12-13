import 'package:flutter/material.dart';
import 'package:food_delivery_demo/controllers/location_controller.dart';
import 'package:food_delivery_demo/pages/address/components/search_location_dialogue.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../base/custom_button.dart';
import '../../routes/routes_helper.dart';
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
                    onMapCreated: (GoogleMapController mapController) {
                      _googleMapController = mapController;
                      if(!widget.fromAddress) {

                      }
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
                      child: InkWell(
                        onTap: () => Get.dialog(LocationDialogue(mapController: _googleMapController)),
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
                              Expanded(child: Text(locationController.pickplacemark.name??'', style:
                              TextStyle(
                                  color: Colors.white,
                                  fontSize: Dimensions.font16),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis
                                ,),),
                              SizedBox(width: Dimensions.width10,),
                              Icon(Icons.search, size: Dimensions.width20+5, color: AppColors.yellowColor,)
                            ],
                          ),
                        ),
                      )
                  ),
                  Positioned(
                    bottom: Dimensions.height100-20,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    child: locationController.isLoading?const Center(child: CircularProgressIndicator(),):CustomButton(
                      buttonText: locationController.inZone?widget.fromAddress?'Pick Address':'pick location':'Service is not available',
                      onPressed: (locationController.buttonDisabled||locationController.loading)?null:() {
                        if(locationController.pickPosition.latitude!=0&&locationController.pickplacemark.name!=null) {
                          if(widget.fromAddress) {
                            if(widget.googleMapController!=null) {
                              print("you clicked on this");
                              widget.googleMapController!.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(
                                  locationController.pickPosition.latitude, locationController.pickPosition.longitude
                              ))));
                              locationController.setAddAddressData();
                            }
                            //Get.back is not suitable when updating in the call back function
                            Get.toNamed(RouteHelper.ADDADDRESSPAGE);
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
