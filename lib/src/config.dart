class Config {


  /* Replace your sire url and api keys */

  String url = 'https://orgo.store';
  String consumerKey = 'ck_9bbd0e0cda94236f5803bc5d2cff7e96241b6eed ';
  String consumerSecret = 'cs_812bd57f414ab4eab9eaf412ac6a9d12ea85ec8d ';

  // String url = 'http://example.com';
  // String consumerKey = 'ck_98a6523b4daafd62bf3fabc3108c965887d1da74';
  // String consumerSecret = 'cs_9f6c627a2564a2a5c55ce7037a0a9b65b81636bf';

  String mapApiKey = '';

  // String mapApiKey = "AIzaSyBhXmXtyQu58Urso1yMK3yZHRLgKEsJyIE";

  static Config _singleton = new Config._internal();

  factory Config() {
    return _singleton;
  }

  Config._internal();

  Map<String, dynamic> appConfig = Map<String, dynamic>();

  Config loadFromMap(Map<String, dynamic> map) {
    appConfig.addAll(map);
    return _singleton;
  }

  dynamic get(String key) => appConfig[key];

  bool getBool(String key) => appConfig[key];

  int getInt(String key) => appConfig[key];

  double getDouble(String key) => appConfig[key];

  String getString(String key) => appConfig[key];

  void clear() => appConfig.clear();

  @Deprecated("use updateValue instead")
  void setValue(key, value) => value.runtimeType != appConfig[key].runtimeType
      ? throw ("wrong type")
      : appConfig.update(key, (dynamic) => value);

  void updateValue(String key, dynamic value) {
    if (appConfig[key] != null &&
        value.runtimeType != appConfig[key].runtimeType) {
      throw ("The persistent type of ${appConfig[key].runtimeType} does not match the given type ${value.runtimeType}");
    }
    appConfig.update(key, (dynamic) => value);
  }

  void addValue(String key, dynamic value) =>
      appConfig.putIfAbsent(key, () => value);

  add(Map<String, dynamic> map) => appConfig.addAll(map);

}