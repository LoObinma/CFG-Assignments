// 2.1 Array methods 

// array of CFGdegree streams
let streams = ["Web Development", "Cyber Security", "Data Analytics"];

// unshift(): adds one or more elements to the beginning of an array and returns the new length
streams.unshift("AI & Machine Learning"); // adds at start
console.log("After unshift:", streams);

// shift(): removes the first element from an array and returns that element
let removedStream = streams.shift(); // removes "AI & Machine Learning"
console.log("Removed stream:", removedStream);
console.log("Streams now:", streams);

// split(): splits a string into an array of substrings based on a separator
let streamString = "Networking,Cloud Computing,UX Design";
let streamArray = streamString.split(","); // split by comma // store array in streamArray
console.log("Split streams:", streamArray);

// 2.2 Object methods 

// an Object is a collection of related properties and/ or methods
// a Method is a function that belongs to an object
// Object Methods are actions that can be performed on objects.

const programmingLanguages = {
  languages: ["JavaScript", "Python", "Java", "C++", "SQL"],

  // method to list languages
  listLanguages() {
    console.log("Available languages:", this.languages.join(", "));
  },

  // method to remove the last language
  removeLastLanguage() {
    const removed = this.languages.pop();
    console.log(removed, "was removed");
  },
};

// call methods
programmingLanguages.listLanguages();
programmingLanguages.removeLastLanguage();

// 2.3 DOM events

const hoverText = document.getElementById("hover-text");
const clickButton = document.getElementById("click-button");
const inputBox = document.getElementById("input-box");

// onmouseover event occurs when the mouse pointer hovers over an element
hoverText.addEventListener("mouseover", () => {
  hoverText.style.color = "#DA70D6";
  console.log("Mouse is hovering over text");
});

// onclick event occurs when user clicks the element (button)
clickButton.addEventListener("click", () => {
  alert("Button has been clicked");
});

// oninput event occurs when user types/edits in the input field
inputBox.addEventListener("input", () => {
  console.log("Input changed:", inputBox.value);
});
