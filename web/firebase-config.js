// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: "AIzaSyAkFFBw82uX8k5h6N0YuCBmEq9hlOuiEKA",
  authDomain: "getawaygo-4f9f4.firebaseapp.com",
  projectId: "getawaygo-4f9f4",
  storageBucket: "getawaygo-4f9f4.appspot.com",
  messagingSenderId: "495440582595",
  appId: "1:495440582595:web:d2fcd46c08db59f295cf76",
  measurementId: "G-GZVRH3H3YM"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const analytics = getAnalytics(app);