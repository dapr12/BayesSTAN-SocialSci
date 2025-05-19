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
  alpha ~ normal(0, 10);
  beta ~ normal(0, 10);
  y ~ bernoulli_logit(alpha + beta * x);
}
