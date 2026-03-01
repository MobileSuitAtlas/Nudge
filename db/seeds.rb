# Clear existing data
Tag.destroy_all
Badge.destroy_all

# Tags seed data
tags = [
  { name: "Health", color: "#FF6B6B" },
  { name: "Fitness", color: "#4ECDC4" },
  { name: "Learning", color: "#45B7D1" },
  { name: "Creative", color: "#9B59B6" },
  { name: "Productivity", color: "#F1C40F" },
  { name: "Mindfulness", color: "#E91E63" }
]
Tag.create!(tags)

# Badges seed data
badges = [
  { name: "Week Warrior", icon: "🌱", description: "Complete 7 days in a row", requirement_days: 7 },
  { name: "Fortnight Force", icon: "🔥", description: "Complete 14 days in a row", requirement_days: 14 },
  { name: "Three Week Thunder", icon: "⚡", description: "Complete 21 days in a row", requirement_days: 21 },
  { name: "Monthly Master", icon: "🏆", description: "Complete 30 days in a row", requirement_days: 30 },
  { name: "Quarterly Quest", icon: "👑", description: "Complete 90 days in a row", requirement_days: 90 },
  { name: "Century Club", icon: "💎", description: "Complete 100 days in a row", requirement_days: 100 },
  { name: "Year Champion", icon: "🌟", description: "Complete 365 days in a row", requirement_days: 365 }
]
Badge.create!(badges)

puts "Created #{Tag.count} tags and #{Badge.count} badges!"
