# Bayesian Modeling and Inference: An Introduction to STAN for the Social Sciences

## Overview
This repository contains materials for the **"Bayesian Modeling and Inference: An Introduction to STAN for the Social Sciences"** workshop. It includes setup instructions, example code, and resources to help social science researchers implement Bayesian models using STAN in R.

## Table of Contents
1. [Getting Started](#getting-started)
2. [Software Installation](#software-installation)
3. [Course Outline](#course-outline)
4. [Running Your First STAN Model](#running-your-first-stan-model)
5. [Additional Resources](#additional-resources)

---

## Getting Started

To begin, download the materials from this repository:

1. Click the green **"Code"** button at the top right.
2. Select **"Download ZIP"** and extract the files.
3. Open RStudio and set your working directory to the extracted folder.

---

## Software Installation

### Required Software:
- **R** ([Download here](https://cran.r-project.org/))
- **RStudio** ([Download here](https://posit.co/download/rstudio-desktop/))
- **RStan** (STAN interface for R)

### Installing RStan

#### **For Mac Users**
1. Install **Xcode Command Line Tools**:
   ```bash
   xcode-select --install
   ```
2. Install **R** and **RStudio**.
3. Install the required R packages:
   ```r
   install.packages("rstan", dependencies = TRUE)
   ```
4. Verify installation:
   ```r
   example(stan_model, package = "rstan", run.dontrun = TRUE)
   ```

#### **For Windows Users**
1. Install **R** and **RStudio**.
2. Install **Rtools** ([Download here](https://cran.r-project.org/bin/windows/Rtools/)).
3. Add Rtools to your system path:
   ```r
   writeLines('PATH="${RTOOLS40_HOME}\\usr\\bin;${PATH}"', con = "~/.Renviron")
   ```
   Restart R after running this command.
4. Install the required R packages:
   ```r
   install.packages("rstan", dependencies = TRUE)
   ```
5. Verify installation:
   ```r
   example(stan_model, package = "rstan", run.dontrun = TRUE)
   ```

---

## Course Outline

1. **Introduction to Bayesian Modeling**
   - Why use Bayesian methods?
   - Bayesian inference principles

2. **STAN and RStan Basics**
   - Introduction to STAN
   - Writing Bayesian models in RStan

3. **Hands-on Bayesian Modeling**
   - Implementing regression models
   - Interpreting posterior distributions

4. **Advanced Topics**
   - Hierarchical modeling
   - Model evaluation and diagnostics

---

## Running Your First STAN Model

Once **RStan** is installed, try running a simple STAN model:

```r
library(rstan)

# Example model
model_code <- "
  data {
    int<lower=0> N;
    vector[N] x;
    vector[N] y;
  }
  parameters {
    real alpha;
    real beta;
    real<lower=0> sigma;
  }
  model {
    y ~ normal(alpha + beta * x, sigma);
  }
"

# Compile the model
stan_model <- stan_model(model_code = model_code)
```

---

## Additional Resources

- **STAN Documentation**: [mc-stan.org](https://mc-stan.org/users/documentation/)
- **RStan Installation Guide**: [GitHub RStan Wiki](https://github.com/stan-dev/rstan/wiki/RStan-Getting-Started)
- **Bayesian Data Analysis (Gelman et al.)**: A foundational text for Bayesian modeling
- **INLA for Bayesian Analysis**: [INLA Installation](https://www.r-inla.org/download-install)

---

### License
This repository is released under the [MIT License](LICENSE).

---
