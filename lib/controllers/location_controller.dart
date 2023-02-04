import 'dart:convert';

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
  List<String> get addressTypeList => _addressTypeList;
  int _addressTypeIndex = 0;
  int get addressTypeIndex => _addressTypeIndex;
  late Map<String, dynamic> _getAddress;

  List<AddressModel> get addressList => _addressList;
  Map get getAddress => _getAddress;


  Placemark get placemark => _placemark;
  Placemark get pickplacemark => _pickPlacemark;
  bool get isLoading => _isLoading;
  Position get position => _position;
  Position get pickPosition => _pickPosition;
  late GoogleMapController _mapController;
  bool _updateAddressData = true;
  bool _changeAddress = true;

  void setMapController(GoogleMapController mapController) {
    _mapController = mapController;
  }

  void updatePosition(CameraPosition position, bool fromAddress) async {
    if(_updateAddressData) {
      _isLoading = true;
      update();
      try {
        if(fromAddress) {
          _position = Position(
            latitude: position.target.latitude,
            longitude: position.target.longitude,
            heading: 1,
            accuracy: 1,
            altitude: 1,
            speed: 1,
            speedAccuracy: 1,
            timestamp: DateTime.now()
          );
        } else {
          _pickPosition = Position(
              latitude: position.target.latitude,
              longitude: position.target.longitude,
              heading: 1,
              accuracy: 1,
              altitude: 1,
              speed: 1,
              speedAccuracy: 1,
              timestamp: DateTime.now()
          );
        }

        if(_changeAddress) {
          String address = await getAddressFromGeocode(
            LatLng(
              position.target.latitude,
              position.target.longitude
            )
          );
          fromAddress? _placemark = Placemark(name: address):
              _pickPlacemark = Placemark(name: address);
          print(_placemark.name);
        }
      } catch(e) {
        print(e);
      }
    }
  }

  Future<String> getAddressFromGeocode(LatLng latlng) async {
    String _address = "Unknown Location found";
    Response res = await locationRepo.getAddressFromGeocode(latlng);
    print("hi");
    if(res.body["status"]=="OK") {
      _address = res.body["results"][0]["formatted_address"].toString();
      print("printing address" + _address);
    } else {
      print("Error getting address");
    }
    return _address;
  }


  AddressModel getUserAddress() {
    late AddressModel _addressModel;
    /*
    * converting from string to map using Json decode
    * */
    _getAddress = jsonDecode(locationRepo.getUserAddress());

    try {
      _addressModel = AddressModel.fromJson(jsonDecode(locationRepo.getUserAddress()));
    } catch(e) {
      print(e);
    }
    return _addressModel;
  }

  void setAddressTypeIndex(int index) {
    _addressTypeIndex = index;
    update();
  }
}