class ActivationCode {
  final int codeID;
  final String post;
  final int postID;

  ActivationCode(this.codeID, this.post, this.postID);

  factory ActivationCode.fromJson(Map<String, dynamic> json) {
    return ActivationCode(
      json["0"],
      json["1"],
      json["2"],
    );
  }
}
