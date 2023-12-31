/// The UserRecord DataClass for the User
class UserRecord {
  /// build the UserRecord Class from a JSON Object
  factory UserRecord.fromJson(Map<String, dynamic> json) {
    final emailAddress = (json['email_address'] ?? '') as String;
    if (emailAddress.isEmpty) {
      throw Exception('Email Cannot be empty');
    }

    final isVerified = json['is_verified'] as bool;
    final dateRegistered = DateTime.parse(json['date_created'] as String);
    final firstName = json['first_name'] as String;
    final lastName = json['last_name'] as String;
    final userUniqueId = json['user_unique_id'] as String;
    final statusInProject =
        UserStatusInProject.fromString(json['status_in_project'] as String);

    final countryCode = json['country_code'] as String;
    final countryName = json['country_name'] as String;

    return UserRecord(
      emailAddress: emailAddress,
      isVerified: isVerified,
      dateRegistered: dateRegistered,
      firstName: firstName,
      lastName: lastName,
      userUniqueId: userUniqueId,
      statusInProject: statusInProject,
      countryCode: countryCode,
      countryName: countryName,
    );
  }

  /// Default Constructor
  UserRecord({
    required this.emailAddress,
    required this.isVerified,
    required this.dateRegistered,
    required this.firstName,
    required this.lastName,
    required this.userUniqueId,
    required this.statusInProject,
    required this.countryCode,
    required this.countryName,
  });

  /// The email address of the user
  String emailAddress;

  /// Status of the user, Email Verified or Not
  bool isVerified;

  /// The Date the User registered to this project
  DateTime dateRegistered;

  /// The first name of the user
  String firstName;

  /// The last name of the user
  String lastName;

  /// The Unique Id of the user. Can be used as a Foreign key to
  /// An External Database
  String userUniqueId;

  /// The User Status in a project. Can be Invited, Waitlisted, Live
  UserStatusInProject statusInProject;

  /// The Country Code the user registered from
  String countryCode;

  /// The Country Code the user registered from
  String countryName;

  /// Create A JSON Object from the User Record
  Map<String, dynamic> toJson() => {
        'email_address': emailAddress,
        'is_verified': isVerified,
        'date_created': dateRegistered.toIso8601String(),
        'first_name': firstName,
        'last_name': lastName,
        'user_unique_id': userUniqueId,
        'status_in_project': statusInProject,
        'country_code': countryCode,
        'country_name': countryName,
      };
}

/// Enum for thr User Status in the Project
enum UserStatusInProject {
  waitlisted,
  invited,
  live;

  static UserStatusInProject fromString(String userStatus) {
    if (userStatus.toLowerCase() == 'invited') {
      return UserStatusInProject.invited;
    } else if (userStatus.toLowerCase() == 'waitlisted') {
      return UserStatusInProject.waitlisted;
    } else if (userStatus.toLowerCase() == 'live') {
      return UserStatusInProject.live;
    }

    throw UnimplementedError();
  }

  String get toStringRep {
    if (isInvited) {
      return 'Invited';
    } else if (isWaitlisted) {
      return 'Waitlisted';
    } else if (isLive) {
      return 'live';
    }
    throw UnimplementedError();
  }
}

///@
extension UserStatusInProjectX on UserStatusInProject {
  bool get isWaitlisted => this == UserStatusInProject.waitlisted;

  bool get isInvited => this == UserStatusInProject.invited;

  bool get isLive => this == UserStatusInProject.live;
}
