
library(rstan)
library(bayesplot)
library(ggplot2)
library(dplyr)
library(loo)

rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())

set.seed(789)
N_mc <- 150
alpha_true_mc <- 5
beta1_true_mc <- 1.5
beta2_true_mc <- 0.0
sigma_true_mc <- 3

x1_mc <- rnorm(N_mc, 10, 2)
x2_mc <- rnorm(N_mc, 5, 3)
y_mc <- rnorm(N_mc, alpha_true_mc + beta1_true_mc * x1_mc, sigma_true_mc)

sim_data_mc <- data.frame(x1 = x1_mc, x2 = x2_mc, y = y_mc)
pairs(sim_data_mc)

stan_data_m1 <- list(N = N_mc, x1 = sim_data_mc$x1, y = sim_data_mc$y)
model_m1_compiled <- stan_model(file = "linear_model_x1.stan")
fit_m1 <- sampling(model_m1_compiled, data = stan_data_m1, iter = 2000, warmup = 1000, chains = 4, seed = 111)

stan_data_m2 <- list(N = N_mc, x1 = sim_data_mc$x1, x2 = sim_data_mc$x2, y = sim_data_mc$y)
model_m2_compiled <- stan_model(file = "linear_model_x1_x2.stan")
fit_m2 <- sampling(model_m2_compiled, data = stan_data_m2, iter = 2000, warmup = 1000, chains = 4, seed = 222)

print(fit_m1, pars = c("alpha", "beta1", "sigma"), digits = 3)
print(fit_m2, pars = c("alpha", "beta1", "beta2", "sigma"), digits = 3)

log_lik_m1 <- extract_log_lik(fit_m1, parameter_name = "log_lik", merge_chains = TRUE)
log_lik_m2 <- extract_log_lik(fit_m2, parameter_name = "log_lik", merge_chains = TRUE)
dim(log_lik_m1)
dim(log_lik_m2)

loo_m1 <- loo(log_lik_m1)
loo_m2 <- loo(log_lik_m2)
print(loo_m1)
print(loo_m2)

plot(loo_m1, label_points = TRUE)
plot(loo_m2, label_points = TRUE)

waic_m1 <- waic(log_lik_m1)
waic_m2 <- waic(log_lik_m2)
print(waic_m1)
print(waic_m2)

comp_loo <- loo_compare(loo_m1, loo_m2)
print(comp_loo)