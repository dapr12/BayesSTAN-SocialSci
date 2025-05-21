
# Bayesian Linear Regression with Stan - R Script

# Load libraries
library(rstan)
library(bayesplot)
library(ggplot2)
library(dplyr)

# Set options
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())

# Simulate data
alpha_true <- 10
beta_true  <- 2.5
sigma_true <- 5
N <- 100

set.seed(42)
x <- rnorm(N, mean = 60, sd = 10)
y_deterministic <- alpha_true + beta_true * x
y <- rnorm(N, mean = y_deterministic, sd = sigma_true)
sim_data <- data.frame(x = x, y = y)

# Plot simulated data
ggplot(sim_data, aes(x = x, y = y)) +
  geom_point(alpha = 0.7) +
  geom_abline(intercept = alpha_true, slope = beta_true, color = "blue", linetype = "dashed", size=1) +
  labs(title = "Simulated Data with True Regression Line",
       x = "Predictor (x)", y = "Outcome (y)") +
  theme_minimal()

# Prepare data for Stan
stan_data <- list(
  N = N,
  x = sim_data$x,
  y = sim_data$y
)


# Compile Stan model
model_compiled <- stan_model(file = "linear_regression.stan")

# Fit model
fit <- sampling(
  object = model_compiled,
  data = stan_data,
  iter = 2000,
  warmup = 1000,
  chains = 4,
  seed = 123,
  refresh = 0
)

# Print summary
print(fit, pars = c("alpha", "beta", "sigma"), probs = c(0.025, 0.5, 0.975))

# Trace plots
mcmc_trace(fit, pars = c("alpha", "beta", "sigma")) +
  ggtitle("Trace Plots for Parameters")

# Posterior density plots
mcmc_dens_overlay(fit, pars = c("alpha", "beta", "sigma")) +
  ggtitle("Posterior Density Overlays")

mcmc_areas(fit, pars = c("alpha", "beta", "sigma"), prob = 0.95) +
  ggtitle("Posterior Densities with 95% Credible Intervals")

# Posterior predictive checks
posterior_draws <- extract(fit)
y_rep_matrix <- posterior_draws$y_rep

color_scheme_set("brightblue")

#ppc_dens_overlay(y = sim_data$y, yrep = y_rep_matrix[1:50, ]) +
#  ggtitle("Posterior Predictive Check: Density Overlay")

#ppc_stat(y = sim_data$y, yrep = y_rep_matrix, stat = "mean") +
#  ggtitle("PPC for Mean of y")

#ppc_stat(y = sim_data$y, yrep = y_rep_matrix, stat = "sd") +
#  ggtitle("PPC for SD of y")

# Posterior regression lines
alpha_samples <- posterior_draws$alpha
beta_samples <- posterior_draws$beta

p <- ggplot(sim_data, aes(x = x, y = y)) +
  geom_point(alpha = 0.5) +
  labs(title = "Data with Posterior Regression Lines", x = "Predictor (x)", y = "Outcome (y)") +
  theme_minimal()

num_lines_to_plot <- 100
num_available_samples <- length(alpha_samples)
sample_indices <- sample(num_available_samples, min(num_lines_to_plot, num_available_samples))

for (i in sample_indices) {
  p <- p + geom_abline(intercept = alpha_samples[i], slope = beta_samples[i], color = "grey60", alpha = 0.2)
}

p <- p + geom_abline(intercept = mean(alpha_samples), slope = mean(beta_samples), color = "red", size = 1)
p <- p + geom_abline(intercept = alpha_true, slope = beta_true, color = "blue", linetype = "dashed", size = 1)

print(p)

# Q4.1: 90% credible interval
print(fit, pars = "beta", probs = c(0.05, 0.95))

# Q4.2: Probability beta > 2.0
beta_posterior_samples <- extract(fit)$beta
prob_beta_gt_2 <- mean(beta_posterior_samples > 2.0)
print(paste("Probability that beta > 2.0:", round(prob_beta_gt_2, 3)))
