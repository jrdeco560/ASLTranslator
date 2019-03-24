var config = {
    apiKey: "AlzaSyC9VFd87JtcxQLsvNDR8gsRRVz-IU912A",
    authDomain: "aslvisionproject.firebaseapp.com",
    databaseURL: "https://aslvisionproject.firebaseio.com",
    projectId: "aslvisionproject",
    storageBucket: "aslvisionproject.appspot.com",
    messagingSenderId: "215744391744"
  };
  firebase.initializeApp(config);
  
  var db = firebase.firestore();


  db.collection("ASLTranslator").get()
    .then(function(querySnapshot) {
        querySnapshot.forEach(function(doc) {
            // doc.data() is never undefined for query doc snapshots
            content = doc.data().letter;
            console.log(content);
           document.getElementById("ex-table").append(content + ", ")
        });
    })
    .catch(function(error) {
        console.log("Error getting documents: ", error);
    });