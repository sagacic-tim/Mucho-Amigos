document.addEventListener("DOMContentLoaded", function () {
  const countrySelect = document.querySelector(".country-select");
  const stateSelect = document.querySelector(".state-select");

  // Function to update the states select based on the selected country
  function updateStates() {
    const selectedCountry = countrySelect.value;
    const selectedCountryData = countries.find(c => c.alpha2 === selectedCountry);

    if (selectedCountryData && selectedCountryData.states) {
      stateSelect.innerHTML = '<option value="">Select a state</option>';

      selectedCountryData.states.forEach((state) => {
        const option = document.createElement("option");
        option.value = state.abbr;
        option.text = state.name;
        stateSelect.appendChild(option);
      });
    } else {
      stateSelect.innerHTML = '<option value="">Select a state</option>';
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
  });

  // Load countries data
  let countries;
  fetch('/country_data')
    .then(response => response.json())
    .then(data => {
      countries = data;
    })
    .catch(error => console.error("Error fetching countries:", error));
});