import 'package:medtest/medtest/medtest_app_theme.dart';
// import 'package:medtest/design_course/home_design_course.dart';
import 'package:medtest/location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:medtest/medtest/models/category.dart';
import 'package:medtest/main.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
// import 'package:intl/intl.dart';

class PatientDetail extends StatefulWidget {
  final Function(int)? callBack;
  const PatientDetail({super.key, this.callBack});

  @override
  State<PatientDetail> createState() => _PatientDetailState();
}

class _PatientDetailState extends State<PatientDetail> {
  @override
  final _scrollController = ScrollController();
  final _scrollController2 = ScrollController();
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  final _formKey = GlobalKey<FormBuilderState>();
  bool _ageHasError = false;
  bool _genderHasError = false;

  var genderOptions = ['Male', 'Female', 'Other'];

  void _onChanged(dynamic val) => debugPrint(val.toString());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: DesignCourseAppTheme.nearlyWhite,
        foregroundColor: DesignCourseAppTheme.nearlyBlue,
        title: Text(
          'Cart',
          style: TextStyle(color: DesignCourseAppTheme.lightText, fontSize: 24),
        ),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
          ),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            height: size.height / 3.8,
            width: size.width,
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            decoration: BoxDecoration(
              color: DesignCourseAppTheme.nearlyWhite,
              boxShadow: [
                BoxShadow(
                    color: DesignCourseAppTheme.notWhite,
                    blurRadius: 2,
                    spreadRadius: 2,
                    blurStyle: BlurStyle.normal)
              ],
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    child: Scrollbar(
                      controller: _scrollController,
                      //always show scrollbar
                      thumbVisibility: true,

                      thickness: 4, //width of scrollbar
                      radius: Radius.circular(20),
                      scrollbarOrientation: ScrollbarOrientation.right,

                      child: SingleChildScrollView(
                        controller: _scrollController,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              for (int i = 0; i < lenOfItems; i++)
                                cartItemsList[i]
                                    ? Container(
                                        height: 69,
                                        padding: EdgeInsets.all(5),
                                        margin:
                                            EdgeInsets.symmetric(vertical: 5),
                                        decoration: BoxDecoration(
                                          color: DesignCourseAppTheme
                                              .chipBackground,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(16.0)),
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              child: Row(
                                                children: <Widget>[
                                                  ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                16.0)),
                                                    child: AspectRatio(
                                                        aspectRatio: 1.0,
                                                        child: Image.asset(Category
                                                            .popularCourseList[
                                                                i]
                                                            .imagePath)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 14),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Text(
                                                        Category
                                                            .popularCourseList[
                                                                i]
                                                            .title,
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 14.5,
                                                          letterSpacing: 0.27,
                                                          color:
                                                              DesignCourseAppTheme
                                                                  .lightText,
                                                        ),
                                                      ),
                                                      Text(
                                                        '\$ ${Category.popularCourseList[i].money}',
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 14,
                                                          letterSpacing: 0.27,
                                                          color:
                                                              DesignCourseAppTheme
                                                                  .nearlyBlue,
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                VerticalDivider(
                  color: Colors.grey[400],
                  thickness: 2,
                  width: 20,
                  indent: 0,
                  endIndent: 0,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 40,
                      width: 80,
                      margin: EdgeInsets.only(right: 20, left: 10),
                      decoration: BoxDecoration(
                        color: DesignCourseAppTheme.nearlyBlue.withOpacity(1),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(16.0),
                        ),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: DesignCourseAppTheme.nearlyBlue
                                  .withOpacity(0.4),
                              offset: const Offset(1.1, 1.1),
                              blurRadius: 10.0),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'Edit Cart',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            letterSpacing: 0.0,
                            color: DesignCourseAppTheme.nearlyWhite,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: size.height / 25,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 14.0),
            child: Text(
              'Patient Detail',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 22,
                letterSpacing: 0.27,
                color: DesignCourseAppTheme.darkerText,
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 2, color: DesignCourseAppTheme.notWhite),
                  borderRadius: BorderRadius.all(Radius.circular(40))),
              child: Scrollbar(
                thumbVisibility: true,
                scrollbarOrientation: ScrollbarOrientation.right,
                thickness: 4,
                radius: Radius.circular(20),
                controller: _scrollController2,
                child: SingleChildScrollView(
                  controller: _scrollController2,
                  child: Column(
                    children: [
                      FormBuilder(
                        key: _formKey,
                        onChanged: () {
                          _formKey.currentState!.save();
                        },
                        autovalidateMode: AutovalidateMode.disabled,
                        child: SingleChildScrollView(
                          child: Column(children: <Widget>[
                            const SizedBox(height: 5),
                            FormBuilderTextField(
                              name: 'name',
                              decoration: InputDecoration(
                                labelText: 'Patient Full Name',
                              ),
                              onChanged: (val) {
                                setState(() {
                                  _ageHasError = !(_formKey
                                          .currentState?.fields['name']
                                          ?.validate() ??
                                      false);
                                });
                              },
                              // valueTransformer: (text) => num.tryParse(text),
                              // validator: FormBuilderValidators.compose([
                              //   FormBuilderValidators.required(),
                              //   // FormBuilderValidators.numeric(),
                              //   FormBuilderValidators.max(70),
                              // ]),
                              // initialValue: '12',
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                            ),
                            const SizedBox(height: 15),
                            FormBuilderTextField(
                              name: 'age',
                              decoration: InputDecoration(
                                labelText: 'Age',
                              ),
                              onChanged: (val) {
                                setState(() {
                                  _ageHasError = !(_formKey
                                          .currentState?.fields['age']
                                          ?.validate() ??
                                      false);
                                });
                              },
                              // valueTransformer: (text) => num.tryParse(text),
                              // validator: FormBuilderValidators.compose([
                              //   FormBuilderValidators.required(),
                              //   FormBuilderValidators.numeric(),
                              //   FormBuilderValidators.max(70),
                              // ]),
                              // initialValue: '12',
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                            ),
                            const SizedBox(height: 15),
                            FormBuilderDropdown<String>(
                              // autovalidate: true,
                              name: 'gender',
                              decoration: InputDecoration(
                                labelText: 'Gender',
                                hintText: 'Select Gender',
                              ),
                              validator: FormBuilderValidators.compose(
                                  [FormBuilderValidators.required()]),

                              items: genderOptions
                                  .map((gender) => DropdownMenuItem(
                                        alignment: AlignmentDirectional.center,
                                        value: gender,
                                        child: Text(gender),
                                      ))
                                  .toList(),
                              onChanged: (val) {
                                setState(() {
                                  _genderHasError = !(_formKey
                                          .currentState?.fields['gender']
                                          ?.validate() ??
                                      false);
                                });
                              },
                              valueTransformer: (val) => val?.toString(),
                            ),
                            const SizedBox(height: 15),
                            FormBuilderTextField(
                              name: 'phnum',
                              decoration: InputDecoration(
                                labelText: 'Mobile Number',
                              ),
                              onChanged: (val) {
                                setState(() {
                                  _ageHasError = !(_formKey
                                          .currentState?.fields['phnum']
                                          ?.validate() ??
                                      false);
                                });
                              },
                              // valueTransformer: (text) => num.tryParse(text),
                              // validator: FormBuilderValidators.compose([
                              //   FormBuilderValidators.required(),
                              //   FormBuilderValidators.numeric(),
                              //   FormBuilderValidators.max(70),
                              // ]),
                              // initialValue: '12',
                              keyboardType: TextInputType.phone,
                              textInputAction: TextInputAction.next,
                            ),
                            const SizedBox(height: 15),
                            FormBuilderDateTimePicker(
                              name: 'date',
                              firstDate: DateTime.now(),

                              initialEntryMode: DatePickerEntryMode.calendar,

                              inputType: InputType.both,
                              decoration: InputDecoration(
                                labelText: 'Appointment Time',
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.close),
                                  onPressed: () {
                                    _formKey.currentState!.fields['date']
                                        ?.didChange(null);
                                  },
                                ),
                              ),
                              initialTime: const TimeOfDay(hour: 8, minute: 0),
                              // locale: const Locale.fromSubtags(languageCode: 'fr'),
                            ),
                          ]),
                        ),
                      ),
                      const SizedBox(height: 36),
                      GestureDetector(
                        onTap: () {
                          if (_formKey.currentState?.saveAndValidate() ??
                              false) {
                            Navigator.push(
                              _scaffoldKey.currentContext!,
                              MaterialPageRoute(
                                builder: (context) => Location(
                                  formdata:
                                      _formKey.currentState?.value.toString(),
                                  cart: cart(),
                                ),
                              ),
                            );
                          } else {
                            print('error in form validation');
                          }
                        },
                        child: Container(
                          height: 42,
                          width: 200,
                          decoration: BoxDecoration(
                            color:
                                DesignCourseAppTheme.nearlyBlue.withOpacity(1),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(16.0),
                            ),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: DesignCourseAppTheme.nearlyBlue
                                      .withOpacity(0.4),
                                  offset: const Offset(1.1, 1.1),
                                  blurRadius: 10.0),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              'Proceed',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                letterSpacing: 0.0,
                                color: DesignCourseAppTheme.nearlyWhite,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  String cart() {
    String l = '';
    for (int i = 0; i < lenOfItems; i++) {
      if (cartItemsList[i]) {
        l == ''
            ? l = Category.popularCourseList[i].title
            : l = l + ', ' + Category.popularCourseList[i].title;
      }
    }
    return l;
  }
}
