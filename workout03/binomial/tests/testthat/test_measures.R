source("../../R/binomial.R")
context("Test summary measures functions")

test_that("test aux_mean works",{
  expect_equal(aux_mean(10,0.3),3)
  expect_length(aux_mean(10,0.5),1)
  expect_equal(aux_mean(0,0.5),0)
})

test_that("test aux_variance works",{
  expect_length(aux_variance(10,0.3),1)
  expect_equal(aux_variance(10,0.3),2.1)
  expect_equal(aux_variance(0,0.3),0)
})

test_that("test aux_mode works",{
  expect_length(aux_mode(10,0.3),1)
  expect_equal(aux_mode(10,0.3),3)
  expect_equal(aux_mode(0,0.3),0)
})

test_that("test aux_skewness works",{
  expect_length(aux_skewness(10,0.3),1)
  expect_equal(aux_skewness(10,0.3),(1-2*0.3)/sqrt(10*0.3*0.7))
  expect_is(aux_skewness(10,0.3),'numeric')
})

test_that("test aux_kurtosis works",{
  expect_length(aux_kurtosis(10,0.3),1)
  expect_equal(aux_kurtosis(10,0.3),(1-6*0.3*0.7)/(10*0.3*0.7))
  expect_is(aux_kurtosis(10,0.3),'numeric')
})

