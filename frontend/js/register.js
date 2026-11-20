document.getElementById("registerForm").addEventListener("submit", async function (event) {
    event.preventDefault();

    const accountType = document.getElementById("accountType").value;
    const fullName = document.getElementById("fullName").value.trim();
    const email = document.getElementById("email").value.trim();
    const password = document.getElementById("password").value;
    const confirmPassword = document.getElementById("confirmPassword").value;

    if (accountType === "admin") {
        alert("Admin accounts can only be created by the system administrator.");
        return;
    }

    if (password !== confirmPassword) {
        alert("Passwords do not match!");
        return;
    }

    try {
        const response = await fetch("../backend/auth/register.php", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ accountType, fullName, email, password, confirmPassword })
        });
        const data = await response.json();
        alert(data.message);

        if (data.success) {
            window.location.href = "index.html";
        }
    } catch (error) {
        alert("Could not reach the server. Make sure Apache and MySQL are running.");
    }
});
