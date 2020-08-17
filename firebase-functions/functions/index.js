const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

var yearOccurrence = [];

for (let index = 0; index < 12; index++) {
    
    var dtNow = new Date(2020, index); // replace this for the month/date of your choosing
    var dtFirst = new Date(dtNow.getFullYear(), dtNow.getMonth(), 1);  // first date in a month
    var dtLast = new Date(dtNow.getFullYear(), dtNow.getMonth() + 1, 0); // last date in a month
    
    // we need to keep track of weekday occurrence in a month, a map looks suitable for this
    var dayOccurrence = {
      1 : 0, 
      2 : 0, 
      3 : 0, 
      4 : 0, 
      5 : 0, 
      6 : 0, 
      7 : 0  
    }
    
    var dtLoop = new Date(dtFirst); // temporary date, used for looping
    while(dtLoop <= dtLast){
      //  getDay() method returns the day of the week, from 0(Sunday) to 6(Saturday) 
      switch(dtLoop.getDay()) {
        case 0:
          dayOccurrence[7]++; break;
        case 1:
          dayOccurrence[1]++; break;
        case 2:
          dayOccurrence[2]++; break;
        case 3:
          dayOccurrence[3]++; break;
        case 4:
          dayOccurrence[4]++; break;
        case 5:
          dayOccurrence[5]++; break;
        case 6:
          dayOccurrence[6]++; break; 
        default:
          console.log("this should not happen");
       }
       dtLoop.setDate(dtLoop.getDate() + 1);
    }
    
    // log the results
    // var keys = Object.keys(dayOccurrence);
    // keys.forEach(key=>{
    //   console.log(key + ' : ' + dayOccurrence[key]);
    // });

    yearOccurrence.push(dayOccurrence);

}



exports.timetableCalendar = functions.firestore.document('/timetables/{id}').onCreate((snap, context) => {

    const id = context.params.id;
    const data = snap.data();
    console.log(data.Subject);
    console.log(data.Day);
    const calendar = admin.firestore().collection('/calendar2020').doc(data.Subject);
    
    calendar.get().then( documentSnaphot => {
      if(documentSnaphot.exists){
        console.log(documentSnaphot.get('jan'));
        return calendar.update({
          year: data.Year,
          major: data.Major,
          jan: parseInt(documentSnaphot.get('jan')) + parseInt(yearOccurrence[0][data.Day]),
          feb: parseInt(documentSnaphot.get('jan')) + parseInt(yearOccurrence[1][data.Day]),
          mar: parseInt(documentSnaphot.get('jan')) + parseInt(yearOccurrence[2][data.Day]),
          apr: parseInt(documentSnaphot.get('jan')) + parseInt(yearOccurrence[3][data.Day]),
          may: parseInt(documentSnaphot.get('jan')) + parseInt(yearOccurrence[4][data.Day]),
          jun: parseInt(documentSnaphot.get('jan')) + parseInt(yearOccurrence[5][data.Day]),
          jul: parseInt(documentSnaphot.get('jan')) + parseInt(yearOccurrence[6][data.Day]),
          aug: parseInt(documentSnaphot.get('jan')) + parseInt(yearOccurrence[7][data.Day]),
          sep: parseInt(documentSnaphot.get('jan')) + parseInt(yearOccurrence[8][data.Day]),
          oct: parseInt(documentSnaphot.get('jan')) + parseInt(yearOccurrence[9][data.Day]),
          nov: parseInt(documentSnaphot.get('jan')) + parseInt(yearOccurrence[10][data.Day]),
          dec: parseInt(documentSnaphot.get('jan')) + parseInt(yearOccurrence[11][data.Day]),
        });
      }
      else {    

        return calendar.create({
          year: data.Year,
          major: data.Major,
          jan: yearOccurrence[0][data.Day],
          feb: yearOccurrence[1][data.Day],
          mar: yearOccurrence[2][data.Day],
          apr: yearOccurrence[3][data.Day],
          may: yearOccurrence[4][data.Day],
          jun: yearOccurrence[5][data.Day],
          jul: yearOccurrence[6][data.Day],
          aug: yearOccurrence[7][data.Day],
          sep: yearOccurrence[8][data.Day],
          oct: yearOccurrence[9][data.Day],
          nov: yearOccurrence[10][data.Day],
          dec: yearOccurrence[11][data.Day],
      });}

      
    }).catch(() => {


    });


}
);
