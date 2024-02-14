ID = 202306391
source("XYZprofile.r")
XYZprofile(ID)

library(readxl) # to read the Excel files

nelson = read_excel('nelson.xlsx')
wg = read_excel('wg.xlsx')

#Removing the rows with missing data
nelson = nelson[!is.na(nelson$conducted),]
wg = wg[!is.na(wg$conducted),]

#To visualize the first and last lines of the Nelson data
head(nelson)
tail(nelson)

#Bar chart to see trend in years of pass rate for Nelson
pass_rate_y_nels=c()
for (i in 2008:2023){
  pass_rate_y_nels = c(pass_rate_y_nels,mean(nelson$pass_rate[nelson$year==i]))}

barplot(pass_rate_y_nels,
        main="Pass rate per year in Nelson",
        xlab="Year",
        ylab="Pass rate (in %)",
        ylim = c(0,60),
        names=2008:2023,
        col="red")

#Bar chart to see trend in years of pass rate for Wood Green
pass_rate_y_wg=c()
for (i in 2008:2023){
  pass_rate_y_wg = c(pass_rate_y_wg,mean(wg$pass_rate[wg$year==i]))}

barplot(pass_rate_y_wg,
        main="Pass rate per year in Wood Green",
        xlab="Year",
        ylab="Pass rate (in %)",
        ylim = c(0,60),
        names=2008:2023,
        col="red",)

#Bar chart to see how pass rate is different for gender in Nelson
barplot(c(mean(nelson$pass_rate[nelson$gender=='M']),
          mean(nelson$pass_rate[nelson$gender=='F'])),
        main="Pass rate per gender in Nelson",
        xlab="Gender",
        ylab="Pass rate (in %)",
        ylim = c(0,60),
        names=c('Male', 'Female'),
        col="blue")

#Bar chart to see how pass rate is different for gender in WG
barplot(c(mean(wg$pass_rate[wg$gender=='M']),
          mean(wg$pass_rate[wg$gender=='F'])),
        main="Pass rate per gender in Wood Green",
        xlab="Gender",
        ylab="Pass rate (in %)",
        ylim = c(0,60),
        names=c('Male', 'Female'),
        col="blue")

#Bar chart to see pass rate for each age in Nelson
pass_rate_age_nels=c()
for (i in 17:25){
  pass_rate_age_nels = c(pass_rate_age_nels,
                         mean(nelson$pass_rate[nelson$age==i]))}
barplot(pass_rate_age_nels,
        main="Pass rate per age in Nelson",
        xlab="Age",
        ylab="Pass rate (in %)",
        ylim = c(0,60),
        names=17:25,
        col="green")

#Bar chart to see pass rate for each age in WG
pass_rate_age_wg=c()
for (i in 17:25){
  pass_rate_age_wg = c(pass_rate_age_wg,
                       mean(wg$pass_rate[wg$age==i]))}
barplot(pass_rate_age_wg,
        main="Pass rate per age in Wood Green",
        xlab="Age",
        ylab="Pass rate (in %)",
        ylim = c(0,60),
        names=17:25,
        col="green")

#Bar chart to see pass rates of males for each age in Nelson
pass_rate_age_m_nels=c()
for (i in 17:25){
  pass_rate_age_m_nels = c(pass_rate_age_m_nels,mean(nelson$pass_rate[nelson$age==i&nelson$gender=='M']))
}
barplot(pass_rate_age_m_nels,
        main="Pass rate for males per age in Nelson",
        xlab="Age",
        ylab="Pass rate (in %)",
        ylim = c(0,60),
        names=17:25,
        col="green",
)

#Bar chart to see pass rates of males for each age in WG
pass_rate_age_m_wg=c()
for (i in 17:25){
  pass_rate_age_m_wg = c(pass_rate_age_m_wg,mean(wg$pass_rate[wg$age==i&wg$gender=='M']))
}
barplot(pass_rate_age_m_wg,
        main="Pass rate for males per age in Wood Green",
        xlab="Age",
        ylab="Pass rate (in %)",
        ylim = c(0,60),
        names=17:25,
        col="green",
)

#Overall expected pass rate in Nelson
n1=sum(nelson$conducted)
p1_hat = sum(nelson$passed)/n1
p1_hat

#Overall expected pass rate in Wood Green
n2=sum(wg$conducted)
p2_hat = sum(wg$passed)/n2
p2_hat

#Wald test
p_hat=(n1*p1_hat+n2*p2_hat)/(n1+n2)
Sp=p_hat*(1-p_hat)
test_stat = (p1_hat-p2_hat)/sqrt(Sp*(1/n1+1/n2))
1-pnorm(test_stat) #p-value

#We reject the null hypothesis with a confidence level of 99.9%. The two proportions are different.

#Logistic regression for Nelson
log_nelson=glm(cbind(passed,conducted-passed)~year+age+gender, data=nelson,
               family=binomial(logit))
summary(log_nelson)

#Logistic regression for Wood Green
log_wg=glm(cbind(passed,conducted-passed)~year+age+gender, data=wg,
           family=binomial(logit))
summary(log_wg)

#Expected pass rate given that the exam-taker is a 23 years old male in Nelson
n1_m23=sum(nelson$conducted[nelson$age==23 & nelson$gender == 'M'])
p1_hat_m23 = sum(nelson$passed[nelson$age==23 & nelson$gender == 'M'])/n1_m23
p1_hat_m23

#Expected pass rate given that the exam-taker is a 23 years old male in Wood green
n2_m23=sum(wg$conducted[wg$age==23 & wg$gender == 'M'])
p2_hat_m23 = sum(wg$passed[wg$age==23 & wg$gender == 'M'])/n2_m23
p2_hat_m23

#Wald test
p_hat_m23=(n1_m23*p1_hat_m23+n2_m23*p2_hat_m23)/(n1_m23+n2_m23)
Sp_m23=p_hat_m23*(1-p_hat_m23)
test_stat_m23 = (p1_hat_m23-p2_hat_m23)/sqrt(Sp_m23*(1/n1_m23+1/n2_m23))
1-pnorm(test_stat_m23) #p-value

#We reject the null hypothesis with a confidence level of 99.9%. The two proportions are different.

n1_m=sum(nelson$conducted[nelson$gender == 'M'])
p1_hat_m = sum(nelson$passed[nelson$gender == 'M'])/n1_m
p1_hat_m

n2_m=sum(wg$conducted[wg$gender == 'M'])
p2_hat_m = sum(wg$passed[wg$gender == 'M'])/n2_m
p2_hat_m

p_hat_m=(n1_m*p1_hat_m+n2_m*p2_hat_m)/(n1_m+n2_m)
Sp_m=p_hat_m*(1-p_hat_m)
test_stat_m = (p1_hat_m-p2_hat_m)/sqrt(Sp_m*(1/n1_m+1/n2_m))
1-pnorm(test_stat_m) #p-value