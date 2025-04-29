document.addEventListener('DOMContentLoaded', function () {
    const countdownEl = document.getElementById('countdown');
    const redirectUrl = countdownEl?.getAttribute('data-url');
    let timeLeft = 5;

    if (countdownEl && redirectUrl) {
        const timer = setInterval(function () {
            timeLeft--;
            countdownEl.textContent = timeLeft;

            if (timeLeft <= 0) {
                clearInterval(timer);
                window.location.href = redirectUrl;
            }
        }, 1000);
    }
});
