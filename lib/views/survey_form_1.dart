import 'dart:convert';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../theme/app_theme.dart';
import '../utils/globals.dart';
import '../utils/sizeconfig.dart';
import '../widgets/appBar.dart';
import '../widgets/bottom_curved_shadow.dart';

// class Survey extends StatefulWidget {
//   @override
//   _SurveyState createState() => _SurveyState();
// }

// class _SurveyState extends State<Survey> {
//   Map<String, dynamic> formData = {};
//   void main() {
//     String input = '''
//     [
//       {"id": "name", "value": "survey"},
//       {"id": "field-1-label", "value": "Town"},
//       {"id": "field-1", "value": null},
//       {"id": "field-1-type", "value": "text"},
//       {"id": "field-3-label", "value": "Period"},
//       {"id": "field-3-type", "value": "DropDown"},
//       {"id": "field-3-item", "value": "Day,Month,Year"},
//       {"id": "field-5-label", "value": "Gender"},
//       {"id": "field-5-type", "value": "radio"},
//       {"id": "field-5-item", "value": "Male,Female"},
//       {"id": "field-5", "value": "Male"},
//       {"id": "field-7-label", "value": "Developer Application"},
//       {"id": "field-7-type", "value": "checkbox"},
//       {"id": "field-7-item", "value": "Web,Mobile"}
//     ]
//   ''';

//     List<dynamic> inputData = jsonDecode(input);

//     for (var data in inputData) {
//       if (data['id'].startsWith('field-')) {
//         String fieldId = data['id'];
//         int fieldNumber = int.parse(fieldId.substring(6));

//         if (!formData.containsKey('field-$fieldNumber')) {
//           formData['field-$fieldNumber'] = {};
//         }

//         formData['field-$fieldNumber'][fieldId] = data['value'];
//       }
//     }

//     print(formData);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Dynamic Form Demo',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: SurveyForm(formData: formData),
//     );
//   }
// }

class SurveyForm extends StatefulWidget {
  const SurveyForm({Key key}) : super(key: key);

  // final Map<String, dynamic> formData;

  @override
  State<SurveyForm> createState() => _SurveyFormState();
}

class _SurveyFormState extends State<SurveyForm> {
  bool isDark = false;
  String currentDarkModePref = "";

  // Map<String, dynamic> formData;

  void main() {
    //   String jsonStr = '''
    //   [
    //     {"id": "name", "value": "survey"},
    //     {"id": "field-1-label", "value": "Town"},
    //     {"id": "field-1", "value": null},
    //     {"id": "field-1-type", "value": "text"},
    //     {"id": "field-3-label", "value": "Period"},
    //     {"id": "field-3-type", "value": "DropDown"},
    //     {"id": "field-3-item", "value": "Day,Month,Year"},
    //     {"id": "field-5-label", "value": "Gender"},
    //     {"id": "field-5-type", "value": "radio"},
    //     {"id": "field-5-item", "value": "Male,Female"},
    //     {"id": "field-5", "value": "Male"},
    //     {"id": "field-7-label", "value": "Developer Application"},
    //     {"id": "field-7-type", "value": "checkbox"},
    //     {"id": "field-7-item", "value": "Web,Mobile"}
    //   ]
    // ''';

    //   List<dynamic> inputData = jsonDecode(jsonStr);

    //   for (var data in inputData) {
    //     if (data['id'].startsWith('field-')) {
    //       String fieldId = data['id'];
    //       int fieldNumber = int.parse(fieldId.substring(6));

    //       if (!formData.containsKey('field-$fieldNumber')) {
    //         formData['field-$fieldNumber'] = {};
    //       }

    //       formData['field-$fieldNumber'][fieldId] = data['value'];
    //     }
    //   }

    String jsonString =
        '[{"id":"name","value":"survey"},{"id":"field-1-label","value":"Town"},{"id":"field-1","value":null},{"id":"field-1-type","value":"text"},{"id":"field-3-label","value":"Period"},{"id":"field-3-type","value":"DropDown"},{"id":"field-3-item","value":"Day,Month,Year"},{"id":"field-5-label","value":"Gender"},{"id":"field-5-type","value":"radio"},{"id":"field-5-item","value":"Male,Female"},{"id":"field-5","value":"Male"},{"id":"field-7-label","value":"Developer Application"},{"id":"field-7-type","value":"checkbox"},{"id":"field-7-item","value":"Web,Mobile"}]';

    List<dynamic> list = jsonDecode(jsonString);

    Map<String, dynamic> result = {};

    for (dynamic item in list) {
      String id = item['id'];
      String value = item['value'];

      if (id == 'name') {
        result[id] = value;
        continue;
      }

      String key = id.split('-')[0];
      String subKey = id.split('-')[1];

      if (!result.containsKey(key)) {
        result[key] = {};
      }

      result[key][subKey] = value;
    }

    formData = result;

    print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
    print(result);
  }

  Map<String, dynamic> formValues = {};

  Map<String, dynamic> formData = {
    "field-1": {
      "field-1-label": "Town",
      "field-1": null,
      "field-1-type": "text"
    },
    "field-2": {
      "field-2-label": "Period",
      "field-2-type": "DropDown",
      "field-2-item": "Day,Month,Year"
    },
    "field-3": {
      "field-3-label": "Gender",
      "field-3-type": "radio",
      "field-3-item": "Male,Female",
      "field-3": "Male"
    }
  };

  @override
  void initState() {
    super.initState();
    // main();
    // Initialize form values with default values from the JSON
    formData.forEach((key, value) {
      if (value is Map && value.containsKey('$key')) {
        formValues[key] = value['$key'];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    if (AdaptiveTheme.of(context).mode == AdaptiveThemeMode.system) {
      setState(() => isDark = Globals.systemDarkMode.getValue());
    } else if (AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark) {
      setState(() => isDark = true);
    } else {
      setState(() => isDark = false);
    }

    if (AdaptiveTheme.of(context).mode == AdaptiveThemeMode.system) {
      setState(() => currentDarkModePref = "System");
    } else {
      setState(() => currentDarkModePref = "Custom");
    }

    double cardH = AppBar().preferredSize.height;

    Widget settingsTile({
      @required Widget leading,
      @required String title,
      @required Widget trailing,
    }) {
      Color bgColor = isDark ? COLORS.DARK_GREY : COLORS.LIGHTER_GREY;
      Widget tiles = Container(
        margin: EdgeInsets.only(
          top: 2,
          bottom: 2,
          left: SizeConfig.screenWidth * 0.075,
          right: SizeConfig.screenWidth * 0.075,
        ),
        padding: EdgeInsets.only(
          left: SizeConfig.screenWidth * 0.025,
          right: SizeConfig.screenWidth * 0.025,
        ),
        height: cardH,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          children: [
            leading,
            Expanded(
              child: Text(
                title,
                style: const TextStyle(color: COLORS.MEDIUM_DARK_GREY),
              ),
            ),
            trailing,
          ],
        ),
      );
      return tiles;
    }

    print(formData);
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: CurvedShadowDecoration.getDecoration(isDark: isDark),
            child: ThemeAppBar.appBar(context, title: "Survey"),
          ),
          Container(
            color: Color.fromARGB(255, 188, 180, 180),
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(40),
            child: Column(
              children: formData.entries.map((entry) {
                Text(
                  "fieldName",
                  style: TextStyle(color: Colors.red, fontSize: 29),
                );
                final String fieldName = entry.key;
                final Map<String, dynamic> fieldData = entry.value;

                if (fieldData.containsKey('$fieldName-type')) {
                  final String fieldType = fieldData['$fieldName-type'];
                  Widget formField;

                  if (fieldType == 'text') {
                    formField = TextFormField(
                      decoration: InputDecoration(
                        labelText: fieldData['$fieldName-label'],
                      ),
                      onChanged: (value) {
                        setState(() {
                          formValues[fieldName] = value;
                        });
                      },
                    );
                  } else if (fieldType == 'DropDown') {
                    final List<String> dropdownItems =
                        fieldData['$fieldName-item'].split(',');

                    formField = DropdownButtonFormField(
                      decoration: InputDecoration(
                        labelText: fieldData['$fieldName-label'],
                      ),
                      value: formValues[fieldName],
                      items: dropdownItems.map((item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          formValues[fieldName] = value;
                        });
                      },
                    );
                  } else if (fieldType == 'radio') {
                    final List<String> radioItems =
                        fieldData['$fieldName-item'].split(',');

                    formField = Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: radioItems.map((item) {
                        return Row(
                          children: [
                            Radio(
                              value: item,
                              groupValue: formValues[fieldName],
                              onChanged: (value) {
                                setState(() {
                                  formValues[fieldName] = value;
                                });
                              },
                            ),
                            Text(item),
                          ],
                        );
                      }).toList(),
                    );
                  }

                  if (formField != null) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: formField,
                    );
                  }
                }

                return SizedBox.shrink();
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
