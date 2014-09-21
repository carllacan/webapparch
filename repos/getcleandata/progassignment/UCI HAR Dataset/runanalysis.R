runanalysis <- function(){
  
  # Obtain the names of the features and the activities
  fnames <- read.table('features.txt', colClasses = "character")[,2]
  anames <- read.table('activity_labels.txt', colClasses ="character")[,2]
  
  # Obtain the test data
  xtest <- read.table('test//X_test.txt')
  ytest <- read.table('test//y_test.txt')
  idtest <- read.table('test//subject_test.txt')
  test = data.frame(idtest, ytest, xtest)
  
  # Obtain the training data
  xtrain <- read.table('train//X_train.txt')
  ytrain <- read.table('train//y_train.txt')
  idtrain <- read.table('train//subject_train.txt')
  train = data.frame(idtrain, ytrain, xtrain)
  
  # Merge both data sets
  merged <- rbind(test, train)
  # Name the columns
  colnames(merged) <- c('subject', 'activity', fnames)
  # Label the rows
  merged$activity <- sapply(merged$activity, function(a) anames[[a]])
  # Extract means and standard derivations
  extract <- which(sapply(colnames(merged), function(n) grepl("mean\\(|std\\(|subject|activity", n)))
  reduced <- merged[, extract]
  
  # Split the data in a list of 30 elements, one for each subject
  sbjdata <- split(reduced[,], reduced$subject)
  # Further split each one of the 30 elements in a list of 6 elements, one for each activity
  sbjacts <- lapply(sbjdata, function(sbj) split(sbj[3:ncol(reduced)], sbj$activity))
  # Take the mean of every feature for every activity and for every subject
  tidy <- lapply(sbjacts, function(sbj) lapply(sbj, lapply, mean))  
  
  # tidy is a list of 30 elements, one for each subject. Every element is a list of 
  # 6 named elements, one for each activity. Each of these elements is a list of the
  # averages of every feature, for every activity, for every subject.
  write.table(tidy, 'tidy.txt', row.names=FALSE)
  
}