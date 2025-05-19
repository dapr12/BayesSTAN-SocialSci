# Bayesian Modeling Course - Practical Tutorials

Welcome to the practical tutorials for the Bayesian Modeling course!

This folder contains the necessary files and instructions to work through hands-on examples of Bayesian Linear Regression and Bayesian Logistic Regression using R and Stan.

## Folder Contents:

*   **`bayesian_linear_regression_tutorial.pdf`**:
    *   A PDF document containing the full step-by-step tutorial for Bayesian Linear Regression. This includes all explanations, instructions, discussion points, and exploration questions.
*   **`bayesian_linear_regression.R`**:
    *   An R script containing all the R code presented in the `bayesian_linear_regression_tutorial.pdf`. This script is intended for you to copy-paste or run section-by-section in your R console or RStudio as you follow along with the PDF tutorial.
*   **`linear_regression.stan`**:
    *   The Stan model file required for the Bayesian Linear Regression tutorial. This file defines the model structure and is called by the `bayesian_linear_regression.R` script.

*   **`bayesian_logistic_regression_tutorial.pdf`**:
    *   A PDF document containing the full step-by-step tutorial for Bayesian Logistic Regression, including all explanations, instructions, and exploration questions.
*   **`bayesian_logistic_regression.R`**:
    *   An R script containing all the R code presented in the `bayesian_logistic_regression_tutorial.pdf`. Use this script to execute the code examples while following the PDF.
*   **`logistic_regression.stan`**:
    *   The Stan model file required for the Bayesian Logistic Regression tutorial, called by the `bayesian_logistic_regression.R` script.

## Prerequisites:

Before you begin, please ensure you have the following installed:

1.  **R:** A recent version of R (you can download it from [CRAN](https://cran.r-project.org/)).
2.  **RStudio:** RStudio Desktop (Open Source License) is highly recommended as an integrated development environment (IDE) for R (download from [RStudio's website](https://posit.co/download/rstudio-desktop/)).
3.  **R Packages:** You will need several R packages. You can install them by running the following commands in your R console:
    ```R
    install.packages(c("rstan", "bayesplot", "ggplot2", "dplyr", "pROC"))
    ```
    *   `rstan`: The R interface to Stan.
    *   `bayesplot`: For visualizing MCMC output and posterior predictive checks.
    *   `ggplot2`: For creating plots.
    *   `dplyr`: For data manipulation.
    *   `pROC`: For ROC curve analysis (used in the logistic regression tutorial).
4.  **C++ Toolchain:** Stan models are written in Stan's language but compiled to C++ for efficiency. `rstan` will usually guide you if your C++ toolchain is missing or misconfigured. For more details, see the [RStan Getting Started Guide](https://github.com/stan-dev/rstan/wiki/RStan-Getting-Started).
    *   **Windows:** Rtools.
    *   **Mac:** Xcode command line tools.
    *   **Linux:** A standard C++ compiler like g++.

## Instructions to Run the Tutorials:

1.  **Download/Clone this Folder:** Ensure you have all the files listed above in a single directory on your computer.
2.  **Open RStudio.**
3.  **Set Working Directory (Important):**
    *   In RStudio, go to `Session > Set Working Directory > Choose Directory...` and select the folder where you saved these tutorial files. This is crucial so that R can find the `.stan` model files.
4.  **Open an `.R` Tutorial Script:**
    *   Start with `bayesian_linear_regression_tutorial.R` or `bayesian_logistic_regression_tutorial.R`.
5.  **Run the Script Interactively:**
    *   The best way to work through these `.R` scripts is to run them line-by-line or section-by-section.
    *   You can do this by:
        *   Copying a line or a block of code from the script and pasting it into the R console in RStudio.
        *   Placing your cursor on a line in the script editor and pressing `Ctrl+Enter` (Windows/Linux) or `Cmd+Enter` (Mac) to send that line to the console.
    *   Read the comments in the script as they provide explanations for each step.
    *   This interactive approach allows you to see the output of each step, inspect variables in your R environment, and understand the process.
6.  **Modify and Explore:**
    *   The tutorials include "Student Exploration Questions" (usually found as comments within the `.R` scripts). These encourage you to modify the R code or the `.stan` model files.
    *   **Important:** If you modify a `.stan` file, you will need to re-run the R code line that contains `stan_model(file = "your_model_name.stan")` to recompile the Stan model before running the `sampling()` command again.
7.  **Troubleshooting Stan Compilation:**
    *   The first time you compile a Stan model (or after an RStan update), it might take a few minutes.
    *   If you encounter C++ compilation errors, double-check that your C++ toolchain is correctly installed and configured as per the RStan Getting Started guide.

## Learning Goals:

By working through these tutorials, you should gain practical experience in:

*   Defining Bayesian models in the Stan language.
*   Preparing data and fitting Stan models from R.
*   Assessing MCMC convergence using diagnostics like `Rhat` and trace plots.
*   Interpreting posterior distributions (means, medians, credible intervals).
*   Performing and interpreting posterior predictive checks to evaluate model fit.
*   Understanding how prior choices and data characteristics influence posterior inferences.
*   Specifically applying these concepts to both linear and logistic regression contexts.

I hope you find these tutorials helpful and informative! 
