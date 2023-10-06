document.addEventListener("DOMContentLoaded", function () {
  const countrySelect = document.querySelector(".country-select");
  const stateSelect = document.querySelector(".state-select");

  // Function to update the states select based on the selected country
  function updateStates(countries) {
    const selectedCountry = countrySelect.value;
    const country = countries.find((c) => c.alpha2 === selectedCountry);

    if (country && country.states) {
      stateSelect.innerHTML = '<option value="">Select a State</option>';

      country.states.forEach((state) => {
        const option = document.createElement("option");
        option.value = state.abbr;
        option.text = state.name;
        stateSelect.appendChild(option);
      });
    } else {
      stateSelect.innerHTML = '<option value="">Select a State</option>';
    }
  }

  // Make an AJAX request to fetch countries data
  fetch('/country_data')
    .then(response => response.json())
    .then(countries => {
      try {
        console.log('Countries List: ', countries);

        // Check if countries is an array before updating states
        if (Array.isArray(countries)) {
          // Initial population of states based on the selected country
          updateStates(countries);

          // Log that the initial updateStates is called
          console.log("Initial updateStates() called.");

          // Listen for changes in the selected country
          countrySelect.addEventListener("change", function () {
            // Log that the change event listener is triggered
            console.log("Country selection changed.");

            // Call updateStates again when the country selection changes
            updateStates(countries);
          });
        } else {
          console.error("Error: countries is not an array");
        }
      } catch (error) {
        console.error("JavaScript Error:", error);
      }
    })
    .catch(error => console.error("Error fetching countries:", error));
});
