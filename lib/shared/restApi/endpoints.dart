// ignore_for_file: constant_identifier_names

final class EndPoints {
  /// Api base url
  static const String baseUrl = 'https://app.plug2go.net/api/v1/';

  // ^ Header value
  static const Header_Content_Key = 'Content-Type';
  static const Header_Content_value = 'application/json';
  static const Header_Content_valueFormData = 'application/form-data';
  static const Header_Content_valueUnlecoded = 'application/x-www-form-urlencoded';
  static const Header_Authorization_KEY = 'Authorization';
  static const Header_Accept_Key = 'Accept';
  static const BEARER_TOKEN = 'Bearer ';

  /// Endpoint for fetching users
  static const String emailLogin = 'login/email';
  static const String phoneLogin = 'login/phone';
  static const String logout = 'revoke-token';
  static const String sendSignupOTP = 'send-otp/sign-up';
  static const String sendForgotPasswordOTP = 'send-otp/password-reset';
  static const String emailSignup = 'register/email';
  static const String phoneSignup = 'register/phone';
  static const String verifyOTP = 'verify-otp';
  static const String checkPhoneNumber = 'check-phone-number';
  static const String resetPassword = 'reset-password';
  static const String help = 'help-feedback';
  static const String saveFCMToken = 'save-fcm-token';
  static const String updateUserDetails = 'update-user-detail';
  static const String getUserDetails = 'user-detail';
  static const String changePassword = 'change-password';
  static const String notificationList = 'notification-list';
  // static const String readNotification = 'mark-as-read';
  static const String getNotificationCount = 'get-notification-count';
  static const String deleteUser = 'delete-user';
  static const String addVehiclesDetails = 'vehicles';
  static const String editVehiclesDetails = 'vehicles';
  static const String getVehiclesDetails = 'vehicles';
  static const String getVehiclesList = 'vehicles';
  static const String deleteVehiclesDetails = 'vehicles';
  static const String addChargingStationDetails = 'charging-station';
  static const String getChargingStationDetails = 'charging-station';
  static const String updateChargingStationDetails = 'charging-station';
  static const String deleteChargingStationDetails = 'charging-station';
  static const String getNearbyChargingStation = 'nearby-charging-stations';
  static const String sendServiceRequest = 'send-service-request';
  static const String getServiceRequest = 'service-requests';
  static const String getServiceRequestDetails = 'service-request';
  static const String updateServiceRequestDetails = 'service-request';
  static const String addPaymentCard = 'add-card';
  static const String getPaymentCard = 'get-card';
  static const String deletePaymentCard = 'remove-card';
  static const String updateLocation = 'update-location';
}
