class User_Auth {
  /// user 테이블 PK
  String? id; // id를 nullable로 변경

  /// 사용자 ID
  String username;

  /// 해시화된 비밀번호
  String hashedPassword;

  /// 전화번호
  String p_num;

  /// 관리자 계정 여부
  bool isAdmin; // isAdmin 필드 추가

  /// 생성자
  User_Auth({
    this.id, // id는 이제 optional
    required this.username,
    required this.hashedPassword,
    required this.p_num,
    this.isAdmin = false, // 기본값을 false로 설정
  });

  /// User 객체를 JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'password': hashedPassword,
      'p_num': p_num,
      'isAdmin': isAdmin, // isAdmin 추가
    };
  }

  /// JSON을 User 객체로 변환
  factory User_Auth.fromJson(Map<String, dynamic> json) {
    return User_Auth(
      id: json['id'] as String?,
      username: json['username'] as String,
      hashedPassword: json['password'] as String,
      p_num: json['p_num'] as String,
      isAdmin: json['isAdmin'] as bool? ?? false, // isAdmin 추가, null일 경우 기본값 false
    );
  }
}
