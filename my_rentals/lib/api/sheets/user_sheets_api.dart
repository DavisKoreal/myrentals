import 'package:gsheets/gsheets.dart';
import 'package:my_rentals/api/sheets/house_field.dart';

class UserSheetsApi{
  static const _spreadsheetId = "1ujA6mAZijKEJmT_VVXaEwDPcLkKO5dZHlMycIA-CxfA";
  static const _credentials = r'''
  {
  "type": "service_account",
  "project_id": "myrentals-434400",
  "private_key_id": "c179d7c1ec8811af2e71c5837847313a552d819b",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC1/QFFW2tOvCVn\n5/6N9LRpn0G3axXnNDKfAezxqVIRK6migtgz4zXoRtmDOE+cfhcOt1tWbD4za5DX\ntUeh2+EOMznPnZn4v4NGoYhATbqcZmyIZAiPNsRb/f0gmBS1AfqZ0JiZM7rjsn0t\njGQ1WPGaUfjiwEQcrFgUc1itGM4V+ip50bNFBD6tfxQXDw8qHpuvFYieQXOc9Eni\nE+5Xw7ZNtZRBqLU1yJj4QvEHSjSvPBDdLld+6242RE3hk1PDZkW7CPsXVSI57hcm\nwn94rZJtZC/H/a4qzu38/TjR9y/slxd13niskGsKNTRoj1LqB0ofFwHbJu4Nczj8\n/mNX6/PHAgMBAAECggEAMKowTdCteEd9pTR3cJRwLhJlK1waZlIh+z0zlEfX5zmK\nyic9E1r9zlgr0BgdydY56jiD1y9ozq1D9TrHpfO7UeXG3srhIpBr1VZarf9bGHmX\nKj29wDY/+e2IY8/nMaQO1FTgiY84uazAJo71OQLI0KB88n3BeP1pLEbP/rG0YlGo\nt/LKDL+ecMSzIfW++feukDVKDqWtdEHgEpIysPCjkfeimoIyb8O1fSPNd1osfRP+\nv9njXhIR9kbB2rKCuBhlhowqmDdqiyJyd7oUSTD7A/nM2nnf4fdLnWgZgEUlx10Y\n3ADI+vVzrl7M8YcmTA2t/EJbi2uG60EthSNvOkPREQKBgQDiwoUDGQOH6tEYgvsH\nrooQX7r67rmUMSm1rK1x9YsUgAsBIwUmFclmGC8h1uJKnX3ZpVGHatESikwFCTDx\n6h57KpIKHjpjb6pYUi0B2zh2J/vmkwtBYu9bMwtZRqcTg0Jvtmc/sLyFvcJMSzq6\ngv90NbcK9qoXZZSccgrHjhuZGQKBgQDNdIyvPmYS8aupW0zEN+wfzIPCBqesFy2+\n7fq01yar9iQpLrmS3Xikut4HjtXarwgeW6+ZSR9eORlXAhHBl+jGEOKryQ9ApQAh\n1sCkQ1pvCfxlXc8GdMR7czkaCuqWM/h2eYO92+7LMn+gG8Bfno4JNvsHLvErVvw9\nPM0RbbYv3wKBgAi6ylobLWqfHJuf90ANdR06Qj2E0TomRl/LHQZFGKyaXVIW4gzc\nS9uVVMMtvZp3w6+MUL4w24mmL1UGTI8Tn0bIlcSz8zV+yAUMbNUkdmD+GxF+WbGT\nuHk/VtGCCc6TgAxC7miiSi+v5XoAb2tcva7gnoJaiqPJ8lWvgkC6dM+JAoGANgy4\nSg33Wnp7d4VOT7yKgN8TtoJ7r9k1Lqp6rwJ+6PRLFQ52wX1EFMoYSRK5jdtIHnxu\nWLwU5XvN/8bKlwx4r0qX5ytwuMfvnfdaHJyfeOC+pogkQ4WKfxOT7Rb8GeG4NqrH\nDraCPrCdRKioVj9nDGOLbJtb1NQAbbfGFxSuvi8CgYEAyWmkoMVv8WOqiwIaBW6R\nngc/AIJETEMFCclfjlZmhCZmpgaYscvhw6jN/TfnB3pKgp3vw6+E9StU/awa/sY3\ndAJNYdD26fKWqkvZ9lrUS733VHRAIyPoo9fYibYGjyGYA+RxfRIiEGLSKciG6VFc\nP3Yg6f1x7t4zjLkub+Bc/uE=\n-----END PRIVATE KEY-----\n",
  "client_email": "myrentals@myrentals-434400.iam.gserviceaccount.com",
  "client_id": "110234853614634896131",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/myrentals%40myrentals-434400.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}
  ''';

  static final _gsheets = GSheets(_credentials);
  static Worksheet? _userSheet;
  static Future init () async {
    final spreadsheet = await _gsheets.spreadsheet(_spreadsheetId);
    _userSheet = await _getWorkSheet(spreadsheet, title: 'My_Rentals_Sheet1');
    final firstRow = HouseFields.getFields();
  }

  static Future<Worksheet> _getWorkSheet(
      Spreadsheet spreadsheet,{
        required String title,
  }) async {
    try{
      return await spreadsheet.addWorksheet(title);
    }
    catch (e){
      return spreadsheet.worksheetByTitle(title)!;
    }

  }
}