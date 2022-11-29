

class StudentDataModel{
  String? studentName;
  String? fathersName;
  String? mothersName;
  String? dateOfBirth;
  String? rollNumber;
  String? className;
  String? classGroup;
  String? bloodGroup;
  String? studentContact;
  String? familyContact;
  String? pictureUrl;
  String? gender;

  StudentDataModel(
      {this.studentName,
      this.fathersName,
      this.mothersName,
      this.dateOfBirth,
      this.rollNumber,
      this.className,
      this.classGroup,
      this.bloodGroup,
      this.studentContact,
      this.familyContact,
      this.gender,
      this.pictureUrl}
      );
  StudentDataModel.fromJson(dynamic json){
     studentName = json['studentName'];
     fathersName = json['fathersName'];
     mothersName = json['mothersName'];
     dateOfBirth =  json['dateOfBirth'];
     rollNumber = json['rollNumber'];
     className = json['className'];
     classGroup = json['classGroup'];
     bloodGroup = json['bloodGroup'];
     studentContact = json['studentContact'];
     familyContact = json['familyContact'];
     gender = json['gender'];
     pictureUrl = json['pictureUrl'];
  }
  Map<String, dynamic> toJson(){
    final map= <String,dynamic>{};
    map['studentName']=studentName;
    map['fathersName'] = fathersName;
    map['mothersName'] = mothersName;
    map['dateOfBirth'] = dateOfBirth;
    map['rollNumber'] = rollNumber;
    map['className'] = className;
    map['classGroup'] = classGroup;
    map['bloodGroup'] = bloodGroup;
    map['studentContact']= studentContact;
    map['familyContact'] = familyContact;
    map['gender'] = gender;
    map['pictureUrl'] = pictureUrl;
    return map;
  }
}



