globals[
  avg-weight-global
  avg-weight-normal
  avg-weight-unhappy
  avg-weight-happy
]

turtles-own[
  weight
  ?happy
  confidence-level
  nb-higher
  nb-lower
]
to setup
  clear-all
  setup-turtles
  ask patches [ set pcolor gray  ]
  display-label
  update-globals
  reset-ticks
end

to go
  move-turtles
  update-happy
  update-weight
  update-globals
  tick
  display-label
end


to setup-turtles
  ;create unhappy person
  create-turtles nb_observations * ini_unhappy_percentage / 100
  ask turtles [ set color red
    set nb-higher 10
    set shape "person"
    set ?happy "unhappy"
    set weight precision ( random-normal 70 1 ) 2
    set confidence-level 70
    set label-color black
    setxy random-xcor random-ycor]

  ;happy person
  create-turtles nb_observations * ini_happy_percentage / 100
  ask turtles with [?happy != "unhappy"]
  [ set color green
    set nb-higher 10
    set shape "person"
    set ?happy "happy"
    set weight precision ( random-normal 45 1 ) 2
    set confidence-level 30
    set label-color black
    setxy random-xcor random-ycor]

  ;normal person
  create-turtles nb_observations * ( 100 - ini_happy_percentage - ini_unhappy_percentage) / 100
  ask turtles with [?happy != "unhappy" and ?happy != "happy"]
  [ set color yellow
    set nb-higher 10
    set shape "person"
    set ?happy "normal"
    set weight precision ( random-normal 55 1 ) 2
    set confidence-level 50
    set label-color black
    setxy random-xcor random-ycor]
end


;update turtle's happyness (happy, normal and unhappy), according to their self confidence level
;affected by the neighbor's weight and if the mind of people are sensitive to their neighbor's appearance
;surface neighbor not useful, so we change it to self-confidence level 0-100
;lower then 35 it is unhappy, if it's higher then 65 then it is happy or else it is normal

;note that self confidence-level can only be up to 100 and lower to 0
to update-happy
  ask turtles[
    ;count the number of neighbor weight higher and lower then you
    ;then update the confidence level + nb-higher - nb lower
    set nb-higher count turtles in-radius (1 * sensitive_percentage / 100) with [ weight > [weight] of myself]
    set nb-lower count turtles in-radius (1 * sensitive_percentage / 100) with [ weight < [weight] of myself]
    set confidence-level confidence-level + (( nb-higher - nb-lower ) * sensitive_percentage / 100 )
    ifelse confidence-level <= 35 [ set ?happy "unhappy" set color red ][ifelse confidence-level >= 65 [set ?happy "happy" set color green][set ?happy "normal" set color yellow]]
    ifelse confidence-level < 0 [ set confidence-level random-normal 0 1 ] [ifelse confidence-level > 100 [set confidence-level random-normal 95 1][set confidence-level precision confidence-level 2]]
  ]
end

;randomly update the happy and unhappy people's weight
;we assume that not always people would do exercise and not always happy people would gain weight
;if a person is happy they tend to eat more and randomly gain weight (0.05) per time period
;for those who is not happy they tend to do sport and randomly loss weight (0.1) per time period

;(note that here we assume weight is only reasonable from 40 to 90) not implement


to update-weight
  ask turtles with [ (?happy = "happy") and (weight < 90)][
    if random 10 < 5 [set weight precision (weight + 0.005) 2]
  ]
    ask turtles with [ (?happy = "unhappy") and (weight > 40)][
    if random 10 < 5 [set weight precision (weight - 0.005) 2]
  ]
end

to move-turtles
  ask turtles [
    right random 360
    forward 1
  ]
end

to display-label
  ask turtles[
    ifelse show-label = "non" [set label "" ] [ifelse show-label = "weight" [set label weight] [set label confidence-level ] ]
  ]
end

to update-globals
  set avg-weight-global (mean[weight] of turtles)
  ifelse count turtles with [?happy = "normal"] != 0 [set avg-weight-normal (mean [weight] of turtles with [?happy = "normal"] ) ][set avg-weight-normal 0]
  ifelse count turtles with [?happy = "unhappy"] != 0 [set avg-weight-unhappy (mean [weight] of turtles with [?happy = "unhappy"] )][set avg-weight-unhappy 0]
  ifelse count turtles with [?happy = "happy"] != 0 [set avg-weight-happy (mean [weight] of turtles with [?happy = "happy"] )][set avg-weight-happy 0]
end
@#$#@#$#@
GRAPHICS-WINDOW
236
10
665
439
-1
-1
13
1
10
1
1
1
0
1
1
1
-16
16
-16
16
0
0
1
ticks
30

BUTTON
11
28
74
61
setup
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
82
29
145
62
go
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
0

CHOOSER
10
405
202
450
unhappy_sport_condition
unhappy_sport_condition
"once or twice per time" "more then 3 times per time"
0

MONITOR
682
89
752
134
Unhappy %
precision ((count turtles with [?happy = \"unhappy\"]) / nb_observations * 100) 2
17
1
11

MONITOR
760
90
829
135
Happy  %  
precision ((count turtles with [?happy = \"happy\"]) / nb_observations * 100) 2
17
1
11

PLOT
680
329
880
479
Average weight change
time
avg weight
0
100
0
100
true
false
"" ""
PENS
"Global" 1 0 -14454117 true "" "plot  avg-weight-global"
"Happy" 1 0 -14439633 true "" "plot  avg-weight-happy"
"Normal" 1 0 -10263788 true "" "plot avg-weight-normal"
"Unhappy" 1 0 -5298144 true "" "plot avg-weight-unhappy"

SLIDER
10
118
202
151
nb_observations
nb_observations
30
300
230
10
1
NIL
HORIZONTAL

SLIDER
12
189
205
222
ini_unhappy_percentage
ini_unhappy_percentage
0
50
20
10
1
NIL
HORIZONTAL

SLIDER
12
258
205
291
ini_happy_percentage
ini_happy_percentage
0
50
20
10
1
NIL
HORIZONTAL

TEXTBOX
18
4
168
22
Actions
14
0
1

TEXTBOX
12
95
162
113
Initialization parameters
14
0
1

TEXTBOX
685
11
835
29
Reports
14
0
1

CHOOSER
682
38
830
83
show-label
show-label
"non" "weight" "confidence level"
1

TEXTBOX
13
295
163
321
Human sensitiveness \nto the environment
12
21
1

TEXTBOX
12
156
167
182
Initial percentage of \nunhappy people
12
21
1

TEXTBOX
11
225
161
251
Initial percentage of \nhappy people
12
21
1

SLIDER
10
326
203
359
sensitive_percentage
sensitive_percentage
0
100
50
10
1
NIL
HORIZONTAL

TEXTBOX
770
143
920
161
Unhappy
12
14
0

TEXTBOX
774
164
924
182
Happy
12
63
1

TEXTBOX
689
162
839
180
Normal
12
42
1

TEXTBOX
690
142
840
160
Global
12
94
1

PLOT
681
181
881
331
People count
time
nb of people
0
10
0
10
true
false
"" ""
PENS
"Happy" 1 0 -15040220 true "" "plot count turtles with [?happy = \"happy\"]"
"Unhappy" 1 0 -5298144 true "" "plot count turtles with [?happy = \"unhappy\"]"
"Normal" 1 0 -10263788 true "" "plot count turtles with [?happy = \"normal\"]"

TEXTBOX
13
359
163
398
(it would change the affect for confidence level and the neighborhood range)
12
0
1

MONITOR
880
299
983
344
Avg weight global
precision avg-weight-global 2
17
1
11

MONITOR
879
345
983
390
Avg weight normal  
precision avg-weight-normal 2
17
1
11

MONITOR
879
389
983
434
Avg weight happy   
precision avg-weight-happy 2
17
1
11

MONITOR
879
434
984
479
Avg weight unhappy
precision avg-weight-unhappy 2
17
1
11
@#$#@#$#@
## WHAT IS IT?

Nowadays when we are expose too much to the image of advertisement, celebrities, social media, etc… women tend to have less and less self confidence in their appearance. With general observation, the self esteem depends a lot on the people surrounding such that people living in different countries have different definition of a good body weight standard.

This model is a simple model to simulate women’s mind set about their appearance. We can observe in this model how the people surrounding affect women’s self confidence level which reflect to their happiness about their appearance. As well as how does the average weight in different self-confidence group changes accordingly. 

## HOW IT WORKS

In this model, observations are only human but there are 3 types of self-confidence level group (red for unhappy women, yellow for normal women and green for happy women). In the initialization part we can change: the number of total observations, the percentage of happy and unhappy person about their body weight, sensitive percentage and unhappy sport condition. For the sensitive percentage I assume it’s different from time to time, generation to generation. Therefore sensitive percentage can be changed and would affect generally how much the confidence level would affect the confidence level and the range of the neighbor the women would compare. As for the unhappy sport condition, I assume that some happy people might eat more and gain weight whereas the unhappy people might get motivated and loss weight.

In this model confidence level is rated 0 to 100 and the weight is between 40 to 90. How does the weight of a woman change? Randomly some happy person would increase their weight whereas some unhappy person would lose their weight. How does the confidence level of a woman change? Once the woman move it would take a range of women around her and compare herself with them, more people has less weight then her confidence level decrease. Eventually for the people who has confidence level lower then 35 then they become unhappy, more than 65 they become happy.

## HOW TO USE IT

* Set up the initialized women number, overall percentage of happy and unhappy percentage over the population, how sensitive is this group of people about others and how motivated is the unhappy people doing the sport. 
* Press SETUP to see the initialized graph
* Press GO to begin the simulation
* Change the label to see the womens’ weight or confidence level changes over time
* Observe the current percentage of the unhappy and happy people over all observations 
* Observe the current average weight of all observations, happy, normal and unhappy people
* Observe the graph over time number of people and their average changes between group 

## THINGS TO NOTICE

There are many things we can try in this model:

* Does different initialization (nb of women, percentage of happy and unhappy women, sensitivity level) affect the result in long term?
* How does the long term average weight changes?
* How does the curve changes, is there a general observation?
* What kind of conclusion can we get from this mode?

For 0 percent of sensitive level:
All the graph would be stable, no changes would happen. Which is align with the code setting.

For 50 percent of sensitive level:
It is interesting to see that no matter what is our initialization, our model tend to follow some trend, in the early stage normal person percentage would increase but as time pass through it would decrease to lower then happy and unhappy women. And the distance of percentage would go close and quite stable. Here interested to notice that the average weight of happy and unhappy person would be quite stable in the long term but very close to within 3 groups, we can assume that the self-confidence depend on the comparison mentality instead of really the weight itself.

For 100 percent of sensitive level:
The observations is similar to 50 percent of sensitive level but it converge much faster to stable status. Also notice that compare to 50 percent of sensitive level, there would have much more happy and unhappy person then normal person. Which is also reasonable while the environment care much more about their appearance. (even after a long time normal person would tend to go to 0)

## THINGS TO TRY

Try to adjust the sensitive level to see how would the global society sensitive level affect the weight and the mode of women. Is there a pattern generally, or the pattern change while we change the parameters? Try to see how the initial parameters change the time to converge. Try to see how the average weight changes overtime.

## EXTENDING THE MODEL

This model is just for now a simple model to consider the confidence level for women without considering too much factor. In this model there exist only women comparing to women as well. Therefore there are a lot of things that can be extended from this model, such as, adding more factor affecting weights, consider more factor other than just weight and just consider the neighbor around to come up with more complex algorithm. Finally, there are many parameters in this model only set by random, in the extension it can be adjust from country to country with the society studies to change the parameters to have more science proof to back up for this model.

## CREDITS AND REFERENCES

Come from personal observation and idea.
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.1.0
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0
-0.2 0 0 1
0 1 1 0
0.2 0 0 1
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@

@#$#@#$#@
