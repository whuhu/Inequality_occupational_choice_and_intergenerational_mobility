

######################################################################
setwd("C:/Users/huhu/Desktop/重构code/code/R code/Standard/R Decomp")
sink("vd_model_fullnew.txt", append = F)
######################################################################

################################################################
################################################################
# IGE coefficients
setwd("C:/Users/huhu/Desktop/重构code/code/R code/Standard/R data A1")
load("gammas.Rda")
load("mgamma_q.Rda")
IGE_A1<-mean(gammas[,2])

IGE_A1_q1 <-  mgamma_q[1,2]
IGE_A1_q2 <-  mgamma_q[2,2]
IGE_A1_q3 <-  mgamma_q[3,2]
IGE_A1_q4 <-  mgamma_q[4,2]
IGE_A1_q5 <-  mgamma_q[5,2]
setwd("C:/Users/huhu/Desktop/重构code/code/R code/Standard/R data A2")
################################################################
# Adding child's CA to the linear IGE Model
rm(gammas)
rm(mgamma_q)
load("gammas.Rda")
load("mgamma_q.Rda")
IGE_A2    <- mean(gammas[,2])
IGE_A2_q1 <-  mgamma_q[1,2]
IGE_A2_q2 <-  mgamma_q[2,2]
IGE_A2_q3 <-  mgamma_q[3,2]
IGE_A2_q4 <-  mgamma_q[4,2]
IGE_A2_q5 <-  mgamma_q[5,2]

DE_A2    <- 100*IGE_A2/IGE_A1
DE_A2_q1 <- 100*IGE_A2_q1/IGE_A1_q1
DE_A2_q2 <- 100*IGE_A2_q2/IGE_A1_q2
DE_A2_q3 <- 100*IGE_A2_q3/IGE_A1_q3
DE_A2_q4 <- 100*IGE_A2_q4/IGE_A1_q4
DE_A2_q5 <- 100*IGE_A2_q5/IGE_A1_q5

IE_A1A2    <- 100*(IGE_A1    - IGE_A2)/IGE_A1 
IE_A1A2_q1 <- 100*(IGE_A1_q1 - IGE_A2_q1)/IGE_A1_q1  
IE_A1A2_q2 <- 100*(IGE_A1_q2 - IGE_A2_q2)/IGE_A1_q2  
IE_A1A2_q3 <- 100*(IGE_A1_q3 - IGE_A2_q3)/IGE_A1_q3  
IE_A1A2_q4 <- 100*(IGE_A1_q4 - IGE_A2_q4)/IGE_A1_q4  
IE_A1A2_q5 <- 100*(IGE_A1_q5 - IGE_A2_q5)/IGE_A1_q5  

vd2    <-cbind(DE_A2,IE_A1A2)
vd2_q1 <-cbind(DE_A2_q1,IE_A1A2_q1)
vd2_q2 <-cbind(DE_A2_q2,IE_A1A2_q2)
vd2_q3 <-cbind(DE_A2_q3,IE_A1A2_q3)
vd2_q4 <-cbind(DE_A2_q4,IE_A1A2_q4)
vd2_q5 <-cbind(DE_A2_q5,IE_A1A2_q5)

vd2_q <- cbind(t(vd2_q1),t(vd2_q2),t(vd2_q3),t(vd2_q4),t(vd2_q5))

################################################################

##########################
setwd("C:/Users/huhu/Desktop/重构code/code/R code/Standard/R data Son1")
load("gammas.Rda")
load("mgamma_q.Rda")
IGE_S1<-mean(gammas[,2])

IGE_S1_q1 <-  mgamma_q[1,2]
IGE_S1_q2 <-  mgamma_q[2,2]
IGE_S1_q3 <-  mgamma_q[3,2]
IGE_S1_q4 <-  mgamma_q[4,2]
IGE_S1_q5 <-  mgamma_q[5,2]
setwd("C:/Users/huhu/Desktop/重构code/code/R code/Standard/R data Son2")
################################################################
# Adding child's CA to the linear IGE Model
rm(gammas)
rm(mgamma_q)
load("gammas.Rda")
load("mgamma_q.Rda")
IGE_S2    <- mean(gammas[,2])
IGE_S2_q1 <-  mgamma_q[1,2]
IGE_S2_q2 <-  mgamma_q[2,2]
IGE_S2_q3 <-  mgamma_q[3,2]
IGE_S2_q4 <-  mgamma_q[4,2]
IGE_S2_q5 <-  mgamma_q[5,2]

DE_S2    <- 100*IGE_S2/IGE_S1
DE_S2_q1 <- 100*IGE_S2_q1/IGE_S1_q1
DE_S2_q2 <- 100*IGE_S2_q2/IGE_S1_q2
DE_S2_q3 <- 100*IGE_S2_q3/IGE_S1_q3
DE_S2_q4 <- 100*IGE_S2_q4/IGE_S1_q4
DE_S2_q5 <- 100*IGE_S2_q5/IGE_S1_q5

IE_S1S2    <- 100*(IGE_S1    - IGE_S2)/IGE_S1 
IE_S1S2_q1 <- 100*(IGE_S1_q1 - IGE_S2_q1)/IGE_S1_q1  
IE_S1S2_q2 <- 100*(IGE_S1_q2 - IGE_S2_q2)/IGE_S1_q2  
IE_S1S2_q3 <- 100*(IGE_S1_q3 - IGE_S2_q3)/IGE_S1_q3  
IE_S1S2_q4 <- 100*(IGE_S1_q4 - IGE_S2_q4)/IGE_S1_q4  
IE_S1S2_q5 <- 100*(IGE_S1_q5 - IGE_S2_q5)/IGE_S1_q5  

vd3    <-cbind(DE_S2,IE_S1S2)
vd3_q1 <-cbind(DE_S2_q1,IE_S1S2_q1)
vd3_q2 <-cbind(DE_S2_q2,IE_S1S2_q2)
vd3_q3 <-cbind(DE_S2_q3,IE_S1S2_q3)
vd3_q4 <-cbind(DE_S2_q4,IE_S1S2_q4)
vd3_q5 <-cbind(DE_S2_q5,IE_S1S2_q5)

vd3_q <- cbind(t(vd3_q1),t(vd3_q2),t(vd3_q3),t(vd3_q4),t(vd3_q5))

####################################################
##########################
setwd("C:/Users/huhu/Desktop/重构code/code/R code/Standard/R data Dau1")
load("gammas.Rda")
load("mgamma_q.Rda")
IGE_D1<-mean(gammas[,2])

IGE_D1_q1 <-  mgamma_q[1,2]
IGE_D1_q2 <-  mgamma_q[2,2]
IGE_D1_q3 <-  mgamma_q[3,2]
IGE_D1_q4 <-  mgamma_q[4,2]
IGE_D1_q5 <-  mgamma_q[5,2]
setwd("C:/Users/huhu/Desktop/重构code/code/R code/Standard/R data Dau2")
################################################################
rm(gammas)
rm(mgamma_q)
load("gammas.Rda")
load("mgamma_q.Rda")
IGE_D2    <- mean(gammas[,2])
IGE_D2_q1 <-  mgamma_q[1,2]
IGE_D2_q2 <-  mgamma_q[2,2]
IGE_D2_q3 <-  mgamma_q[3,2]
IGE_D2_q4 <-  mgamma_q[4,2]
IGE_D2_q5 <-  mgamma_q[5,2]

DE_D2    <- 100*IGE_D2/IGE_D1
DE_D2_q1 <- 100*IGE_D2_q1/IGE_D1_q1
DE_D2_q2 <- 100*IGE_D2_q2/IGE_D1_q2
DE_D2_q3 <- 100*IGE_D2_q3/IGE_D1_q3
DE_D2_q4 <- 100*IGE_D2_q4/IGE_D1_q4
DE_D2_q5 <- 100*IGE_D2_q5/IGE_D1_q5

IE_D1D2    <- 100*(IGE_D1    - IGE_D2)/IGE_D1 
IE_D1D2_q1 <- 100*(IGE_D1_q1 - IGE_D2_q1)/IGE_D1_q1  
IE_D1D2_q2 <- 100*(IGE_D1_q2 - IGE_D2_q2)/IGE_D1_q2  
IE_D1D2_q3 <- 100*(IGE_D1_q3 - IGE_D2_q3)/IGE_D1_q3  
IE_D1D2_q4 <- 100*(IGE_D1_q4 - IGE_D2_q4)/IGE_D1_q4  
IE_D1D2_q5 <- 100*(IGE_D1_q5 - IGE_D2_q5)/IGE_D1_q5  

vd4    <-cbind(DE_D2,IE_D1D2)
vd4_q1 <-cbind(DE_D2_q1,IE_D1D2_q1)
vd4_q2 <-cbind(DE_D2_q2,IE_D1D2_q2)
vd4_q3 <-cbind(DE_D2_q3,IE_D1D2_q3)
vd4_q4 <-cbind(DE_D2_q4,IE_D1D2_q4)
vd4_q5 <-cbind(DE_D2_q5,IE_D1D2_q5)

vd4_q <- cbind(t(vd4_q1),t(vd4_q2),t(vd4_q3),t(vd4_q4),t(vd4_q5))








print(round(t(vd2),1))
print(round(vd2_q,1))

print(round(t(vd3),1))
print(round(vd3_q,1))

print(round(t(vd4),1))
print(round(vd4_q,1))
sink()