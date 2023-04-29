
class UserDetailsModel {
  String? userGuId;
  String? docPatGuId;
  String? docPatUserId;
  String? email;
  String? countryPhnCode;
  String? dateOfBirth;
  int? age;
  String? placeOfBirth;
  String? countryCode;
  String? country;
  String? phoneNumber;
  String? firstName;
  String? lastName;
  String? middleName;
  String? gender;
  String? documentTypeId;
  String? documentNumber;
  String? docCity;
  String? docState;
  String? docCountry;
  String? timeZone;
  String? isAppointmentBookedAlready;
  String? status;
  String? profileStatus;
  String? calendarStatus;
  String? nin;
  String? ssn;
  String? moduleList;
  AttachmentDTO? attachmentDTO;
  String? kdate;

  UserDetailsModel(
      {this.userGuId,
        this.docPatGuId,
        this.docPatUserId,
        this.email,
        this.countryPhnCode,
        this.dateOfBirth,
        this.age,
        this.placeOfBirth,
        this.countryCode,
        this.country,
        this.phoneNumber,
        this.firstName,
        this.lastName,
        this.middleName,
        this.gender,
        this.documentTypeId,
        this.documentNumber,
        this.docCity,
        this.docState,
        this.docCountry,
        this.timeZone,
        this.isAppointmentBookedAlready,
        this.status,
        this.profileStatus,
        this.calendarStatus,
        this.nin,
        this.ssn,
        this.moduleList,
        this.attachmentDTO,
        this.kdate});

  UserDetailsModel.fromJson(Map<String, dynamic> json) {
    userGuId = json['userGuId'];
    docPatGuId = json['docPatGuId'];
    docPatUserId = json['docPatUserId'];
    email = json['email'];
    countryPhnCode = json['countryPhnCode'];
    dateOfBirth = json['dateOfBirth'];
    age = json['age'];
    placeOfBirth = json['placeOfBirth'];
    countryCode = json['countryCode'];
    country = json['country'];
    phoneNumber = json['phoneNumber'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    middleName = json['middleName'];
    gender = json['gender'];
    documentTypeId = json['documentTypeId'];
    documentNumber = json['documentNumber'];
    docCity = json['docCity'];
    docState = json['docState'];
    docCountry = json['docCountry'];
    timeZone = json['timeZone'];
    isAppointmentBookedAlready = json['isAppointmentBookedAlready'];
    status = json['status'];
    profileStatus = json['profileStatus'];
    calendarStatus = json['calendarStatus'];
    nin = json['nin'];
    ssn = json['ssn'];
    moduleList = json['moduleList'];
    attachmentDTO = json['attachmentDTO'] != null
        ? new AttachmentDTO.fromJson(json['attachmentDTO'])
        : null;
    kdate = json['kdate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userGuId'] = this.userGuId;
    data['docPatGuId'] = this.docPatGuId;
    data['docPatUserId'] = this.docPatUserId;
    data['email'] = this.email;
    data['countryPhnCode'] = this.countryPhnCode;
    data['dateOfBirth'] = this.dateOfBirth;
    data['age'] = this.age;
    data['placeOfBirth'] = this.placeOfBirth;
    data['countryCode'] = this.countryCode;
    data['country'] = this.country;
    data['phoneNumber'] = this.phoneNumber;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['middleName'] = this.middleName;
    data['gender'] = this.gender;
    data['documentTypeId'] = this.documentTypeId;
    data['documentNumber'] = this.documentNumber;
    data['docCity'] = this.docCity;
    data['docState'] = this.docState;
    data['docCountry'] = this.docCountry;
    data['timeZone'] = this.timeZone;
    data['isAppointmentBookedAlready'] = this.isAppointmentBookedAlready;
    data['status'] = this.status;
    data['profileStatus'] = this.profileStatus;
    data['calendarStatus'] = this.calendarStatus;
    data['nin'] = this.nin;
    data['ssn'] = this.ssn;
    data['moduleList'] = this.moduleList;
    if (this.attachmentDTO != null) {
      data['attachmentDTO'] = this.attachmentDTO!.toJson();
    }
    data['kdate'] = this.kdate;
    return data;
  }
}

class AttachmentDTO {
  String? attachmentGuId;
  String? originalName;
  String? attachmentLocation;
  String? attachmentType;
  String? typeGuId;
  String? documentType;

  AttachmentDTO(
      {this.attachmentGuId,
        this.originalName,
        this.attachmentLocation,
        this.attachmentType,
        this.typeGuId,
        this.documentType});

  AttachmentDTO.fromJson(Map<String, dynamic> json) {
    attachmentGuId = json['attachmentGuId'];
    originalName = json['originalName'];
    attachmentLocation = json['attachmentLocation'];
    attachmentType = json['attachmentType'];
    typeGuId = json['typeGuId'];
    documentType = json['documentType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attachmentGuId'] = this.attachmentGuId;
    data['originalName'] = this.originalName;
    data['attachmentLocation'] = this.attachmentLocation;
    data['attachmentType'] = this.attachmentType;
    data['typeGuId'] = this.typeGuId;
    data['documentType'] = this.documentType;
    return data;
  }
}
