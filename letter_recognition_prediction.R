
R version 4.2.1 (2022-06-23 ucrt) -- "Funny-Looking Kid"
Copyright (C) 2022 The R Foundation for Statistical Computing
Platform: x86_64-w64-mingw32/x64 (64-bit)

R is free software and comes with ABSOLUTELY NO WARRANTY.
You are welcome to redistribute it under certain conditions.
Type 'license()' or 'licence()' for distribution details.

  Natural language support but running in an English locale

R is a collaborative project with many contributors.
Type 'contributors()' for more information and
'citation()' on how to cite R or R packages in publications.

Type 'demo()' for some demos, 'help()' for on-line help, or
'help.start()' for an HTML browser interface to help.
Type 'q()' to quit R.

[Previously saved workspace restored]

> letters= read.csv ("letters_ABPR.csv")
> str (letters)
'data.frame':   3116 obs. of  17 variables:
 $ letter   : chr  "B" "A" "R" "B" ...
 $ xbox     : int  4 1 5 5 3 8 2 3 8 6 ...
 $ ybox     : int  2 1 9 9 6 10 6 7 14 10 ...
 $ width    : int  5 3 5 7 4 8 4 5 7 8 ...
 $ height   : int  4 2 7 7 4 6 4 5 8 8 ...
 $ onpix    : int  4 1 6 10 2 6 3 3 4 7 ...
 $ xbar     : int  8 8 6 9 4 7 6 12 5 8 ...
 $ ybar     : int  7 2 11 8 14 7 7 2 10 5 ...
 $ x2bar    : int  6 2 7 4 8 3 5 3 6 7 ...
 $ y2bar    : int  6 2 3 4 1 5 5 2 3 5 ...
 $ xybar    : int  7 8 7 6 11 8 6 10 12 7 ...
 $ x2ybar   : int  6 2 3 8 6 4 5 2 5 6 ...
 $ xy2bar   : int  6 8 9 6 3 8 7 9 4 6 ...
 $ xedge    : int  2 1 2 6 0 6 3 2 4 3 ...
 $ xedgeycor: int  8 6 7 11 10 6 7 6 10 9 ...
 $ yedge    : int  7 2 5 8 4 7 5 3 4 8 ...
 $ yedgexcor: int  10 7 11 7 8 7 8 8 8 9 ...
> letters$isB = as.factor(letters$letter == "B")
> library (caTools)
> set.seed (1000)
> spl = sample.split(letters$isB, SplitRatio = 0.5)
> train = subset (letters, spl==TRUE)
> test= subset (letters, spl==FALSE)
> table (train$isB)

FALSE  TRUE 
 1175   383 
> table (test$isB)

FALSE  TRUE 
 1175   383 
> 1175/ (1175+383)
[1] 0.754172
> CARTb = rpart(isB ~ . - letter, data=train, method="class")
Error in rpart(isB ~ . - letter, data = train, method = "class") : 
  could not find function "rpart"
> library (rpart)
> CARTb = rpart(isB ~ . - letter, data=train, method="class")
> predictions = predict(CARTb, newdata=test, type="class")
> table(test$isB, predictions)
       predictions
        FALSE TRUE
  FALSE  1118   57
  TRUE     43  340
> (1118+340)/(1118+340+57+43)
[1] 0.9358151
> set.seed (1000)
> RFb = randomForest(isB ~ . - letter, data=train)
Error in randomForest(isB ~ . - letter, data = train) : 
  could not find function "randomForest"
> library (randomForest)
randomForest 4.7-1.1
Type rfNews() to see new features/changes/bug fixes.
> RFb = randomForest(isB ~ . - letter, data=train)
> predictions = predict(RFb, newdata=test)
> table(test$isB, predictions)
       predictions
        FALSE TRUE
  FALSE  1163   12
  TRUE      9  374
> (374+1163)/(374+1163+9+12)
[1] 0.9865212
> letters$letter = as.factor( letters$letter )
> set.seed (2000)
> spl = sample.split(letters$letter, SplitRatio = 0.5)
> train2= subset (letters, spl==TRUE)
> test2= subset (letters, spl==FALSE)
> table(train2$letter)

  A   B   P   R 
394 383 402 379 
> 402/nrow(test)
[1] 0.2580231
> CARTletter = rpart(letter ~ . - isB, data=train2, method="class")
> predictLetter = predict(CARTletter, newdata=test2, type="class")
> table(test2$letter, predictLetter)
   predictLetter
      A   B   P   R
  A 348   4   0  43
  B   8 318  12  45
  P   2  21 363  15
  R  10  24   5 340
> (348+318+363+340)/nrow(test)
[1] 0.8786906
> set.seed(1000)
> RFletter= randomForest (letter ~. - isB, data=train2)
> predictLetter= predict (RFletter, data= test2)
> predictLetter= predict (RFletter, newdata= test2)
> table (test2$letter, predictLetter)
   predictLetter
      A   B   P   R
  A 391   0   3   1
  B   0 380   1   2
  P   0   6 394   1
  R   3  14   0 362
> (391+380+394+362)/nrow(test)
[1] 0.9801027
> 
