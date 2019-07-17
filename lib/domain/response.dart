class Response {
  final String status;
  final String msg;

  Response(this.status, this.msg);

  bool isOK(){
    return status == "OK";
  }

  Response.fromJson(Map<String, dynamic> map)
      : status = map["status"],
        msg = map["msg"];
}
