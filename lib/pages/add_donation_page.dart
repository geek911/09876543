import 'package:flutter/material.dart';
import 'package:food_donor/repositories/donations_repository.dart';
import 'package:form_validator/form_validator.dart';
import 'package:location/location.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';
import 'package:food_donor/commons/widgets.dart';
import 'package:time_range_picker/time_range_picker.dart';
import '../database.dart';

class AddDonationPage extends StatefulWidget {
  const AddDonationPage({Key? key}) : super(key: key);

  @override
  State<AddDonationPage> createState() => _AddDonationPageState();
}

class _AddDonationPageState extends State<AddDonationPage> {
  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _quantity = TextEditingController();
  final TextEditingController _dateFrom = TextEditingController();
  final TextEditingController _dateTo = TextEditingController();
  bool _loading = false;
  final _dateCreated = DateTime.now();
  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime =
      TimeOfDay.fromDateTime(DateTime.now().add(Duration(hours: 1)));

  // Location

  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  LocationData? _userLocation;

  Future<LocationData?> _getUserLocation(Donation donation) async {
    Location location = Location();

    // Check if location service is enable
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    // Check if permission is granted
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    final _locationData = await location.getLocation();
    // setState(() {
    //   _userLocation = _locationData;
    //   donation.latitude = _locationData.latitude;
    //   donation.longtude = _locationData.longitude;
    // });
    return _locationData;
  }

  @override
  void initState() {
    setState(() {
      _dateFrom.text = DateFormat('dd/MM/yyyy')
          .format(DateTime.now().subtract(const Duration(days: 4)));
      _dateTo.text = DateFormat('dd/MM/yyyy')
          .format(DateTime.now().add(const Duration(days: 3)));
    });

    super.initState();
  }

  /// The method for [DateRangePickerSelectionChanged] callback, which will be
  /// called whenever a selection changed on the date picker widget.
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        _dateFrom.text = DateFormat('dd/MM/yyyy').format(args.value.startDate);
        _dateTo.text = DateFormat('dd/MM/yyyy')
            .format(args.value.endDate ?? args.value.startDate);
      } else if (args.value is DateTime) {
        _dateFrom.text = DateFormat('dd/MM/yyyy').format(args.value);
        _dateTo.text = DateFormat('dd/MM/yyyy').format(args.value);
      } else {}
    });
  }

  Future<void> _addDonation(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      // Create person pojo

      String message = '';

      try {
        var donation = Donation();
        var profile = await Database.getProfile();
        donation.title = _title.text;
        donation.description = _description.text;
        donation.quantity = _quantity.text;
        donation.startTime = _startTime.format(context).toString();
        donation.endTime = _endTime.format(context);
        donation.createdOn =
            "${_dateCreated.day}/${_dateCreated.month}/${_dateCreated.year}";
        donation.email = profile.email;
        donation.phoneNumber = profile.phoneNumber;

        setState(() {
          _loading = true;
        });
        var locationData = await _getUserLocation(donation);

        donation.latitude = locationData?.latitude ?? 0;
        donation.longtude = locationData?.longitude ?? 0;
        await Database.addDonation(donation.toJson()).then((value) {
          Navigator.of(context).pop();
        });
      } catch (e) {
        message =
            'Something went wrong, please check your network connectivity';
      } finally {
        setState(() {
          _loading = false;
        });
        if (message.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message)),
          );
        }
      }
    }
  }

  Widget body(BuildContext context) {
    if (_loading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              FormFields.textField("Title", _title,
                  validator: ValidationBuilder()
                      .minLength(2)
                      .maxLength(20)
                      .required("Title cannot be empty")
                      .build()),
              const SizedBox(
                height: 8,
              ),
              FormFields.textField("Description", _description),
              const SizedBox(
                height: 8,
              ),
              FormFields.textField("Quantity", _quantity,
                  validator: ValidationBuilder()
                      .regExp(RegExp("^\\d+\$"), "Cannot be text")
                      .build()),
              const SizedBox(
                height: 8,
              ),
              Text("Created on : ${_dateCreated.toIso8601String()}"),
              const SizedBox(
                height: 8,
              ),
              Text(
                  "Time of availabitlity: ${this._startTime.format(context)} -  ${this._endTime.format(context)}"),

              const SizedBox(
                height: 8,
              ),
              SizedBox(
                height: 50,
                child: OutlinedButton.icon(
                  label: const Text(
                    "Adjust Time",
                    style: TextStyle(fontSize: 20),
                  ),
                  icon: const Icon(Icons.watch),
                  onPressed: () async {
                    TimeRange result = await showTimeRangePicker(
                        context: context, start: _startTime, end: _endTime);
                    setState(() {
                      _startTime = result.startTime;
                      _endTime = result.endTime;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              // SfDateRangePicker(
              //   onSelectionChanged: _onSelectionChanged,
              //   selectionMode: DateRangePickerSelectionMode.range,
              //   initialSelectedRange: PickerDateRange(
              //       DateTime.now().subtract(const Duration(days: 4)),
              //       DateTime.now().add(const Duration(days: 3))),
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 50,
                    child: OutlinedButton.icon(
                      label: const Text(
                        "Add",
                        style: TextStyle(fontSize: 20),
                      ),
                      icon: const Icon(Icons.add),
                      onPressed: () => _addDonation(context),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: OutlinedButton.icon(
                      label: const Text(
                        "Cancel",
                        style: TextStyle(fontSize: 20),
                      ),
                      icon: const Icon(Icons.cancel),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Add Donation'),
            centerTitle: true,
          ),
          body: body(context)),
    );
  }
}
