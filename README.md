# projects_archive
Coding projects I have completed until today :)

Here a description for every project, from the most to the least recent.

## Transport in London
This was a group project for ST445 - Managing and Visualising Data at LSE. I worked in collaboration with Michele Bergami and Adleena Shakir.
We analysed some datasets about public transportation in London and we aimed at answering the following questions:

1. Which events impacted significantly the number of journeys on the entire TfL network over the years?
2. Are there any considerable events that made passengers switch across means of transportation?
3. How has overall trend of transport-related crimes in London changed over years 2009-2023?
4. What are the key factors influencing the number of TfL journeys?
5. Can historical data on TfL journeys be used to predict future passenger numbers accurately, and can we create a model to predict the number of TfL journeys in 2024?

We used visualisations, linear regression and SARIMA models.

My technical contribution was mainly on the creation of interactive plots, done with plotly.

<br>

## University Timetable
This was a group project for ST449 - Artificial Intelligence at LSE. I worked in collaboration with Michele Bergami, Tweesha Dewan and Reuben Mathew.

This project explores an approach to solve the university timetable planning problem through constraint-based reasoning. The timetabling problem is set as a constraint satisfaction model, and various techniques like constraint propagation and backtracking are implemented. We worked on a dataset from the University of Brasilia is employed to define variables and constraints.

My technical contributions on this project were on the construction and implentation of the CP-solver algorithm.

<br>

## Telecom Churn + Coordinate Descent
This was a group project for ST443 - Machine Learning and Data Mining at LSE. I worked in collaboration with Michele Bergami, Elisabetta Sanasi, Omar Almutoteh and Giorgi Kvinikadze.

We assessed the performance of kNN, LDA, QDA, and Logistic Regression on a dataset from an Iranian telecommunication company, predicting customer churn. Additionally, we implemented and tested coordinate-descent algorithms for LASSO and Elastic Net across various simulated scenarios.

My technical contributions on this project are mainly on the second part of the project. More specifically, I worked on the construction and implementation of the Lasso and Elastic Net Coordinate Descent algorithms and the different scenarios on which we tested our code.

<br>

## CIVICA Research Collaborative Hackathon: Europe Revisited
### Mining Political Party Manifestos for Patterns of European Support
In this 24 hours hackathon, I worked in collaboration with Michele Bergami, Oleksandra Pashkina (Sciences Po) and Naman Kapoor (Sciences Po).

We applied k-means clustering on data about political party manifestos. We focused on 4 themes derived from 160 parameters coming from the Manifesto Project database. Finally, we identified 6 distinct party groups. 

My duties included refining a research question, conducting exploratory data analysis, and using pandas for data cleaning. My work is summarised in the file CIVICA_def, that provided the base for the implementation of the k-means clustering analysis.

<br>

## Chopsticks Bot
This was an individual project for ST449 - Artificial Intelligence at LSE.

I developed a bot on Python for the children game "chopsticks." The rules of the game are the following:
1. The game is played by two players in turns.
2. At the start of the game, each player stick out one finger in each of their two hands.
3. A hand is called “busted” if all fingers are folded. In each turn, a player can choose one of the following actions:
   Tap: use one of her unbusted hand to tap on either one of opponent’s unbusted hand or her own other unbusted hand.
   Split: Use one of her unbusted hand that has 4 or 5 fingers sticking out to tap her own other busted hand. After this action, the originally unbusted hand has ⌈x/2⌉ fingers sticking out and the originally busted hand becomes unbusted and sticks out ⌊x/2⌋ fingers (x is 4 or 5).
4. A player wins a game by busting both of their opponent’s hands.

I used an alpha-beta pruning algorithm: this checks if it is possible to win in the following 7 moves, with any possible action of the opponent (assumed to behave in the same way). If a win is found, the bot chooses immediately (pruning) the relevant move, if not it continues to search. An arbitrary move is selected for the first stages to reduce the game time.

<br>

## Driving Test Centre
This was an individual project for ST447 - Statistical Methods and Data Analysis at LSE.

The aim of this project is to help an hypothetical friend to decide where to take the practical car test. They must choose between the nearest test centre to their home and the nearest test centre to the London School of Economics. I needed to answer the following questions:
1. What is the expected passing rate at the nearest test centre to their home?
2. What is the expected passing rate at the nearest test centre to the LSE?
3. Of these two locations, where should our friend take the test? Is there any evidence to (statistically) support this suggestion?

I used Wald tests and logistic regression.

<br>

## Behavioral Macroeconomics
This is my Bachelor's Final Work. The study focuses on the empirical validation across multiple economies of the behavioral macroeconomic model proposed by Paul De Grauwe (Lectures on Behavioral Macroeconomics, 2012). This model, known for its incorporation of bounded rationality and "animal spirits", provides a unique perspective on economic fluctuations. However, the extent to which its predictions align with real-world data across different economic contexts remains unclear. The main research question of this survey is: How well do the predictions of De Grauwe's model align with the empirical data from various economies?

A cross-country analysis has been conducted, comparing the model's predictions on the non-normal distributions of macroeconomic variables with actual data, and examining the correlation between output gap, inflation, interest rate and animal spirits, measured by the market sentiment index. The findings reveal that the distributions of key macroeconomic variables deviate from normality in several instances, partially confirming De Grauwe's model. However, the normality assumption could not be universally rejected, indicating that the model's predictions may not hold consistently across different economic contexts. Furthermore, while a positive correlation between the output gap and market sentiment index was observed, the correlation was weaker than the one obtained by the simulations of De Grauwe's model, indicating a potential overestimation of the influence of these variables in the model.

Empirical Section: 
I used pandas to clean data and to perform exploratory analysis, seaborn and matplotlib to visualise distributions and correlations of different macroeconomic variables across 7 countries. Then, I used Stata to investigate an empirical validation of the Taylor Rule.
<br>

## Tidy Dataset
