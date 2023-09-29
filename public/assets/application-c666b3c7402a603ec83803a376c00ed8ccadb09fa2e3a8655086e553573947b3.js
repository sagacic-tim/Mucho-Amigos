console.log("Script loaded!");
document.addEventListener("DOMContentLoaded", function () {
  try {
  console.log("DOM Content Loaded event fired!");
  const countrySelect = document.querySelector(".country-select");
  const stateSelect = document.querySelector(".state-select");

  // Access country data from your view or controller
  console.log("Inside DOM Content Loaded event listener");
  const countries = null;
  console.log('Is countries populated: ', countries)
  countries.forEach(country => {
    console.log(country.alpha2);
    console.log("Country Codes in countries array:");
  });

  // Function to update the states select based on the selected country
  function updateStates() {
    const selectedCountry = countrySelect.value;
    const country = countries.find((c) => c.alpha2 === selectedCountry);

    if (country && country.states) {
      stateSelect.innerHTML = '<option value="">Select a State</option>';

      console.log("Select a State placeholder option added:");
      country.states.forEach((state) => {
        const option = document.createElement("option");
        option.value = state.abbr;
        option.text = state.name;
        stateSelect.appendChild(option);
      });
      console.log("States for Country populated:");
    } else {
      stateSelect.innerHTML = '<option value="">Select a State</option>';
    }
  }

  // Initial population of states based on the selected country
  updateStates();
  
  // Log that the initial updateStates is called
  console.log("Initial updateStates() called.");

  // Listen for changes in the selected country
  countrySelect.addEventListener("change", function () {
    // Log that the change event listener is triggered
    console.log("Country selection changed.");

    // Call updateStates again when the country selection changes
    updateStates();
    console.log("States Dropdown Updated.");
  });
  } catch (error) {
    console.error("JavaScript Error:", error);
  }
});

