import 'package:food_delivery_demo/data/repositories/location_repo.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../model/address_model.dart';

class LocationController extends GetxController implements GetxService {
  LocationRepo locationRepo;

  LocationController({required this.locationRepo});
  bool _isLoading = false;
  late Position _position;
  late Position _pickPosition;
  Placemark _placemark = Placemark();
  Placemark _pickPlacemark = Placemark();
  List<AddressModel> _addressList = [];
  late List<AddressModel> _allAddressList;
  List<String> _addressTypeList = ["Home", "Office", "Others"];
  int _addressTypeIndex = 0;
  late Map<String, dynamic> _getAddress;

  List<AddressModel> get addressList => _addressList;
  Map get getAddress => _getAddress;
  bool get isLoading => _isLoading;
  bool

  late GoogleMapController _mapController;
  bool _updateAddressData = true;
  void setMapController(GoogleMapController mapController) {
    _mapController = mapController;
  }

  void updatePosition(CameraPosition cameraPosition, bool fromAddress) {
    if(_updateAddressData) {
      _isLoading = true;
      update();
      try {
        if(fromAddress) {
          _position = Position()
        }
      } catch(e) {
        print(e);
      }
    }
  }
}