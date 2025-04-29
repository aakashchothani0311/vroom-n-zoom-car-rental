document.addEventListener('DOMContentLoaded', function () {
    document.querySelectorAll('.status-toggle').forEach(checkbox => {
        checkbox.addEventListener('change', function () {
			const url = this.dataset.updateUrl;
			const id = this.dataset.id;
            const isActive = this.checked;

			fetch(`${url}/${id}?active=${isActive}`, {
			    method: 'POST',
			    headers: { 'X-Requested-With': 'XMLHttpRequest' }
			})
			.then(res => {
			    if (!res.ok) throw new Error('Update failed');
				return res.text();	
			})
			.then(msg => alert(msg))
			.catch(err => {
				console.log('error in status-toggle', err);
			    alert('Failed to update status');
			    this.checked = !isActive;
			});
        });
    });
});