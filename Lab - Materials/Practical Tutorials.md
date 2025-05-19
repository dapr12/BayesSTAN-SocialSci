# Bayesian Modeling Course - Practical Tutorials

Welcome to the practical tutorials for the Bayesian Modeling course!

This folder contains the necessary files and instructions to work through hands-on examples of Bayesian Linear Regression and Bayesian Logistic Regression using R and Stan.

## Folder Contents:

*   **`bayesian_linear_regression_tutorial.Rmd`**:
    *   An R Markdown file containing a step-by-step tutorial for Bayesian Linear Regression.
    *   It includes code for data simulation, model fitting in Stan, MCMC diagnostics, posterior predictive checks, interpretation, and exploration questions.
*   **`linear_regression.stan`**:
    *   The Stan model file required by `bayesian_linear_regression_tutorial.Rmd`. This file defines the Bayesian linear regression model.
*   **`bayesian_logistic_regression_tutorial.Rmd`**:
    *   An R Markdown file with a tutorial for Bayesian Logistic Regression.
    *   Similar structure to the linear regression tutorial but focused on binary outcomes and logit models.
*   **`logistic_regression.stan`**:
    *   The Stan model file required by `bayesian_logistic_regression_tutorial.Rmd`. This defines the Bayesian logistic regression model.
*   **`README.md`**:
    *   This file, providing an overview and instructions.

## Prerequisites:

Before you begin, please ensure you have the following installed:

1.  **R:** A recent version of R (you can download it from [CRAN](https://cran.r-project.org/)).
2.  **RStudio:** RStudio Desktop (Open Source License) is highly recommended as an integrated development environment (IDE) for R (download from [RStudio's website](https://posit.co/download/rstudio-desktop/)).
3.  **R Packages:** You will need several R packages. You can install them by running the following commands in your R console:
    ```R
    install.packages(c("rstan", "bayesplot", "ggplot2", "dplyr", "pROC", "rmarkdown"))
    ```
    *   `rstan`: The R interface to Stan.
    *   `bayesplot`: For visualizing MCMC output and posterior predictive checks.
    *   `ggplot2`: For creating plots.
    *   `dplyr`: For data manipulation.
    *   `pROC`: For ROC curve analysis (used in the logistic regression tutorial).
    *   `rmarkdown`: To knit the `.Rmd` files into HTML or PDF reports.
4.  **C++ Toolchain:** Stan models are written in Stan's language but compiled to C++ for efficiency. `rstan` will usually guide you if your C++ toolchain is missing or misconfigured. For more details, see the [RStan Getting Started Guide](https://github.com/stan-dev/rstan/wiki/RStan-Getting-Started).
    *   **Windows:** Rtools.
    *   **Mac:** Xcode command line tools.
    *   **Linux:** A standard C++ compiler like g++.

## Instructions to Run the Tutorials:

1.  **Download/Clone this Folder:** Ensure you have all the files listed above in a single directory on your computer.
2.  **Open RStudio.**
3.  **Set Working Directory (Optional but Recommended):**
    *   In RStudio, go to `Session > Set Working Directory > Choose Directory...` and select the folder where you saved these tutorial files.
    *   Alternatively, if you open one of the `.Rmd` files directly from RStudio's file pane, it often sets the working directory to the file's location.
4.  **Open an `.Rmd` Tutorial File:**
    *   Start with `bayesian_linear_regression_tutorial.Rmd` or `bayesian_logistic_regression_tutorial.Rmd`.
5.  **Knit the Document (Optional but good for viewing):**
    *   Click the "Knit" button in RStudio (it usually defaults to HTML). This will run all the R code chunks and create a formatted report with the tutorial text, code, and output. This is a good way to see the entire tutorial flow.
6.  **Run Chunks Interactively:**
    *   A more hands-on approach is to run each R code chunk individually. You can do this by:
        *   Placing your cursor inside a code chunk.
        *   Clicking the green "play" button (►) at the top right of the chunk, or using the keyboard shortcut (e.g., `Ctrl+Enter` or `Cmd+Enter`).
    *   This allows you to see the output of each step, inspect variables, and experiment.
7.  **Modify and Explore:**
    *   The tutorials include "Student Exploration Questions." These encourage you to modify the provided R code or the `.stan` model files.
    *   **Important:** If you modify a `.stan` file, you will need to re-run the R chunk that contains `stan_model(file = "your_model_name.stan")` to recompile the Stan model before running the `sampling()` command again. Often, it's easiest to restart your R session or clear the compiled model from memory if you make changes to the Stan code.
8.  **Troubleshooting Stan Compilation:**
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

We hope you find these tutorials helpful and informative!
