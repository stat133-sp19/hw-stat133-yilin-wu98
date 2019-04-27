source("../../R/binomial.R")
context("Test binomial functions")

test_that("test bin_choose works",{
  expect_length(bin_choose(5,2),1)
  expect_length(bin_choose(5,1:3),3)
  expect_equal(bin_choose(5,2),10)
  expect_equal(bin_choose(5,1:3),c(5,10,10))
  expect_error(bin_choose(4,5),"k cannot be greater than n")
})

test_that("test bin_probability works",{
  expect_length(bin_probability(success = 2, trials = 5, prob = 0.5),1)
  expect_equal(bin_probability(success = 2, trials = 5, prob = 0.5),0.3125)
  expect_length(bin_probability(success = 0:2, trials = 5, prob = 0.5),3)
  expect_equal(bin_probability(success = 0:2, trials = 5, prob = 0.5),c(0.03125,0.15625,0.31250))
  expect_error(bin_probability(success = 0:2, trials = -5, prob = 0.5),"invalid trials value")
  expect_error(bin_probability(success = 0.5, trials = 5, prob = 0.5),"invalid success value")
  expect_error(bin_probability(success = 0:2, trials = 5, prob = -1),"p has to be a number between 0 and 1")

})

test_that("test bin_distribution works",{
  expect_is(bin_distribution(trials=5,prob=0.5),c("bindis","data.frame"))
  bin <- bin_distribution(trials=5,prob=0.5)
  expect_equal(bin$probability,c(0.03125,0.15625,0.31250,0.31250,0.15625,0.03125))
  expect_equal(bin$success,0:5)
  expect_error(bin_distribution(trials=5,prob=-1),"p has to be a number between 0 and 1")
  expect_error(bin_distribution(trials=0.1,prob=0.5),"invalid trials value")

})

test_that('test bin_cumulative works',{
  expect_is(bin_cumulative(trials=5,prob=0.5),c("bincum","data.frame"))
  bin <- bin_cumulative(trials=5,prob=0.5)
  expect_equal(bin$probability,c(0.03125,0.15625,0.31250,0.31250,0.15625,0.03125))
  expect_equal(bin$cumulative,c(0.03125,0.18750,0.50000,0.81250,0.96875,1.00000))
  expect_equal(bin$success,0:5)
  expect_error(bin_cumulative(trials=5,prob=-1),"p has to be a number between 0 and 1")
  expect_error(bin_cumulative(trials=0.1,prob=0.5),"invalid trials value")

})
