let selectedRole = "student";

function selectRole(role) {
    selectedRole = role;

    document.getElementById("studentBtn").classList.remove("active");
    document.getElementById("adminBtn").classList.remove("active");
    document.getElementById(role + "Btn").classList.add("active");

    document.getElementById("registerText").style.display =
        role === "admin" ? "none" : "block";
}

document.getElementById("loginForm").addEventListener("submit", async function (event) {
    event.preventDefault();

    const email = document.getElementById("email").value.trim();
    const password = document.getElementById("password").value;

    try {
        const response = await fetch("../backend/auth/login.php", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ role: selectedRole, email, password })
        });
        const data = await response.json();

        if (data.success) {
            alert("Welcome, " + data.user.full_name + "!");
            // TODO: redirect to the dashboard pages once they exist, e.g.:
            // window.location.href = data.user.role === "admin" ? "admin.html" : "student.html";
        } else {
            alert(data.message);
        }
    } catch (error) {
        alert("Could not reach the server. Make sure Apache and MySQL are running.");
    }
});
