data {
  int<lower=0> N;
  vector[N] x1;
  vector[N] y;
}
parameters {
  real alpha;
  real beta1;
  real<lower=0> sigma;
}
model {
  alpha ~ normal(0, 50);
  beta1 ~ normal(0, 10);
  sigma ~ cauchy(0, 10);
  y ~ normal(alpha + beta1 * x1, sigma);
}
generated quantities {
  vector[N] log_lik;
  vector[N] y_rep;
  for (n in 1:N) {
    real mu_n = alpha + beta1 * x1[n];
    log_lik[n] = normal_lpdf(y[n] | mu_n, sigma);
    y_rep[n] = normal_rng(mu_n, sigma);
  }
}
