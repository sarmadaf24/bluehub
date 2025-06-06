"""Celery beat configuration for loyalty broadcasts."""
from celery.schedules import crontab

beat_schedule = {
    "loyalty-broadcast-daily": {
        "task": "vpn_bot.loyalty.tasks.broadcast_loyalty_messages",
        "schedule": crontab(hour=9, minute=0),
    }
}
