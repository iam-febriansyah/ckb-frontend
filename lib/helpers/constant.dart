class Constant {
  static String appName = "Warehouse";
  static String yourCompany = "Warehouse";
  static String domainIP = "192.168.36.160";
  static String port = "2006";
  static String mainUrl = port == '' ? domainIP : "$domainIP:$port";
  static String httpMainUrl = "http://$mainUrl";
}
