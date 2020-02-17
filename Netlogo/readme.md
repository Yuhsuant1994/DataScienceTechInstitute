# multi-agent programmable modeling

https://ccl.northwestern.edu/netlogo/

**Model 1: small interactive hunger game**

**Model 2: Women Confidence level**

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
