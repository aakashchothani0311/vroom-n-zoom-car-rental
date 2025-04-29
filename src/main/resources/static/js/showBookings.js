function cancelBooking(url, buttonEl) {
    if (!confirm('Are you sure you want to cancel this booking?')) return;

    fetch(url, {
		method: 'POST',
        headers: { 'X-Requested-With': 'XMLHttpRequest' }
    }).then(res => {
		console.log('res', res);
        if (res.ok)
			return res.json();
		else
            alert('Could not cancel booking. Please try again.');
	}).then(data => {
        const card = buttonEl.closest('.booking-card');
        const badge = card.querySelector('.status-badge');
        badge.textContent = 'cancelled';
        badge.className = 'status-badge cancelled';
        buttonEl.remove();
		
		const formattedDate = new Date(data.cancelledDate).toLocaleDateString('en-US', {
            year: 'numeric',
            month: 'long',
            day: 'numeric'
        });

        const cancelledInfo = document.createElement('p');
        cancelledInfo.innerHTML = `<strong>Cancelled On:</strong> ${formattedDate}`;
        cancelledInfo.className = 'cancelled-date';

        const detailsSection = card.querySelector('.booking-details:last-of-type');
        detailsSection.appendChild(cancelledInfo);
    }).catch(err => {
        console.error(err);
        alert('Something went wrong.');
    });
}

document.querySelectorAll('.btn-cancel').forEach(button => {
	console.log('button', button);
    button.addEventListener('click', function() {
        const cancelUrl = this.dataset.cancelUrl;
        cancelBooking(cancelUrl, this);
    });
});
