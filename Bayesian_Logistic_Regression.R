
# Bayesian Logistic Regression Tutorial - R Script

# Load required libraries
library(rstan)
library(bayesplot)
library(ggplot2)
library(dplyr)
library(pROC)

# Set rstan options
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())

# Simulate data
alpha_true_logodds <- -2.0
beta_true_logodds  <- 0.75
N_logistic         <- 200

set.seed(123)
x_logistic <- rnorm(N_logistic, mean = 5, sd = 2)
eta_logodds <- alpha_true_logodds + beta_true_logodds * x_logistic
prob_y_eq_1 <- 1 / (1 + exp(-eta_logodds))
y_logistic <- rbinom(N_logistic, size = 1, prob = prob_y_eq_1)

sim_data_logistic <- data.frame(x = x_logistic, y = y_logistic, prob = prob_y_eq_1)

# Visualize simulated data
ggplot(sim_data_logistic, aes(x = x)) +
  geom_line(aes(y = prob), color = "blue", size = 1) +
  geom_jitter(aes(y = y), width = 0, height = 0.05, alpha = 0.5, size=2) +
  labs(title = "Simulated Data for Logistic Regression",
       subtitle = "Blue line: True probability P(y=1)",
       x = "Predictor (x)", y = "Outcome (y) / Probability P(y=1)") +
  theme_minimal()

# Prepare data for Stan
stan_data_logistic <- list(
  N = N_logistic,
  x = sim_data_logistic$x,
  y = sim_data_logistic$y
)


# Compile and fit the model
model_logistic_compiled <- stan_model(file = "logistic_regression.stan")

fit_logistic <- sampling(
  object = model_logistic_compiled,
  data = stan_data_logistic,
  iter = 2000,
  warmup = 1000,
  chains = 4,
  seed = 456,
  refresh = 0
)

# Summary of model
print(fit_logistic, pars = c("alpha", "beta"), probs = c(0.025, 0.5, 0.975))

# Trace and density plots
mcmc_trace(fit_logistic, pars = c("alpha", "beta")) +
  ggtitle("Trace Plots for Logistic Regression Parameters")

mcmc_dens_overlay(fit_logistic, pars = c("alpha", "beta")) +
  ggtitle("Posterior Density Overlays (Logistic)")

mcmc_areas(fit_logistic, pars = c("alpha", "beta"), prob = 0.95) +
  ggtitle("Posterior Densities with 95% CIs (Logistic)")

# Posterior predictive checks
posterior_draws_logistic <- extract(fit_logistic)
y_rep_logistic_matrix <- posterior_draws_logistic$y_rep
prob_rep_logistic_matrix <- posterior_draws_logistic$prob_rep

ppc_stat(y = sim_data_logistic$y, yrep = y_rep_logistic_matrix, stat = "mean") +
  ggtitle("PPC: Proportion of Y=1 (Successes)")

df_probs_obs <- data.frame(
  prob_pred = colMeans(prob_rep_logistic_matrix),
  observed_y = as.factor(sim_data_logistic$y)
)

ggplot(df_probs_obs, aes(x = prob_pred, fill = observed_y)) +
  geom_density(alpha = 0.6) +
  labs(title = "Distribution of Mean Predicted Probabilities P(Y=1) by Observed Outcome",
       x = "Mean Posterior Predictive Probability P(Y_i=1)",
       fill = "Observed Y_i") +
  theme_minimal()

mean_pred_probs <- colMeans(prob_rep_logistic_matrix)
roc_obj <- roc(response = sim_data_logistic$y, predictor = mean_pred_probs, quiet=TRUE)
auc_value <- auc(roc_obj)

ggroc(roc_obj) + 
  geom_abline(slope=1, intercept=1, linetype="dashed", color="grey") +
  ggtitle(paste0("ROC Curve (AUC = ", round(auc_value, 3), ")")) +
  theme_minimal()

print(paste("Area Under ROC Curve (AUC):", round(auc_value, 3)))

# Odds ratio interpretation
beta_logodds_samples <- posterior_draws_logistic$beta
beta_or_samples <- exp(beta_logodds_samples)

cat("Posterior summary for beta (Odds Ratio):
")
cat("Mean OR:", round(mean(beta_or_samples), 3), "
")
cat("Median OR:", round(median(beta_or_samples), 3), "
")
cat("95% CI for OR: [", 
    round(quantile(beta_or_samples, 0.025), 3), ", ", 
    round(quantile(beta_or_samples, 0.975), 3), "]
")

beta_logodds_samples <- posterior_draws_logistic$beta
beta_or_samples <- exp(beta_logodds_samples)

# Summary of beta on odds ratio scale
cat("Posterior summary for beta (Odds Ratio):\n")
cat("Mean OR:", round(mean(beta_or_samples), 3), "\n")
cat("Median OR:", round(median(beta_or_samples), 3), "\n")
cat("95% CI for OR: [", 
    round(quantile(beta_or_samples, 0.025), 3), ", ", 
    round(quantile(beta_or_samples, 0.975), 3), "]\n")

# Plot density of OR for beta using ggplot2
ggplot(data.frame(OR_beta = beta_or_samples), aes(x = OR_beta)) +
  geom_histogram(aes(y = ..density..), bins = 30, fill = "skyblue", color = "black", alpha = 0.7) +
  geom_density(color = "darkblue", size = 1) +
  geom_vline(xintercept = 1, linetype = "dashed", color = "red", size = 1) +
  labs(title = "Posterior Distribution of Odds Ratio for Beta", 
       x = "Odds Ratio (exp(beta))",
       y = "Density") +
  theme_minimal()

x_seq <- seq(min(sim_data_logistic$x), max(sim_data_logistic$x), length.out = 100)
pred_probs_matrix <- matrix(NA, nrow = length(posterior_draws_logistic$alpha), ncol = length(x_seq))

for (i in 1:length(posterior_draws_logistic$alpha)) {
  eta_seq <- posterior_draws_logistic$alpha[i] + posterior_draws_logistic$beta[i] * x_seq
  pred_probs_matrix[i, ] <- 1 / (1 + exp(-eta_seq))
}

mean_pred_probs_curve <- colMeans(pred_probs_matrix)
lower_ci_probs_curve <- apply(pred_probs_matrix, 2, quantile, probs = 0.025)
upper_ci_probs_curve <- apply(pred_probs_matrix, 2, quantile, probs = 0.975)

pred_df <- data.frame(
  x_val = x_seq,
  mean_prob = mean_pred_probs_curve,
  lower_prob = lower_ci_probs_curve,
  upper_prob = upper_ci_probs_curve
)

ggplot(sim_data_logistic, aes(x = x, y = y)) +
  geom_jitter(width = 0, height = 0.05, alpha = 0.3, size=1.5) +
  geom_line(data = pred_df, aes(x = x_val, y = mean_prob), color = "red", size = 1) +
  geom_ribbon(data = pred_df, aes(x = x_val, ymin = lower_prob, ymax = upper_prob), 
              fill = "red", alpha = 0.2, inherit.aes = FALSE) +
  geom_line(aes(y = prob), color = "blue", linetype = "dashed", size = 1) +
  labs(title = "Posterior Predictive Probability P(Y=1) with 95% CI",
       x = "Predictor (x)", y = "P(Y=1) / Observed Y") +
  theme_minimal()
