class CallHistory {
  int? id;
  String? receiverno;
  String? callerno;
  String? calledat;

  CallHistory({this.callerno, this.receiverno, this.calledat, this.id});
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'receiverno': receiverno,
      'callerno': callerno,
      'calledat': calledat,
    };
  }

  factory CallHistory.fromMap(Map<String, dynamic> map) {
    return CallHistory(
      id: map['id'],
      receiverno: map['receiverno'],
      callerno: map['callerno'],
      calledat: map['calledat'],
    );
  }
}
