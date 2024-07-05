class ChatUser {
  ChatUser({
    required this.active,
    required this.email,
    required this.about,
    required this.name,
    required this.status,
  });

  late final bool active;
  late final String email;
  late final String about;
  late final String name;
  late final String status;

  ChatUser.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      active = json['Active'] ?? false; // Use false as default value for bool
      email = json['Email'] ?? '';
      about = json['about'] ?? '';
      name = json['Name'] ?? '';
      status = json['Status'] ?? '';
    } else {
      // Handle case where json is null (if required)
      active = false;
      email = '';
      about = '';
      name = '';
      status = '';
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Active'] = active;
    data['Email'] = email;
    data['about'] = about;
    data['Name'] = name;
    data['Status'] = status;
    return data;
  }
}
//d