# Bayesian Modeling and Inference: An Introduction to STAN for the Social Sciences

Diego Perez Ruiz
<diego.perezruiz@manchester.ac.uk>

*May, 2025*

## Abstract

Bayesian methods for inference and prediction have gained significant traction in the social sciences, transitioning from a niche methodology with steep computational barriers to a widely accessible approach supported by user-friendly tools. Today, researchers can implement sophisticated Bayesian models using standard statistical software and generic computing resources. Yet, for many newcomers, the entry into Bayesian analysis remains challenging—raising questions about when and why to use Bayesian methods, how to interpret results, and what software to adopt.

This workshop,  **"Bayesian Modeling and Inference: An Introduction to STAN for the Social Sciences"**, is designed to guide participants through these initial hurdles. It introduces the key concepts of Bayesian inference in contrast to classical (frequentist) approaches, outlines the logic and structure of the Bayesian workflow, and provides hands-on experience with the R package brms, a high-level interface to Stan, a powerful probabilistic programming language. By working through practical examples and real-world applications, participants will learn how to specify, estimate, and interpret Bayesian models using accessible tools and modern algorithms—all within the R environment.



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
- **INLA for Bayesian Analysis**: [INLA Installation](https://www.r-inla.org/download-install)

---

## About the Instructor

Dr Diego Perez Ruiz is a Lecturer in Quantitative Social Science at the University of Manchester, where he teaches statistical methods and computational tools for the social sciences. His research bridges methodological innovation and substantive inquiry, with interests in Bayesian modeling, survey methodology, and data integration. Diego has extensive experience applying advanced statistical techniques to social science questions, particularly in the areas of public opinion, policy evaluation, and demographic analysis. As an educator, he is committed to making complex quantitative methods accessible to researchers through clear, hands-on instruction and reproducible workflows using R and Stan.


---

## References  

1. **Gelman, A., Carlin, J. B., Stern, H. S., Dunson, D. B., Vehtari, A., & Rubin, D. B. (2013).**  
   *Bayesian Data Analysis* (3rd ed.). CRC Press.  
   [Available here](https://sites.stat.columbia.edu/gelman/book/BDA3.pdf)  

2. **Vehtari, A., Gelman, A., & Gabry, J. (2017).**   
   *Practical Bayesian Model Evaluation Using Leave-One-Out Cross-Validation and WAIC.*   
   Statistics and Computing, 27(5), 1413–1432.  
   [DOI: 10.1007/s11222-016-9696-4](https://doi.org/10.1007/s11222-016-9696-4)  

3. **Stan Development Team (2024).**   
   *Stan: A Probabilistic Programming Language.*   
   [https://mc-stan.org](https://mc-stan.org)  

4. **Stan Development Team (2024).**   
   *RStan: The R Interface to Stan.*   
   [GitHub Repository](https://github.com/stan-dev/rstan) | [Installation Guide](https://github.com/stan-dev/rstan/wiki/RStan-Getting-Started)  

5. **McElreath, R. (2020).**  
   *Statistical Rethinking: A Bayesian Course with Examples in R and STAN* (2nd ed.). CRC Press.  
   [Book Website](https://xcelab.net/rm/statistical-rethinking/)  

6. **Brooks, S., Gelman, A., Jones, G., & Meng, X.-L. (Eds.). (2011).**  
   *Handbook of Markov Chain Monte Carlo.* CRC Press.  
   [Book on CRC Press](https://www.crcpress.com/Handbook-of-Markov-Chain-Monte-Carlo/Brooks-Gelman-Jones-Meng/p/book/9781420079425)  

7. **Carpenter, B., Gelman, A., Hoffman, M. D., Lee, D., Goodrich, B., Betancourt, M., Brubaker, M. A., Guo, J., Li, P., & Riddell, A. (2017).**   
   *Stan: A Probabilistic Programming Language.*   
   Journal of Statistical Software, 76(1), 1–32.  
   [DOI: 10.18637/jss.v076.i01](https://doi.org/10.18637/jss.v076.i01)  


---

### License
This repository is released under the [MIT License](LICENSE).

---
