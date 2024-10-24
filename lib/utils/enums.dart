// App enum will be declared here

// ignore_for_file: constant_identifier_names

enum Demo { step1, step2, step3 }

extension MeetingTypeExtension on Demo {
  String get name {
    switch (this) {
      case Demo.step1:
        return 'step1';
      case Demo.step2:
        return 'step2';
      case Demo.step3:
        return 'step3';
    }
  }
}
