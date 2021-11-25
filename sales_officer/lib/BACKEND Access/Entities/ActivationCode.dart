class ActivationCode {
  final int codeID;
  final String post;
  final int postID;

  ActivationCode(this.codeID, this.post, this.postID);

  factory ActivationCode.fromJson(Map<String, dynamic> json) {
    return ActivationCode(
      int.parse(json["0"]),
      json["1"],
      int.parse(json["2"]),
    );
  }
}

