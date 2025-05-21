# --- 0. Setup & Data ---
heights <- c(169.6, 166.8, 157.1, 181.1, 158.4, 165.6, 166.7, 156.5, 168.1, 165.3)
n <- length(heights)
sample_mean_x_bar <- mean(heights)
sigma2_pop <- 50 # Known population variance (sigma^2)

cat("Sample size (n):", n, "\n")
cat("Sample mean (x_bar):", round(sample_mean_x_bar, 2), "cm\n")
cat("Known population variance (sigma^2):", sigma2_pop, "cm^2\n")

# --- 1. Likelihood Parameters ---
# The likelihood for mu is N(x_bar, sigma^2/n)
mean_likelihood <- sample_mean_x_bar
var_likelihood <- sigma2_pop / n
sd_likelihood <- sqrt(var_likelihood)

cat("Likelihood for mu: N(mean =", round(mean_likelihood, 2), ", variance =", round(var_likelihood, 2), ")\n")

# --- 2. Individual 1 ---
# Prior 1: N(165, variance=4)
mu0_1 <- 165
tau0_sq_1 <- 4 # Prior variance (2^2)
sd0_1 <- sqrt(tau0_sq_1)

# Posterior 1 calculations
# Precision = 1 / variance
prec_prior1 <- 1 / tau0_sq_1
prec_likelihood <- n / sigma2_pop # which is 1 / var_likelihood

prec_post1 <- prec_prior1 + prec_likelihood
tau_post_sq_1 <- 1 / prec_post1
sd_post_1 <- sqrt(tau_post_sq_1)

mu_post1 <- tau_post_sq_1 * ( (mu0_1 / tau0_sq_1) + (sample_mean_x_bar * n / sigma2_pop) )
# Alternative for mu_post1 (weighted average):
# mu_post1 <- (prec_prior1 * mu0_1 + prec_likelihood * sample_mean_x_bar) / prec_post1

cat("\n--- Individual 1 ---\n")
cat("Prior 1: N(mean =", mu0_1, ", variance =", tau0_sq_1, ")\n")
cat("Posterior 1: N(mean =", round(mu_post1, 2), ", variance =", round(tau_post_sq_1, 2), ")\n")

# --- 3. Individual 2 ---
# Prior 2: N(170, variance=9)
mu0_2 <- 170
tau0_sq_2 <- 9 # Prior variance (3^2)
sd0_2 <- sqrt(tau0_sq_2)

# Posterior 2 calculations
prec_prior2 <- 1 / tau0_sq_2
# prec_likelihood is the same as above

prec_post2 <- prec_prior2 + prec_likelihood
tau_post_sq_2 <- 1 / prec_post2
sd_post_2 <- sqrt(tau_post_sq_2)

mu_post2 <- tau_post_sq_2 * ( (mu0_2 / tau0_sq_2) + (sample_mean_x_bar * n / sigma2_pop) )

cat("\n--- Individual 2 ---\n")
cat("Prior 2: N(mean =", mu0_2, ", variance =", tau0_sq_2, ")\n")
cat("Posterior 2: N(mean =", round(mu_post2, 2), ", variance =", round(tau_post_sq_2, 2), ")\n")


# --- 4. Plotting ---

# Define a range for mu for plotting
mu_min_plot <- min(mu0_1 - 4*sd0_1, mu0_2 - 4*sd0_2, mean_likelihood - 4*sd_likelihood, 
                   mu_post1 - 4*sd_post_1, mu_post2 - 4*sd_post_2, 150)
mu_max_plot <- max(mu0_1 + 4*sd0_1, mu0_2 + 4*sd0_2, mean_likelihood + 4*sd_likelihood,
                   mu_post1 + 4*sd_post_1, mu_post2 + 4*sd_post_2, 185)
mu_values <- seq(mu_min_plot, mu_max_plot, length.out = 500)

# Likelihood density (same for both individuals)
likelihood_density_vals <- dnorm(mu_values, mean = mean_likelihood, sd = sd_likelihood)

# --- Plot for Individual 1 ---
prior1_density_vals <- dnorm(mu_values, mean = mu0_1, sd = sd0_1)
posterior1_density_vals <- dnorm(mu_values, mean = mu_post1, sd = sd_post_1)

# Determine y-axis limits for plot 1
ymax1 <- max(prior1_density_vals, likelihood_density_vals, posterior1_density_vals) * 1.1

plot(mu_values, prior1_density_vals, type = "l", col = "blue", lwd = 2,
     xlab = "Mean Height µ (cm)", ylab = "Density",
     main = "Individual 1: Prior, Likelihood, and Posterior for µ",
     ylim = c(0, ymax1),
     cex.main=0.9)
lines(mu_values, likelihood_density_vals, col = "red", lwd = 2, lty = 2)
lines(mu_values, posterior1_density_vals, col = "darkgreen", lwd = 2)
abline(v = mean_likelihood, col="red", lty=3, lwd=0.8)
abline(v = mu0_1, col="blue", lty=3, lwd=0.8)
abline(v = mu_post1, col="darkgreen", lty=3, lwd=0.8)

legend_text1 <- c(
  paste0("Prior 1"),
  paste0("Likelihood"),
  paste0("Posterior 1:")
)
legend("topright", legend = legend_text1,
       col = c("blue", "red", "darkgreen"), lwd = 2, lty = c(1, 2, 1), cex = 0.7)

# --- Plot for Individual 2 ---
prior2_density_vals <- dnorm(mu_values, mean = mu0_2, sd = sd0_2)
posterior2_density_vals <- dnorm(mu_values, mean = mu_post2, sd = sd_post_2)

# Determine y-axis limits for plot 2
ymax2 <- max(prior2_density_vals, likelihood_density_vals, posterior2_density_vals) * 1.1

plot(mu_values, prior2_density_vals, type = "l", col = "blue", lwd = 2,
     xlab = "Mean Height µ (cm)", ylab = "Density",
     main = "Individual 2: Prior, Likelihood, and Posterior for µ",
     ylim = c(0, ymax2),
     cex.main=0.9)
lines(mu_values, likelihood_density_vals, col = "red", lwd = 2, lty = 2)
lines(mu_values, posterior2_density_vals, col = "purple", lwd = 2)
abline(v = mean_likelihood, col="red", lty=3, lwd=0.8)
abline(v = mu0_2, col="blue", lty=3, lwd=0.8)
abline(v = mu_post2, col="purple", lty=3, lwd=0.8)


legend_text2 <- c(
  paste0("Prior 2"),
  paste0("Likelihood"),
  paste0("Posterior 2")
)
legend("topright", legend = legend_text2,
       col = c("blue", "red", "purple"), lwd = 2, lty = c(1, 2, 1), cex = 0.7)

