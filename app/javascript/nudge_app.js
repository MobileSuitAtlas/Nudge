// Nudge - Gentle Habit Builder JavaScript

// Request Notification Permission
window.requestNotificationPermission = function() {
    if (!('Notification' in window)) {
        alert('Sorry, your browser does not support notifications.');
        return;
    }

    Notification.requestPermission().then(permission => {
        if (permission === 'granted') {
            localStorage.setItem('nudge_notifications', 'enabled');
            
            const notifyBtn = document.getElementById('enable-notifications');
            if (notifyBtn) {
                notifyBtn.innerHTML = '✓ Nudges Enabled';
                notifyBtn.classList.remove('btn-outline-primary');
                notifyBtn.classList.add('btn-success');
                notifyBtn.disabled = true;
            }
            
            alert('Great! You\'ll receive gentle nudges when it\'s time for your habits. No pressure - they\'re just friendly reminders 💜');
        }
    });
};

// Function to trigger a gentle nudge notification
window.triggerNudge = function(title, body, habitId) {
    if (Notification.permission !== 'granted') return;

    const notification = new Notification(title, {
        body: body,
        icon: '/icon.png',
        badge: '/icon.png',
        tag: `habit-${habitId}`,
        requireInteraction: false,
        silent: true
    });

    notification.onclick = function() {
        window.focus();
        window.location.href = `/habits/${habitId}`;
        this.close();
    };

    setTimeout(() => notification.close(), 10000);
};

// Hide notification button if already enabled
if (localStorage.getItem('nudge_notifications') === 'enabled') {
    const notifyBtn = document.getElementById('enable-notifications');
    if (notifyBtn) {
        notifyBtn.style.display = 'none';
    }
}
