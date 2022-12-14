import 'package:duos_ui/providers/disposable_provider.dart';

class ProfileProvider extends DisposableProvider {
  String _firstName = '';
  String _lastName = '';
  String _email = '';
  String _gender = '';
  String _bio = '';
  String _hobbies = '';
  String _languages = '';
  String _datingPref = '';
  String _dateOfBirth = '';
  String _location = '';
  String _profilePicturePath = '';
  String _profilePictureURL = '';
  List<String> _categories = [];
  bool _doneSetup = true;

  String get firstName => _firstName;
  String get lastName => _lastName;
  String get email => _email;
  String get gender => _gender;
  String get bio => _bio;
  String get hobbies => _hobbies;
  String get languages => _languages;
  String get datingPref => _datingPref;
  String get dob => _dateOfBirth;
  String get location => _location;
  String get profilePicPath => _profilePicturePath;
  String get profilePicURL => _profilePictureURL;
  List<String> get categories => _categories;
  bool get doneSetup => _doneSetup;

  void setFirstName(String s) {
    _firstName = s;
    notifyListeners();
  }

  void setLastName(String s) {
    _lastName = s;
    notifyListeners();
  }

  void setEmail(String s) {
    _email = s;
    notifyListeners();
  }

  void setGender(String s) {
    _gender = s;
    notifyListeners();
  }

  void setBio(String s) {
    _bio = s;
    notifyListeners();
  }

  void setHobbies(String s) {
    _hobbies = s;
    notifyListeners();
  }

  void setLanguages(String s) {
    _languages = s;
    notifyListeners();
  }

  void setDatingPref(String s) {
    _datingPref = s;
    notifyListeners();
  }

  void setDateofBirth(String s) {
    _dateOfBirth = s;
    notifyListeners();
  }

  void setLocation(String s) {
    _location = s;
    notifyListeners();
  }

  void setProfilePicPath(String s) {
    _profilePicturePath = s;
    notifyListeners();
  }

  void setProfilePicURL(String s) {
    _profilePictureURL = s;
    notifyListeners();
  }

  void setCategories(List<String> categories) {
    _categories = categories;
    notifyListeners();
  }

  void setSetupStatus(bool setup) {
    _doneSetup = setup;
    notifyListeners();
  }

  @override
  void disposeValues() {
    _firstName = '';
    _lastName = '';
    _email = '';
    _gender = '';
    _bio = '';
    _hobbies = '';
    _languages = '';
    _datingPref = '';
    _dateOfBirth = '';
    _location = '';
    _profilePicturePath = '';
    _profilePictureURL = '';
    _categories = [];
    _doneSetup = true;
  }
}
