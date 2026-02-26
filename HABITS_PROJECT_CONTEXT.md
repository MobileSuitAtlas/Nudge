# Habits - Gentle Habit Builder App

## What This App Does

**Habits** is a gentle, anxiety-friendly habit tracker that helps users build new positive habits without negative reinforcement.

### Key Features:
- **Streak tracking** - Tracks consecutive days of completing habits
- **Gentle nudges** - Encouragement messages that motivate without guilt
- **Milestone celebrations** - Special messages at 7, 14, 21, 28, and 30 days
- **Focus habit** - Set one habit as today's priority
- **Categories** - Reading, Writing, Workout, Drawing with emoji icons

### The Philosophy:
- No negative reinforcement for missed days
- Encouraging messages like "No problem, picking up new habits can be hard but keep trying!"
- Goal: Users should eventually drop the app once they've built their habit
- Designed for people with anxiety or those working on personal growth

---

## Project Structure

```
habit_builder/
├── app/
│   ├── controllers/
│   │   └── habits_controller.rb    # Handles all actions (check-in, create, nudge, etc.)
│   ├── models/
│   │   ├── habit.rb                 # Habit model with streak logic
│   │   └── check_in.rb              # Tracks daily completions
│   └── views/
│       └── habits/
│           ├── index.html.erb       # List all habits
│           ├── today.html.erb      # Today's view with check-in buttons
│           ├── show.html.erb       # Individual habit details + stats
│           └── new.html.erb        # Create new habit form
├── config/
│   └── routes.rb                   # URL routes
└── db/
    └── schema.rb                    # Database structure
```

---

## Routes (URLs)

| URL | Action | Purpose |
|-----|--------|---------|
| `/` or `/today` | today | Today's habits with check-in buttons |
| `/habits` | index | List all habits |
| `/habits/new` | new | Create a new habit |
| `/habits/:id` | show | View habit details and stats |
| POST `/habits/:id/check_in` | check_in | Mark habit done for today |
| POST `/habits/:id/nudge` | nudge | Get encouragement message |
| POST `/habits/:id/set_focus` | set_focus | Set as today's focus habit |

---

## Key Code Concepts

### Habit Model (`app/models/habit.rb`)
- `current_streak` - Counts consecutive days checked in
- `longest_streak` - Best streak ever achieved
- `encouragement_message` - Returns message based on streak count
- `milestone_message` - Special messages at milestones (7, 14, 21, 28, 30 days)
- `icon` - Returns emoji based on category

### Check-In System
- Each habit has many check_ins
- Check-ins store the `date` when completed
- A habit can only have one check-in per day

---

## Future Features (Planned)

### Phase 1: PWA Setup
- Make app installable on phones
- Enable push notifications (for gentle reminders)

### Phase 2: Calendar View
- Visual calendar showing check-in history
- Streak heatmap (like GitHub contributions)

### Phase 3: Reminder System
- Schedule specific times for reminders
- "Hello! Have you done your [habit] today?" messages
- Yes/No response flow that tracks completion

---

## Conversation Summary

### Fixed Issues:
1. **index.html.erb error** - Buttons referenced `@habit` (nil) instead of loop variable
   - Removed broken buttons outside the loop
   - Added "Start a New Habit" and "Need a Little Nudge?" buttons properly

### Current State (as of Feb 26, 2026):
- App loads without errors
- Index page shows habit list
- Today page has working check-in buttons
- Nudge system works with random encouragement messages

### Next Steps (user priority):
1. UI improvements (requested as priority)
2. Calendar/streak visualization
3. PWA setup for push notifications
4. Gentle reminder notification system

---

## Running the App

```bash
cd habit_builder
rails server
# Then open http://localhost:3000
```

---

## User's Vision (in their words)

> "I wanted to make something that can be useful and even more so for people who have anxiety or battling something personal."
> 
> "Not like a loud alarm but something that will pop up on your phone going 'Hello! Have you done your reading for today?' if no 'No problem, picking up new habits can be hard but keep trying!' if yes 'Awesome! I'll go ahead and track that for you!'"
> 
> "It would be gentle in the sense that it wont have any negative reinforcement for not doing it but will be a gentle nudge."
> 
> "I hope that one day one that uses it will drop it or uninstall it knowing that they developed a better habit from it"
