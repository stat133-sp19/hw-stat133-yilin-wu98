source("../../R/binomial.R")
context("Test checker functions")

test_that("test check_prob works",{
  expect_true(check_prob(0))
  expect_true(check_prob(1))
  expect_length(check_prob(0.5),1)
  expect_error(check_prob(-1),"p has to be a number between 0 and 1")
  expect_error(check_prob("1"),"p should be a number")
})

test_that("test check_trials works",{
  expect_length(check_trials(5),1)
  expect_true(check_trials(10))
  expect_error(check_trials(-10),"invalid trials value")
})

test_that("test check_success works",{
  expect_length(check_success(1,2),1)
  expect_length(check_success(0:1,2),1)
  expect_true(check_success(0:1,2))
  expect_error(check_success(1:3,2),"success cannot be greater than trials")
  expect_true(check_success(1,2))
  expect_error(check_success(-1,2),"invalid success value")
  expect_error(check_success(3,1),"success cannot be greater than trials")
})
