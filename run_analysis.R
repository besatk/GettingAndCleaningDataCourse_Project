
#++++++++++++++++++++++++++++++++++++++++++++++++++PART_1+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#setting working directory to train data path
  setwd("./train")

#reading train data
  train_data<-read.table("X_train.txt")
  train_data_labels<-read.table("Y_train.txt")
  train_data_subjects<-read.table("subject_train.txt")


#setting working directory to test data path
  setwd("../test")

#reading test data
  test_data<-read.table("X_test.txt");
  test_data_labels<-read.table("Y_test.txt")
  test_data_subjects<-read.table("subject_test.txt")

   
#merging train and test data
  merged_data<-rbind(train_data,test_data)
  
#++++++++++++++++++++++++++++++++++++++++++++++++++PART_2+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++  

#setting working directory to specific data path
  setwd("../")
  features<-read.table("features.txt");
  mean_cols<-grep("mean", features[,2],value=F)  
  sd_cols<-grep("std", features[,2],value=F) 
  merged_data_mean_sdt<-merged_data[,c(mean_cols,sd_cols)]
  
  
#++++++++++++++++++++++++++++++++++++++++++++++++++PART_3+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  
  merged_labels<-rbind(train_data_labels,test_data_labels)
  merged_subjects<-rbind(train_data_subjects,test_data_subjects)
 
  activity_labels<-read.table("activity_labels.txt")
  
  colnames(activity_labels)<-c("code","descp")
  colnames(merged_labels)<-c("cde")
  colnames(merged_subjects)<-c("subject")
  
#++++++++++++++++++++++++++++++++++++++++++++++++++PART_4+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  merged_data_mean_sdt_labled_subjects<-cbind(merged_data_mean_sdt,merged_labels,merged_subjects);
    
  merged_data_mean_sdt_labled_subjects_des<-merge(merged_data_mean_sdt_labled_subjects,
                                            activity_labels,by.x="cde",by.y="code",x.all=F,y.all=F)
 
#++++++++++++++++++++++++++++++++++++++++++++++++++PART_5+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  new_tidy_data<-aggregate(x = merged_data_mean_sdt_labled_subjects_des[,c(2:80)], 
        by = list(subj_grp=merged_data_mean_sdt_labled_subjects_des$subject,
             actv_grp=merged_data_mean_sdt_labled_subjects_des$descp)
        ,FUN = "mean")

    
 #  writing tidy  data into a file
  write.table(new_tidy_data,"new_tidy_data.txt",col.names=TRUE,row.names=FALSE) 
 
