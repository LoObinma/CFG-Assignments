// Date
// create current formated date function
function formatDate() {
  // create a new Date object representing the current date and time
  const date = new Date();

  // arrays to convert numeric day and month values into names
  const days = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
  ];
  const months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];

  // get the day of the week as a name
  const dayName = days[date.getDay()];

  // get the day of the month
  const day = date.getDate();

  // get the name of the month
  const monthName = months[date.getMonth()];

  // function to determine suffix for the day
  const suffix = (d) => {
    // 4th to 20th always end in "th"
    if (d > 3 && d < 21) return "th";
    // otherwise, use the last digit to determine suffix
    switch (d % 10) {
      case 1:
        return "st";
      case 2:
        return "nd";
      case 3:
        return "rd";
      default:
        return "th";
    }
  };

  // construct formatted date string
  const formattedDate = `${dayName} ${day}${suffix(day)} ${monthName}`;

  // create variable called dateElement and set it's value to HTML element current-date
  const dateElement = document.getElementById("current-date");
  // assign the text content of dateElement to formattedDate
  dateElement.textContent = formattedDate;

  // set style of dateElement
  dateElement.style.textAlign = "center";
  dateElement.style.fontFamily = "Inclusive Sans";
}

// Random quote generator
// array of inspirational quotes
const inspirationalQuotes = [
  "“Be yourself; everyone else is already taken.” - Oscar wilde",
  "“Imperfection is beauty, madness is genius and it's better to be absolutely ridiculous than absolutely boring.” - Marilyn Monroe",
  "“It is never too late to be what you might have been.” - George Eliot",
  "“Everything you can imagine is real.” - Pablo Picasso",
  "“Still, I rise.” - Maya Angelou",
  "“Nothing is impossible, the word itself says 'I'm possible'!” ― Audrey Hepburn",
  "“Our lives begin to end the day we become silent about things that matter.” - Martin Luther King Jr.",
];

// creat function to get a random quote
function getRandomQuote() {
  const index = Math.floor(Math.random() * inspirationalQuotes.length);
  return inspirationalQuotes[index];
}

// function to display the quote
function generateQuote() {
  const displayQuote = document.getElementById("inspirational-quote");
  displayQuote.textContent = getRandomQuote();
  displayQuote.style.textAlign = "center";
}

// select all theme-buttons buttons in HTML document using querySelectorAll.
// assign the value of themeButtons to all theme-buttond buttons
const themeButtons = document.querySelectorAll(".theme-buttons button");

// setting theme background
const themeBackgrounds = {
  theme1: "Images/theme1.jpeg",
  theme2: "Images/theme2.jpeg",
  theme3: "Images/theme3.jpeg",
};

// set theme colours
const themeColors = {
  theme1: "#da90a9",
  theme2: "#a37dff",
  theme3: "#d9bacb",
};

// attach an event listerner to each button
themeButtons.forEach((button) => {
  button.addEventListener("click", () => {
    const selectedTheme = button.dataset.theme; // get theme of clicked button from the data-set (data-theme)
    document.body.style.backgroundImage = `url('${themeBackgrounds[selectedTheme]}')`; // set background to selected theme
    //Change current date colour depending on selected theme
    const dateElement = document.getElementById("current-date");
    dateElement.style.color = themeColors[selectedTheme];
  });
});

// Apply default theme
const defaultTheme = "theme1";
document.body.style.backgroundImage = `url('${themeBackgrounds[defaultTheme]}')`;

const dateElement = document.getElementById("current-date");
dateElement.style.color = themeColors[defaultTheme];

// Mood selection
const moodButtons = document.querySelectorAll(".mood-buttons button");
const moodFeedback = document.getElementById("mood-feedback");

let userMood = "";
let moodSelected = false;

// display user-mood feedback when mood button is selected
moodButtons.forEach((button) => {
  button.addEventListener("click", () => {
    userMood = button.dataset.mood;
    moodSelected = true; // user has selected a mood
    moodFeedback.style.textAlign = "center";
    if (userMood === "happy") {
      moodFeedback.textContent = "I'm happy you're happy!";
    } else if (userMood === "indifferent") {
      moodFeedback.textContent = "Could be worse!";
    } else if (userMood === "sad") {
      moodFeedback.textContent = "Let's turn that frown upside-down!";
    }
  });
});

// Check of habits
const habitItems = document.querySelectorAll(".habit-content li");

// when habit is clicked apply line-through
habitItems.forEach((li) => {
  li.addEventListener("click", () => {
    if (li.style.textDecoration === "line-through") {
      li.style.textDecoration = "none"; // remove line-through when clicked again
    } else {
      li.style.textDecoration = "line-through"; // add line-through
    }
  });
});

// Finish day
const finishDay = document.getElementById("finish-day");

// create function to check the day's status and give feedback
function finishDayCheck() {
  // Check if all habits are completed
  const allCompleted = [...habitItems].every(
    (li) => li.style.textDecoration === "line-through"
  );

  // mood not selected
  if (!moodSelected) {
    alert("Please select your mood");
    return; // exit early
  }

  // create alerts based on mood and habit completion
  if (userMood !== "happy" && allCompleted) {
    alert(
      "Well done for completing all your tasks, that should put you in a better mood!"
    );
  } else if (userMood === "happy" && allCompleted) {
    alert("You've had an excellent day, keep up the great work!");
  } else if (userMood !== "happy" && !allCompleted) {
    alert(
      "It’s okay if things didn’t go as planned today. Tomorrow is a fresh start!"
    );
  } else if (userMood === "happy" && !allCompleted) {
    alert(
      "You’re feeling happy today! Keep that energy going and try to finish your habits tomorrow!"
    );
  }
  console.log("All habits completed:", allCompleted);

  // Reset mood and habit selection
  moodSelected = false;
  userMood = "";
  moodFeedback.textContent = "";
  habitItems.forEach((li) => (li.style.textDecoration = "none"));
}

// Attach the event listener to the finish-day button
finishDay.addEventListener("click", finishDayCheck);

// Run current date and random quote functions when page loads
window.onload = () => {
  formatDate();
  generateQuote();
};
