#LearningJourney 📅🔥🧊:

LearningJourney is a SwiftUI-based app designed to help users keep track of their learning goals and maintain a consistent streak. It allows the user to log daily learning progress, keep track of his streak, and utilize "freeze" days to avoid breaking his streak when needed. With a clean and intuitive user interface, LearningJourney motivates the users to keep up their learning journey.

#Features ✨:

- Daily Logging: Log learning progress for the current day and mark it as "Learned."
- Weekly View: See the current week with indicators for each day.
- Streak Count: Track consecutive days of learning.
- Freeze Days: Preserve streak by using limited freeze days in case the user can’t log his progress.
- Navigation: Easily update learning goal and move between weeks in the calendar view.
- Responsive UI: Adapts dynamically to changes in the current date, selected date, and user actions.

#Logic Highlights:
Streak Resets: The app automatically resets the streak if more than 32 hours pass without logging a day.
Dynamic Freeze Limit: Adjusts the number of allowed freeze days based on the selected timeframe (Week, Month, Year).
