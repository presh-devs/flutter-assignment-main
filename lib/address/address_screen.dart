import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutterassignment/address/address_model.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  TextEditingController countryController = TextEditingController();
  TextEditingController prefectureController = TextEditingController();
  TextEditingController munController = TextEditingController();
  TextEditingController streetAdrrController = TextEditingController();
  TextEditingController apartmetAdrrController = TextEditingController();
  bool disabled = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var spacing = MediaQuery.sizeOf(context).height * 0.03;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(widget.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                color: const Color(0xFFFFAE0B),
                height: 5,
                width: MediaQuery.sizeOf(context).width * 0.5,
              ),
              Container(
                color: Colors.white,
                height: 5,
                width: MediaQuery.sizeOf(context).width * 0.5,
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Please enter infromation as written \non your ID document',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Form(
                    key: _formKey,
                    child: Expanded(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            cursorColor: Colors.black,
                            controller: countryController,
                            onTap: () => showCountryPicker(
                              context: context,
                              onSelect: (Country country) {
                                setState(() {
                                  countryController.text = country.name;
                                });
                              },
                            ),
                            decoration: const InputDecoration(
                              hintText: 'Country',
                              suffixIcon: Icon(Icons.search),
                            ),
                            validator: ((value) {
                              if (value!.isEmpty) {
                                return 'Select a Country';
                              }
                              return null;
                            }),
                          ),
                          SizedBox(height: spacing),
                          TextFormField(
                            cursorColor: Colors.black,
                            controller: prefectureController,
                            decoration: const InputDecoration(
                              hintText: 'Prefecture',
                            ),
                            validator: ((value) {
                              if (value!.isEmpty) {
                                return 'Enter your prefecture';
                              }
                              return null;
                            }),
                          ),
                          SizedBox(
                            height: spacing,
                          ),
                          TextFormField(
                            cursorColor: Colors.black,
                            controller: munController,
                            decoration: const InputDecoration(
                              hintText: 'Municipality',
                            ),
                            validator: ((value) {
                              if (value!.isEmpty) {
                                return 'Enter your municipality';
                              }
                              return null;
                            }),
                          ),
                          SizedBox(
                            height: spacing,
                          ),
                          TextFormField(
                            cursorColor: Colors.black,
                            controller: streetAdrrController,
                            decoration: const InputDecoration(
                              hintText:
                                  'Street address (subarea - block - house)',
                            ),
                            validator: ((value) {
                              RegExp subareaBlockHouseRegex =
                                  RegExp(r'^(\w+)-(\d+)-(\d+)$');
                              if (value!.isEmpty) {
                                return "Address can't be blank";
                              } else if (!subareaBlockHouseRegex
                                  .hasMatch(value)) {
                                return 'Address must be of format subarea-block-house';
                              }
                              return null;
                            }),
                          ),
                          SizedBox(
                            height: spacing,
                          ),
                          TextFormField(
                            controller: apartmetAdrrController,
                            decoration: const InputDecoration(
                              hintText: 'Apartment, Suite or Unit',
                            ),
                            validator: ((value) {
                              if (value!.isEmpty) {
                                return 'Enter apartment number or suite/unit';
                              }
                              return null;
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.075,
                    width: double.infinity - 10,
                    child: ElevatedButton(
                      onPressed: (countryController.text.isEmpty)
                          ? null
                          : () {
                              final isValid = _formKey.currentState!.validate();
                              if (!isValid) {
                                return;
                              }

                              _formKey.currentState!.save();
                              Address(
                                  countryController.text,
                                  munController.text,
                                  prefectureController.text,
                                  streetAdrrController.text,
                                  apartmetAdrrController.text);
                              Navigator.pop(context);
                            },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF5408AD),
                          disabledForegroundColor: Colors.white,
                          disabledBackgroundColor:
                              const Color.fromARGB(255, 203, 186, 223)
                                  .withOpacity(1),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)))),
                      child: const Text(
                        'Next',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
