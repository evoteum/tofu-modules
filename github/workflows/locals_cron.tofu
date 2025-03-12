locals {
  # Lookup table to convert common cron expressions to English.
  # This is a bodge, but is currently better than building a custom Tofu provider to do it properly.
  # Such a provider could use https://github.com/lnquy/cron
  cron_schedules = {
    # Every X Minutes
    "*/1 * * * *"  = "Every minute"
    "*/5 * * * *"  = "Every 5 minutes"
    "*/10 * * * *" = "Every 10 minutes"
    "*/15 * * * *" = "Every 15 minutes"
    "*/30 * * * *" = "Every 30 minutes"

    # Every X Hours
    "0 * * * *"    = "Every hour"
    "0 */2 * * *"  = "Every 2 hours"
    "0 */3 * * *"  = "Every 3 hours"
    "0 */4 * * *"  = "Every 4 hours"
    "0 */6 * * *"  = "Every 6 hours"
    "0 */12 * * *" = "Every 12 hours"

    # **Daily Schedules - Midnight Variants**
    "0 0 * * *" = "Every day at midnight"
    "0 1 * * *" = "Every day at 1 AM"
    "0 2 * * *" = "Every day at 2 AM"
    "0 3 * * *" = "Every day at 3 AM"
    "0 4 * * *" = "Every day at 4 AM"
    "0 5 * * *" = "Every day at 5 AM"

    # **Daily Schedules - Morning**
    "0 6 * * *"  = "Every day at 6 AM (early morning routine)"
    "0 7 * * *"  = "Every day at 7 AM"
    "0 8 * * *"  = "Every day at 8 AM (start of business hours)"
    "0 9 * * *"  = "Every day at 9 AM"
    "0 10 * * *" = "Every day at 10 AM"
    "0 11 * * *" = "Every day at 11 AM"

    # **Daily Schedules - Afternoon**
    "0 12 * * *" = "Every day at 12 PM (noon)"
    "0 13 * * *" = "Every day at 1 PM"
    "0 14 * * *" = "Every day at 2 PM"
    "0 15 * * *" = "Every day at 3 PM"
    "0 16 * * *" = "Every day at 4 PM"

    # **Daily Schedules - Evening**
    "0 17 * * *" = "Every day at 5 PM (end of business hours)"
    "0 18 * * *" = "Every day at 6 PM"
    "0 19 * * *" = "Every day at 7 PM"
    "0 20 * * *" = "Every day at 8 PM"
    "0 21 * * *" = "Every day at 9 PM"
    "0 22 * * *" = "Every day at 10 PM"
    "0 23 * * *" = "Every day at 11 PM"

    # **Special Daily Schedules**
    "0 0,12 * * *"    = "Twice a day at midnight and noon"
    "0 6,18 * * *"    = "Twice a day at 6 AM and 6 PM"
    "0 9,17 * * *"    = "Twice a day at 9 AM and 5 PM (work hours start and end)"
    "0 8,12,17 * * *" = "Three times a day at 8 AM, 12 PM, and 5 PM"
    "0 5-7 * * *"     = "Every day between 5 AM and 7 AM"
    "0 9-17 * * *"    = "Every hour from 9 AM to 5 PM"

    # **Weekly Schedules**
    "0 0 * * 0" = "Every Sunday at midnight"
    "0 0 * * 1" = "Every Monday at midnight"
    "0 0 * * 2" = "Every Tuesday at midnight"
    "0 0 * * 3" = "Every Wednesday at midnight"
    "0 0 * * 4" = "Every Thursday at midnight"
    "0 0 * * 5" = "Every Friday at midnight"
    "0 0 * * 6" = "Every Saturday at midnight"

    # **Monthly Schedules**
    "0 0 1 * *"  = "On the 1st day of every month at midnight"
    "0 0 15 * *" = "On the 15th day of every month at midnight"
    "0 0 28 * *" = "On the 28th day of every month at midnight"

    # **Yearly Schedules**
    "0 0 1 1 *" = "On January 1st at midnight"
    "0 0 1 7 *" = "On July 1st at midnight"

    # **Workweek Schedules**
    "0 9-17 * * 1-5" = "Every hour from 9 AM to 5 PM, Monday to Friday"
    "0 8 * * 1-5"    = "Every weekday at 8 AM"
    "0 17 * * 1-5"   = "Every weekday at 5 PM"

    # **Edge Cases**
    "0 0 29 2 *" = "Every leap year on February 29th at midnight"
  }
}
