document.addEventListener("DOMContentLoaded", function() {
    const formTitle = document.getElementById("form-title");
    const authForm = document.getElementById("auth-form");
    const toggleLink = document.getElementById("toggle-link");
    const submitButton = document.getElementById("submit-button");

    // Toggle between Login and Signup form
    toggleLink.addEventListener("click", function(event) {
        event.preventDefault();

        const isSignup = formTitle.textContent === "[ Login ]";
        formTitle.textContent = isSignup ? "[ Sign Up ]" : "[ Login ]";
        submitButton.textContent = isSignup ? "[ Sign Up ]" : "[ Login ]";
        toggleLink.textContent = isSignup ? "Already have an account? [ Login ]" : "Don’t have an account? [ Sign Up ]";

        // Show or hide signup-only fields
        document.querySelectorAll(".signup-only").forEach(element => {
            element.style.display = isSignup ? "block" : "none";
        });
    });

    // Form submission handling
    authForm.addEventListener("submit", function(event) {
        event.preventDefault();

        const email = document.getElementById("email").value;
        const password = document.getElementById("password").value;

        if (formTitle.textContent === "[ Sign Up ]") {
            const firstName = document.getElementById("first-name").value;
            const lastName = document.getElementById("last-name").value;
            console.log("Signup:", { firstName, lastName, email, password });
        } else {
            console.log("Login:", { email, password });
        }

        // Simulate successful login/signup and redirect to homepage
        window.location.href = "index.html"; // Redirect to main page
    });
});