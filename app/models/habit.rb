class Habit < ApplicationRecord
    has_many :check_ins, dependent: :destroy

    def current_streak
        streak = 0
        day = Date.today

        while check_ins.exists?(date: day)
            streak += 1
            day -= 1
        end
        streak
    end

    def icon
        {
            "Reading" => "📚",
            "Writing" => "✍️",
            "Workout" => "💪",
            "Drawing" => "🎨",
        }[category]
    end
    
    TEMPLATES = {
        "Reading" => "📚",
        "Writing" => "✍️",
        "Workout" => "💪",
        "Drawing" => "🎨"
    }

    ENCOURAGEMENT_NUDGES = [
        "Keep it up! You are doing great!",
        "Not giving up is the key to success! Keep going!",
        "It's amazing to see your dedication! Keep pushing forward!", 
        "No one can do it like you can! Keep it up!",
        "Every day is a new opportunity to grow! Keep going!",
        "Your commitment is inspiring! Keep it up!",
        "You are stronger than you think! Keep pushing forward!",
        "Don't forget why you started! Keep it up!",
        "Your hard work is paying off! Keep going!",
        "I'm proud of you for sticking with it! Keep it up!"
    ]

    MILESTONE_MESSAGES = {
        7 => ["One week is impressive, truly something to be proud of! Keep it up!"],      
        14 => ["POP OFF! Two weeks is insane! Keep it up! I'm super glad you are sticking with it!"],
        21 => ["Three weeks is amazing! Holy moly! I don't see a stop anytime soon!"],
        28 => ["Four weeks quite the achievement! I'll be sure to have a special message for when the day comes! Keep up the good work!"],
        30 => ["This is a huge milestone! One month of pure consistency and dedication deserves a reward! I'm very proud of you, truly an inspiration to anyone who wants to build better habits!"]
    }

    def set_default_prompt
        self.prompt ||= TEMPLATES[category] if category.present?
    end 

    def milestone_message
        messages = MILESTONE_MESSAGES[current_streak]
        messages&.sample
    end

    def encouragement_message
        return "LET'S GO! Awesome job on breaking your last streak! Keep it up!" if current_streak > longest_streak

        if current_streak == 0
            "We start Today!"
        elsif current_streak == 1
            "1 small step for man, 1 giant leap for new habits!"
        elsif current_streak == 2
            "Let's go! 2 days in a row is awesome!"
        elsif current_streak == 3
            "Day 3! I'm glad you are sticking with it!"
        elsif current_streak == 4
            "More than half a week into and I don't see a stop!"
        elsif current_streak == 5
            "Day 5! You are doing great! Keep it up!"
        else current_streak < 6
            "You are killing it! with the #{current_streak} day"
        end
    end

    def last_check_ins_date
        check_ins.order(date: :desc).limit(1).pluck(:date).first
    end

    def age_in_days
        (Date.today - created_at.to_date).to_i
    end

    def longest_streak
        dates = check_ins.order(date: :desc).pluck(:date)
        
        return 0 if dates.empty?

        longest = 1
        current = 1
        previous_date = dates.first

        dates.each do |date|
            if date == previous_date - 1
                current += 1
            else
                current = 1
            end
            longest = [longest, current].max
            previous_date = date
        end
        longest
    end
end