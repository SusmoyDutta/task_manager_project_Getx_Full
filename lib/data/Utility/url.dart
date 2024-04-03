class Urls {
  static const String _baseUrl = 'https://task.teamrabbil.com/api/v1';
  static String registration = '$_baseUrl/registration';
  static String login = '$_baseUrl/login';
  static String createTask = '$_baseUrl/createTask';
  static String taskStatusCount = '$_baseUrl/taskStatusCount';
  static String newListTaskByStatus = '$_baseUrl/listTaskByStatus/New';
  static String completedTaskByStatus = '$_baseUrl/listTaskByStatus/Complete';
  static String cancelListTaskByStatus = '$_baseUrl/listTaskByStatus/Cancel';
  static String progressListTaskByStatus = '$_baseUrl/listTaskByStatus/Progress';
  static String deleteTask(String id) => '$_baseUrl/deleteTask/$id';
  static String updateTaskStatus(String id, String status) => '$_baseUrl/updateTaskStatus/$id/$status';
  static String recoverVerifyOTP(String email, String otp) => '$_baseUrl/RecoverVerifyOTP/$email/$otp';
  static String recoverVerifyEmail(String email,) => '$_baseUrl/RecoverVerifyEmail/$email';
  static String recoverResetPass = '$_baseUrl/RecoverResetPass';
  static String profileUpdate = '$_baseUrl/profileUpdate';
}
