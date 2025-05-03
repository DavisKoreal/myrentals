import 'package:africas_talking/africas_talking.dart';
// import 'package:http/http.dart' as http;

void sendMessage(String messageToSend, List<String> contactsToSendTo) {
  const apikey = "atsk_e68f8d6a361bcc5e34a10eeff7fd4b97bf52693f96338f265a2e401d3";
  var africasTalking = AfricasTalking("vivaShakuMessageSender", apikey);
  africasTalking.isLive = true;

  // ***Sms***
  // initialize sms; Takes your registered short code or alphanumeric, defaults to AFRICASTKNG
  Sms sms = africasTalking.sms('VIVASHAKU');

  // send sms
  // var response = sms.send(message: messageToSend, to: contactsToSendTo);
  // Future<http.Response> response = sms.send(message: messageToSend, to: contactsToSendTo);
  // response.then((value) => {
  //   print("THIS IS THE RESPONSE FROM SENDING THE MESSAGE $value")
  // }
  // );
  sms.send(message: messageToSend, to: contactsToSendTo);
  // print(response.toString());
  // fetch messages
  // sms.fetchMessages(lastReceivedId: '0');


  // // ***Airtime***
  // // initialize airtime
  // Airtime airtime = africasTalking.airtime();
  //
  // // send airtime; takes a List of AirtimeRecipient
  // airtime.send([AirtimeRecipient(amount: 20, phoneNo: '+XXXXXXXXXXXX', currency: 'KES')]);
  //
  //
  // // ***Voice call***
  // // initialize voice call; takes  Your Africa’s Talking phone number
  // VoiceCall voiceCall = africasTalking.voiceCall('+XXXXXXXXXXXX');
  //
  // // make a call; takes a list of phone numbers
  // voiceCall.call(to: ['+XXXXXXXXXXXX']);
}
