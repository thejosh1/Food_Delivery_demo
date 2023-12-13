import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:food_delivery_demo/data/api/api_checker.dart';
import 'package:food_delivery_demo/data/repositories/location_repo.dart';
import 'package:food_delivery_demo/model/response_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/src/places.dart';

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
  List<AddressModel> get allAddressList => _allAddressList;
  List<String> _addressTypeList = ["Home", "Office", "Others"];
  List<String> get addressTypeList => _addressTypeList;
  int _addressTypeIndex = 0;
  int get addressTypeIndex => _addressTypeIndex;
  late Map<String, dynamic> _getAddress;
  List<AddressModel> get addressList => _addressList;
  Map get getAddress => _getAddress;

  late GoogleMapController _mapController;
  GoogleMapController get mapController => _mapController;


  Placemark get placemark => _placemark;
  Placemark get pickplacemark => _pickPlacemark;
  bool get isLoading => _isLoading;
  Position get position => _position;
  Position get pickPosition => _pickPosition;
  bool _updateAddressData = true;
  bool _changeAddress = true;

  /*
  * this bool variable would be used for the zoned based services functionality*/
  bool _loading = false;
  bool get loading => _loading;
  /*
  * this bool variable checks whether the user address is in a serviced zone or not*/
  bool _inZone = false;
  bool get inZone => _inZone;
  bool _buttonDisabled = true;
  bool get buttonDisabled => _buttonDisabled;

  List<Prediction> _predictionList = [];

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
              timestamp: DateTime.now(),
              altitudeAccuracy: 1,
              headingAccuracy: 1
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
              timestamp: DateTime.now(),
              altitudeAccuracy: 1,
              headingAccuracy: 1
          );
        }
        ResponseModel _responseModel = await getZones(position.target.latitude.toString(), position.target.longitude.toString(), false);
        _buttonDisabled = !_responseModel.isSuccess;
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
      _isLoading = false;
      update();
    } else {
      _updateAddressData=true;
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
      print("Error getting address from google api");
    }
    update();
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

  Future<ResponseModel> addAddress(AddressModel addressModel) async {
    _isLoading = true;
    update();
    Response res = await locationRepo.addUserAddress(addressModel);
    ResponseModel responseModel;
    if(res.statusCode == 200) {
     await getAddressList();
      String message = res.body["Message"];
      responseModel = ResponseModel(true, message);
      saveUserAddress(addressModel);
    } else {
      print("error" + res.statusText!);
      responseModel = ResponseModel(false, res.statusText!);
    }
    update();
    return responseModel;
  }

  Future<void> getAddressList() async {
    Response res = await locationRepo.getAllAddresses();
    if(res.statusCode==200) {
      _addressList = [];
      _allAddressList = [];
      //the address is the value of the key-value pair of the map res.body
      res.body.forEach((address) {
        _addressList.add(AddressModel.fromJson(address));
        _allAddressList.add(AddressModel.fromJson(address));
      });
    } else {
      _addressList = [];
      _allAddressList = [];
    }
    update();
  }

  Future<bool> saveUserAddress(AddressModel addressModel) async {
    String userAddress = jsonEncode(addressModel.toJson());
    return await locationRepo.saveUserAddress(userAddress);
  }

  void clearAddressList() {
    _addressList = [];
    _allAddressList = [];
    update();
  }

  String getUserAddressFromStorage() {
    return locationRepo.getUserAddress();
  }

  void setAddAddressData() {
    _position = _pickPosition;
    _placemark = _pickPlacemark;
    _updateAddressData=false;
    update();
  }

  Future<ResponseModel> getZones(String lat, String lng, bool markerLoad) async {
    late ResponseModel _responseModel;
    if(markerLoad) {
      _loading = true;
    } else {
      _isLoading = true;
    }
    _inZone = true;
    update();
    Response response = await locationRepo.getZone(lat, lng);
    if(response == 200) {
      _inZone = true;
      _responseModel = ResponseModel(true, response.body["zone_id"].toString());
    } else {
      _inZone = false;
      _responseModel = ResponseModel(true, response.statusText.toString());
    }
    update();
    return _responseModel;
  }

  Future<List<Prediction>> searchLocation(BuildContext context, String text) async {
    if(text.isNotEmpty) {
      Response response = await locationRepo.searchLocation(text);
      if(response.statusCode==200&&response.body['status']=='OK') {
        _predictionList = [];
        response.body['prediction'].forEach((prediction)=>_predictionList.add(Prediction.fromJson(prediction)));
      } else {
        ApiChecker.checkApi(response);
      }
    }
    return _predictionList;
  }
}