/// Content Type Path
enum ContentTypeEnum {
  home("Anasayfa"),
  getCampains("GetCampains"),
  getJobAdvertisements("GetJobAdvertisements"),
  getThesisConsultation("GetThesisConsultation"),
  getDraws("GetDraws");

  final String value;
  const ContentTypeEnum(this.value);

  String withQuery(String query) {
    return "$value/$query";
  }
}
