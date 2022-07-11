import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController pincode = TextEditingController();
  int _activeStepIndex = 0;
  List<Step> stepList(node) => [
        Step(
          state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 0,
          title: const Text('Account'),
          content: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(left: 50, right: 16),
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 5.0),
                        ),
                        prefixIcon: const Icon(
                          Icons.person,
                        ),
                        hintText: 'Full Name'),
                    controller: name,
                    validator: (value) => value!.isEmpty
                        ? '* Required'
                        : RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]')
                                .hasMatch(value)
                            ? 'Enter a Valid Name'
                            : null,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () => node.nextFocus(),
                  ),
                  const SizedBox(height: 10.0),
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 5.0),
                        ),
                        prefixIcon: const Icon(
                          Icons.email,
                        ),
                        hintText: 'Email'),
                    controller: email,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '* Required';
                      }
                      const pattern =
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                      final regExp = RegExp(pattern);

                      if (!regExp.hasMatch(value)) {
                        return 'Enter Valid Email Id';
                      } else {
                        return null;
                      }
                    },
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () => node.nextFocus(),
                  ),
                  const SizedBox(height: 10.0),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 5.0),
                        ),
                        prefixIcon: const Icon(
                          Icons.phone,
                        ),
                        hintText: 'Phone Number'),
                    controller: phoneNumber,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "* Required.";
                      }
                      String numPattern =
                          r'^[0-9]+$'; //Phone Number validation regular expression.
                      RegExp regExp = RegExp(numPattern);

                      if (!regExp.hasMatch(value)) {
                        return "Invalid number format.";
                      } else if (value.length < 10 || value.length > 10) {
                        return "Number should be of 10 digits.";
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () => node.nextFocus(),
                  ),
                ],
              ),
            ),
          ),
        ),
        Step(
          state: _activeStepIndex <= 1 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 1,
          title: const Text('Address'),
          content: Padding(
            padding: const EdgeInsets.only(left: 50, right: 16),
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.streetAddress,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 5.0),
                      ),
                      prefixIcon: const Icon(
                        Icons.home,
                      ),
                      hintText: 'Address'),
                  controller: address,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "* Required";
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () => node.nextFocus(),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 5.0),
                      ),
                      prefixIcon: const Icon(Icons.pin_drop),
                      hintText: 'Pin Code'),
                  controller: pincode,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "* Required";
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () => node.nextFocus(),
                ),
              ],
            ),
          ),
        ),
        Step(
          state: StepState.complete,
          isActive: _activeStepIndex >= 2,
          title: const Text('Verify'),
          content: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Card(
                  elevation: 10.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _display('Name:', name.text),
                        _display('Email:', email.text),
                        _display('Phone No:', phoneNumber.text),
                        _display('Address:', address.text),
                        _display('PinCode:', pincode.text),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ];

  Widget _display(title, text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.60,
              child: Text(
                text,
                style: const TextStyle(
                    fontSize: 15, fontWeight: FontWeight.normal),
              ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Register',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Stepper(
        margin: EdgeInsets.zero,
        steps: stepList(node),
        currentStep: _activeStepIndex,
        onStepContinue: () {
          if (_activeStepIndex < (stepList(node).length - 1) &&
              _formKey.currentState!.validate()) {
            setState(() {
              _activeStepIndex += 1;
            });
          } else if (_activeStepIndex == (stepList(node).length - 1)) {
            createAlertDialog(context, 'Registered Successfully');
          }
        },
        onStepCancel: () {
          if (_activeStepIndex == 0) {
            return;
          }
          setState(() {
            _activeStepIndex -= 1;
          });
        },
        controlsBuilder: (context, ControlsDetails controlsDetails) {
          return _controlBuilder(node, controlsDetails);
        },
      ),
    );
  }

  Padding _controlBuilder(
      FocusScopeNode node, ControlsDetails controlsDetails) {
    return Padding(
      padding: EdgeInsets.only(
          left: 50,
          right: _activeStepIndex < stepList(node).length - 1 ? 20 : 50,
          top: 15),
      child: Row(
        children: [
          if (_activeStepIndex > 0 &&
              _activeStepIndex < stepList(node).length - 1)
            Expanded(
              child: ElevatedButton(
                onPressed: controlsDetails.onStepCancel,
                child: const Text(
                  'Previous',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          const SizedBox(
            width: 10,
          ),
          _activeStepIndex < stepList(node).length - 1
              ? Expanded(
                  child: ElevatedButton(
                    onPressed: controlsDetails.onStepContinue,
                    child: const Text(
                      'Continue',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                )
              : Expanded(
                  child: ElevatedButton(
                    onPressed: controlsDetails.onStepContinue,
                    child: const Text(
                      'Submit',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  createAlertDialog(BuildContext context, String text) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            elevation: 0,
            contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 10),
            content: Text(
              text,
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    name.clear();
                    email.clear();
                    phoneNumber.clear();
                    address.clear();
                    pincode.clear();
                    setState(() {
                      _activeStepIndex = 0;
                    });
                  },
                  child: const Text('OK'),
                ),
              )
            ],
          );
        });
  }
}
