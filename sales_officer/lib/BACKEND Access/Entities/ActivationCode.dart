class ActivationCode {
  final int codeID;
  final String post;
  final int postID;

  ActivationCode(this.codeID, this.post, this.postID);

  factory ActivationCode.fromJson(Map<String, dynamic> json) {
    return ActivationCode(
      int.parse(json["codeID"].toStringAsFixed(0)),
      json["post"],
      int.parse(json["postID"].toStringAsFixed(0)),
    );
  }
}

