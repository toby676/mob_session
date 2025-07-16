## Mob picker!

During a mob session, it should ensure everyone gets a turn driving and navigating before resetting!

cd into this repo
`cd /mob_session`

Start an irb session
`irb`

Then create an array with all your team members for the mob session
```
require_relative 'mobbing'
team = ['Toby', 'Daniel', 'Kuba', 'Litty', 'Ritik', 'Asbah', 'Kannan']

mob = Mobbing.new(team: team)

mob.call
# => "The driver is: Litty and the navigator is Daniel."
```

