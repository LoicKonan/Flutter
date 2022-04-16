class CompilationResult {
  List<Comments>? comments;
  Make? make;
  String? stdout;
  String? resultsTxt;

  CompilationResult({this.comments, this.make, this.stdout, this.resultsTxt});

  CompilationResult.fromJson(Map<String, dynamic> json) {
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(new Comments.fromJson(v));
      });
    }
    make = json['make'] != null ? new Make.fromJson(json['make']) : null;
    stdout = json['stdout'];
    resultsTxt = json['results.txt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.comments != null) {
      data['comments'] = this.comments!.map((v) => v.toJson()).toList();
    }
    if (this.make != null) {
      data['make'] = this.make!.toJson();
    }
    data['stdout'] = this.stdout;
    data['results.txt'] = this.resultsTxt;
    return data;
  }
}

class Comments {
  File? file;

  Comments({this.file});

  Comments.fromJson(Map<String, dynamic> json) {
    file = json['file'] != null ? new File.fromJson(json['file']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.file != null) {
      data['file'] = this.file!.toJson();
    }
    return data;
  }
}

class File {
  String? comments;
  int? lines;
  int? totalLines;
  double? commentPercentage;

  File({this.comments, this.lines, this.totalLines, this.commentPercentage});

  File.fromJson(Map<String, dynamic> json) {
    comments = json['comments'];
    lines = json['lines'];
    totalLines = json['total_lines'];
    commentPercentage = json['comment_percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comments'] = this.comments;
    data['lines'] = this.lines;
    data['total_lines'] = this.totalLines;
    data['comment_percentage'] = this.commentPercentage;
    return data;
  }
}

class Make {
  String? stdout;
  Null? stderr;
  int? returncode;

  Make({this.stdout, this.stderr, this.returncode});

  Make.fromJson(Map<String, dynamic> json) {
    stdout = json['stdout'];
    stderr = json['stderr'];
    returncode = json['returncode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stdout'] = this.stdout;
    data['stderr'] = this.stderr;
    data['returncode'] = this.returncode;
    return data;
  }
}
