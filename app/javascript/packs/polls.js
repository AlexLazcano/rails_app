document.addEventListener("turbo:load", function() {
  const optionsDiv = document.getElementById("options");
  const addOptionButton = document.getElementById("add_option");

  if (addOptionButton) {
    addOptionButton.addEventListener("click", function(e) {
      e.preventDefault();

      // Determine the index for the new option
      const optionIndex = optionsDiv.querySelectorAll(".flex").length;

      // Create a new option element
      const newOption = document.createElement("div");
      newOption.className = "flex items-center space-x-4";
      newOption.innerHTML = `
        <input type="text" name="poll[options_attributes][${optionIndex}][text]" placeholder="Option text" class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500">
        <button type="button" class="text-red-500 font-medium remove_option px-4 py-2 border border-red-500 rounded-lg hover:bg-red-100 focus:outline-none focus:ring-2 focus:ring-red-500">Remove</button>
        <input type="hidden" name="poll[options_attributes][${optionIndex}][_destroy]" value="false">
      `;

      // Append the new option to the options container
      optionsDiv.appendChild(newOption);
    });

    optionsDiv.addEventListener("click", function(e) {
      if (e.target && e.target.classList.contains("remove_option")) {
        e.preventDefault();
        const optionDiv = e.target.parentNode;
        // Mark for destruction
        const hiddenField = optionDiv.querySelector('input[type="hidden"]');
        if (hiddenField) {
          hiddenField.value = "true";
        }
        // Hide the option
        optionDiv.style.display = 'none';
      }
    });
  }
});
