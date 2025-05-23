//
// This Stan program defines a simple model, with a
// vector of values 'y' modeled as normally distributed
// with mean 'mu' and standard deviation 'sigma'.
//
// Learn more about model development with Stan at:
//
//    http://mc-stan.org/users/interfaces/rstan.html
//    https://github.com/stan-dev/rstan/wiki/RStan-Getting-Started
//
// logistic_regression.stan
data {
  int<lower=0> N;                 // Number of observations
  vector[N] x;                    // Predictor vector
  array[N] int<lower=0,upper=1> y; // Binary outcome vector (0 or 1)
}
parameters {
  real alpha;
  real beta;
}
model {
  alpha ~ normal(0, 5);
  beta ~ normal(0, 2.5);
  y ~ bernoulli_logit(alpha + beta * x);
}
generated quantities {
  vector[N] y_rep;
  vector[N] prob_rep;
  vector[N] log_lik;
  for (n in 1:N) {
    real eta_n = alpha + beta * x[n];
    prob_rep[n] = inv_logit(eta_n);
    y_rep[n] = bernoulli_rng(prob_rep[n]);
    log_lik[n] = bernoulli_logit_lpmf(y[n] | eta_n);
  }
} 
