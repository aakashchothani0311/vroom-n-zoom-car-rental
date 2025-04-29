function updateToDateLimits() {
    const fromDateInput = document.getElementById('fromDate');
    const toDateInput = document.getElementById('toDate');

    const fromDate = new Date(fromDateInput.value);

    if (fromDate) {
        toDateInput.min = fromDateInput.value;

        const maxToDate = new Date(fromDate);
        maxToDate.setDate(fromDate.getDate() + 15);
        toDateInput.max = maxToDate.toISOString().split('T')[0];
		toDateInput.disabled = false;
		toDateInput.value = '';
    } else {
        toDateInput.min = '';
        toDateInput.max = '';
    }

    calculateBookingDetails();
}

function calculateBookingDetails() {
    const fromDate = document.getElementById('fromDate').value;
    const toDate = document.getElementById('toDate').value;
    const rate = parseFloat(document.getElementById('rate').textContent);

    if (fromDate && toDate) {
        const from = new Date(fromDate);
        const to = new Date(toDate);

        const timeDiff = to - from;
        const days = Math.ceil(timeDiff / (1000 * 60 * 60 * 24)) + 1;

        if (days > 0) {
            document.getElementById('day-count').textContent = days;
            document.getElementById('total-amount').textContent = (rate * days * 24).toFixed(2);
        } else {
            document.getElementById('day-count').textContent = '';
            document.getElementById('total-amount').textContent = '';
        }
    } else {
		document.getElementById('day-count').textContent = '';
		document.getElementById('total-amount').textContent = '';		
	}
}

document.addEventListener('DOMContentLoaded', () => {
    document.getElementById('fromDate').addEventListener('change', updateToDateLimits);
    document.getElementById('toDate').addEventListener('change', calculateBookingDetails);
});
