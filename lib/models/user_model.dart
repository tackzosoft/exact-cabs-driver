class UserModel{
  final String userId;
  final String email;
  final String username;
  final String password;
  final String deviceId;
  final String deviceType;
  final String createdBy;
  final String userType;
  final int active;
  final String passwordSalt;
  final String dateCreated;
  final String dateModified;
  final int accountStatus;
  final Map driverDetails;

  UserModel(
      {this.userId,
      this.email,
      this.username,
      this.password,
      this.deviceId,
      this.deviceType,
      this.createdBy,
      this.userType,
      this.active,
      this.passwordSalt,
      this.dateCreated,
      this.dateModified,
      this.accountStatus,
      this.driverDetails});

factory UserModel.fromJson(Map<String, dynamic> body)=>UserModel(
  userId: body["user_id"],
  email: body["email"],
  username: body["username"],
  password: body["password"],
  deviceId: body["device_id"],
  deviceType: body["device_type"],
  createdBy: body["created_by"],
  userType: body["user_type"],
  active: body["active"],
  passwordSalt: body["password_salt"],
  dateCreated: body["date_created"],
  dateModified: body["date_modifed"],
  accountStatus: body["driver_details"]["status"],
  driverDetails: body["driver_details"]
);

}