# Worker Payment Slip Generator

## Description
This project generates payment slips for 400 workers dynamically using Python and R. It assigns employee levels based on specified conditions and handles potential errors.

## Requirements

- Python 3.x
- R
- Required libraries: `random`, `json`, `jsonlite`

## Instructions

### Python

1. Install the required libraries:
`pip install random`
`pip install csv`
`pip install names`


2. Run the `worker_payment.py` script:
python worker_payment.py


3. The generated payment slips will be saved in `payment_slips.csv`.

### R

1. Install the required libraries:
install.packages("randomNames")
install.packages("dplyr")


2. Run the `worker_payment.R` script:
Rscript worker_payment.R


3. The generated payment slips will be saved in `payment_slips.json`.

## Files

- `worker_payment.py`: Python script to generate payment slips.
- `worker_payment.R`: R script to generate payment slips.
- `payment_slips.csv`: Output file with generated payment slips.
- `README.md`: Instructions on how to use the code.




