data {
  int<lower=0> N;
  array[N] int<lower=0, upper=1> y;
  array[N] real x;
}
parameters {
  real alpha;
  real beta;
}
model {
  alpha ~ normal(0, 10);
  beta ~ normal(0, 10);
  for (n in 1:N) {
    y[n] ~ bernoulli_logit(alpha + beta * x[n]);
  }
}
generated quantities {
  array[N] real log_lik;
  for (n in 1:N) {
    log_lik[n] = bernoulli_logit_lpmf(y[n] | alpha + beta * x[n]);
  }
}
