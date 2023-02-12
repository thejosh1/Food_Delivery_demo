import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/location_controller.dart';
import '../../controllers/user_controller.dart';
import '../../model/address_model.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_icons.dart';
import '../../widgets/app_text_field.dart';
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
      Get.find<LocationController>().getUserAddress();
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
      body: GetBuilder<UserController>(builder: (_userController) {
        if(_userController.userModel!=null && _contactPersonName.text.isEmpty) {
          _contactPersonName.text = '${_userController.userModel?.name}';
          _contactPhoneNumber.text = '${_userController.userModel?.phone}';

          if(Get.find<LocationController>().addressList.isNotEmpty) {
            _address.text = Get.find<LocationController>().getUserAddress().address;
            }
          }
        return GetBuilder<LocationController>(builder: (locationController){
          _address.text = '${locationController.placemark.name??''}'
              '${locationController.placemark.postalCode}'
              '${locationController.placemark.locality}'
              '${locationController.placemark.country}';
          print("address in my view is " + _address.text);
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 140,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(left: Dimensions.width10-5, right: Dimensions.width10-5, top: Dimensions.height10-5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                          width: 2, color: AppColors.mainColor
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
                        myLocationEnabled: true,
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
                Padding(
                  padding: EdgeInsets.only(left: Dimensions.width20, top: Dimensions.height20),
                  child: SizedBox(height: Dimensions.height45+5, child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: locationController.addressTypeList.length,
                      itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        locationController.setAddressTypeIndex(index);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.width20, vertical: Dimensions.height10),
                        margin: EdgeInsets.only(right: Dimensions.width10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.height20/4),
                          color: Theme.of(context).cardColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[200]!,
                              spreadRadius: 1,
                              blurRadius: 5
                            ),
                          ]
                        ),
                        child: Icon(
                            index==0?Icons.home_filled:index==1?Icons.work:Icons.location_on,
                            color: locationController.addressTypeIndex==index?AppColors.mainColor:Theme.of(context).disabledColor
                        )
                      ),
                    );
                  }),),
                ),
                SizedBox(height: Dimensions.height20),
                Padding(
                  padding: EdgeInsets.only(left: Dimensions.width20),
                  child: BigText(text: "Delivery Address"),
                ),
                SizedBox(height: Dimensions.height10),
                AppTextField(textEditingController:  _address, hintText: 'Your Delivery Address', iconData: Icons.map, color: AppColors.yellowColor, ),
                SizedBox(height: Dimensions.height20),
                Padding(
                  padding: EdgeInsets.only(left: Dimensions.width20),
                  child: BigText(text: "Contact Name"),
                ),
                SizedBox(height: Dimensions.height10),
                AppTextField(textEditingController:  _contactPersonName, hintText: 'Your Name', iconData: Icons.person, color: AppColors.yellowColor, ),
                SizedBox(height: Dimensions.height20),
                Padding(
                  padding: EdgeInsets.only(left: Dimensions.width20),
                  child: BigText(text: "Contact Phonenumber"),
                ),
                SizedBox(height: Dimensions.height10),
                AppTextField(textEditingController:  _contactPhoneNumber, hintText: 'Your Phone Number', iconData: Icons.phone, color: AppColors.yellowColor, )
              ],
            ),
          );
        });
      }),
      bottomNavigationBar: GetBuilder<LocationController>(builder:(locationController){
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: Dimensions.height20*6,
                padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.radius20*2), topRight: Radius.circular(Dimensions.radius20*2)),
                    color: AppColors.buttonBackgroundColor
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // controller.addItem(product);
                        AddressModel _addressModel = AddressModel(addressType: locationController.addressTypeList[locationController.addressTypeIndex],
                          contactPersonName: _contactPersonName.text,
                          contactPhoneNumber: _contactPhoneNumber.text,
                          address: _address.text,
                          latitude: locationController.position.latitude.toString(),
                          longitude: locationController.position.longitude.toString()
                        );
                        locationController.addAddress(_addressModel).then((response) {
                          if(response.isSuccess) {
                            Get.back();
                            Get.snackbar("Address", "Address added successfully");
                          } else {
                            Get.snackbar("Address", "Couldn't save address");
                          }
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
                        decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                        ),
                        child: BigText(text: "Save Address", color: Colors.white,),
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        })
    );
  }
}
