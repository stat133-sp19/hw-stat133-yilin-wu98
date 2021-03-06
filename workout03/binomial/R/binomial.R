

# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Build and Reload Package:  'Ctrl + Shift + B'
#   Check Package:             'Ctrl + Shift + E'
#   Test Package:              'Ctrl + Shift + T'

library(ggplot2)
# CHECK FUNCTIONS

# title:check the probability
# description: check if probability is a valid value(0<= prob <=1)
# param: prob
# return logical value(TRUE) or error
# example: check_prob(0.5)
check_prob <- function(prob){
   if (!is.double(prob)){
     stop("p should be a number")
   }else{
     if (prob>=0 & prob <=1){
       return(TRUE)
     }else{
       stop("p has to be a number between 0 and 1")
     }
   }
}

# title check_trials
# decsription check the trials, it should be a non-negative integer
# param: trials
# return : logic value TRUE or error
# example: check_trials(3)
check_trials<- function(trials){
  if (round(trials)==trials & trials >=0){
    return(TRUE)
  }else{
    stop("invalid trials value")
  }
}


# title check the success and trials
# description check success and success should be a non-negative integer(s) less or equal than trials
# param success and trials
# return logical value(TRUE) or error
# example check_success(5,6); check_success(c(1,2,3),5)
check_success <- function(success,trials){
   if (!(round(success)==success) | any(success <0)==TRUE){
     stop("invalid success value")
   }else{
     if(any(success>trials)==TRUE){
       stop("success cannot be greater than trials")
     }else{
       return(TRUE)
     }
   }
}


# AUXILIARY FUNCTIONS
# title mean of binomial
# description given the trials and probability, compute the mean
# param trials and prob
# return mean
# example aux_mean(10,0.3)
aux_mean<- function(trials, prob){
  return(trials*prob)
}

# title variance of binomial
# description given the trials and probability, compute the variance
# param trials and prob
# return variance
# example aux_variance(10,0.3)
aux_variance <- function(trials,prob){
  return(trials*prob*(1-prob))
}

# title mode of binomial
# description given the trials and probability, compute the mode
# param trials and prob
# return mode
# example aux_mode(10,0.3)
aux_mode <- function(trials,prob){
  return(floor(trials*prob+prob))
}

# title skewness of binomial
# description given the trials and probability, compute the skewness
# param trials and prob
# return skewness
# example aux_skewness(10,0.3)
aux_skewness <- function(trials,prob){
  return((1-2*prob)/sqrt(trials*prob*(1-prob)))
}

# title kurtosis of binomial
# description given the trials and probability, compute the kurtosis
# param trials and prob
# return kurtosis
# example aux_kurtosis(10,0.3)
aux_kurtosis <- function(trials,prob){
  return((1-6*prob*(1-prob))/(trials*prob*(1-prob)))
}


#' @title choose from binomial distribution
#' @description choose a number given the success and trials
#' @param n integer
#' @param k integer
#' @return the choosen number integer
#' @export
#' @examples
#' bin_choose(n = 5, k = 2)
#' bin_choose(5, 0)
#' bin_choose(5, 1:3)

bin_choose <- function(n,k){
  if(n<k){
    stop("k cannot be greater than n")
  }
  sel= factorial(n)/(factorial(k)*factorial(n-k))
  return(sel)
}

#' @title probability of binomial distribution
#' @description calculate a binomial probability
#' @param success integer vector
#' @param trials integer
#' @param prob double
#' @return probability vector
#' @export
#' @examples
#' bin_probability(success=2,trials=5,prob=0.5)
#' bin_probability(success = 0:2, trials = 5, prob = 0.5)
#' bin_probability(success = 55, trials = 100, prob = 0.45)
 bin_probability <- function(success,trials,prob){
   if(check_trials(trials)&check_success(success,trials)&check_prob(prob)){
     sel=bin_choose(trials,success)
     return(sel*prob^success*(1-prob)^(trials-success))
   }
 }


 #' @title a dataframe of binomial distribution
 #' @description base on the binomial probability, create a dataframe of binomial distribution
 #' @param trials integer
 #' @param prob double
 #' @return dataframe of binomial distribution
 #' @export
 #' @examples
 #' bin_distribution(trials=5,prob=0.5)

bin_distribution <- function(trials,prob){
  bin_d <- data.frame(success=0:trials,probability=bin_probability(success=0:trials,trials,prob))
  class(bin_d)<- c('bindis','data.frame')
  return(bin_d)
}


#' @export
plot.bindis <- function(dis){
ggplot(dis,aes(success,probability))+geom_bar(fill ='red',stat='identity')+
    labs(x="success",y="probability")+theme_minimal()
}

#' @title a dataframe of cumulative binomial distribution
#' @description base on the binomial probability, create a dataframe ofcumulative binomial distribution
#' @param trials integer
#' @param prob double
#' @return the dataframe of cumulative binomial distribution
#' @export
#' @examples
#' bin_cumulative(trials=5,prob=0.5)

bin_cumulative <- function(trials,prob){
  bin_c <- data.frame(success=0:trials,probability=bin_probability(0:trials,trials,prob))
  bin_c$cumulative <- cumsum(bin_c$probability)
  class(bin_c)<- c("bincum","data.frame")
  return(bin_c)
}

#' @export
plot.bincum <- function(dis){
  ggplot(dis,aes(success,cumulative,color='red'))+
    geom_point()+
    geom_line(stat='identity')+
    labs(x='success',y='probability')+
    theme_minimal()

  # plot(dis$success,dis$cumulative,type='b',xlab="success",ylab="probability")
}


#' @title a random vinomial variable
#' @description return a random binomial variable based on the given trials and prob
#' @param trials integer
#' @param prob double
#' @return object  binvar
#' @export
#' @examples
#' bin_variable(trials=5,prob=0.5)

bin_variable <- function(trials,prob){
  if(check_trials(trials)&check_prob(prob)){
     var <- list(trials=trials,prob=prob)
     class(var)<-"binvar"
     return(var)
  }
}

#' @export
print.binvar <- function(var){
  cat("Binomial variable\n")
  cat("Parameters\n")
  cat(paste0("-number of trials: ",var$trials,"\n"))
  cat(paste0("-prob of success: ",var$prob,"\n"))

  invisible(var)
}

#' @export
summary.binvar <- function(binvar){
   n=binvar$trials
   p=binvar$prob
   var_list <- list(trials=n,probability=p,mean=aux_mean(n,p),variance=aux_variance(n,p),mode=aux_mode(n,p),skewness=aux_skewness(n,p),kurtosis=aux_kurtosis(n,p))
   class(var_list)<-"summary.binvar"
   return(var_list)
}

#' @export
print.summary.binvar <- function(binvar){
  cat("Summary Binomials\n")
  cat("Parameters\n")
  cat(paste0("-number of trials: ",binvar$trials,"\n"))
  cat(paste0("-prob of success: ",binvar$probability,"\n"))
  cat("Measures\n")
  cat(paste0("-mean: ",binvar$mean,"\n"))
  cat(paste0("-variance: ",binvar$variance,"\n"))
  cat(paste0("-mode: ",binvar$mode,"\n"))
  cat(paste0("-skewness: ",binvar$skewness,"\n"))
  cat(paste0("-kurtosis: ",binvar$kurtosis,"\n"))
  invisible(binvar)
}


#' @title mean of binomial
#' @description return mean of binomial distribution
#' @param trials integer
#' @param prob double
#' @return mean double
#' @export
#' @examples
#' bin_mean(trials=5,prob=0.5)
bin_mean <- function(trials,prob){
  if(check_trials(trials)&check_prob(prob)){
    return(aux_mean(trials,prob))
  }
}

#' @title variance of binomial
#' @description return variance of binomial distribution
#' @param trials integer
#' @param prob double
#' @return variance double
#' @export
#' @examples
#' bin_variance(trials=5,prob=0.5)
bin_variance <- function(trials,prob){
  if(check_trials(trials)&check_prob(prob)){
    return(aux_variance(trials,prob))
  }
}

#' @title mode of binomial
#' @description return mode of binomial distribution
#' @param trials integer
#' @param prob double
#' @return mode double
#' @export
#' @examples
#' bin_mode(trials=5,prob=0.5)
bin_mode <- function(trials,prob){
  if(check_trials(trials)&check_prob(prob)){
    return(aux_mode(trials,prob))
  }
}

#' @title skewness of binomial
#' @description return skewness of binomial distribution
#' @param trials integer
#' @param prob double
#' @return skewness double
#' @export
#' @examples
#' bin_skewness(trials=5,prob=0.5)
bin_skewness <- function(trials,prob){
  if(check_trials(trials)&check_prob(prob)){
    return(aux_skewness(trials,prob))
  }
}

#' @title kurtosis of binomial
#' @description return kurtosis of binomial distribution
#' @param trials integer
#' @param prob double
#' @return kurtosis double
#' @export
#' @examples
#' bin_kurtosis(trials=5,prob=0.5)
bin_kurtosis <- function(trials,prob){
  if(check_trials(trials)&check_prob(prob)){
    return(aux_kurtosis(trials,prob))
  }
}

