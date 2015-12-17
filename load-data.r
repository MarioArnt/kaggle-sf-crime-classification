# Load the training set
train <- read_csv("datasets/train.csv", col_types = list(
  Dates = col_character()
))
