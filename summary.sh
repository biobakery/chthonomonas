#! /usr/bin/sh

# for T49
# number of T49 proteins that aren't covered in P488
printf "T49, notP488\t"
grep T49 stats.txt | cut -f 2 | awk '!NF {s+=1} END {print s}' 
printf "T49 notTKA\t"
# number of T49 proteins that aren't covered in TKA
grep T49 stats.txt | cut -f 3 | awk '!NF {s+=1} END {print s}' 
printf "T49, notWRG\t"
# number ofT49 proteins that aren't covered in WRG
grep T49 stats.txt | cut -f 4 | awk '!NF {s+=1} END {print s}'
printf "T49, notT49\t"
# number of MUC1 proteins that aren't covered in T49
grep T49 stats.txt | cut -f 5 | awk '!NF {s+=1} END {print s}'  

#for P488
# number of P488 proteins that aren't covered in P488
printf "P488, notP488\t"
grep P488 stats.txt | cut -f 2 | awk '!NF {s+=1} END {print s}' 
printf "P488 notTKA\t"
# number of T49 proteins that aren't covered in TKA
grep P488 stats.txt | cut -f 3 | awk '!NF {s+=1} END {print s}' 
printf "P488, notWRG\t"
# number ofT49 proteins that aren't covered in WRG
grep P488 stats.txt | cut -f 4 | awk '!NF {s+=1} END {print s}'
printf "P488, notT49\t"
# number of MUC1 proteins that aren't covered in T49
grep P488 stats.txt | cut -f 5 | awk '!NF {s+=1} END {print s}'  

#for TKA
# number of P488 proteins that aren't covered in P488
printf "TKA, notP488\t"
grep TKA stats.txt | cut -f 2 | awk '!NF {s+=1} END {print s}' 
printf "TKA notTKA\t"
# number of T49 proteins that aren't covered in TKA
grep TKA stats.txt | cut -f 3 | awk '!NF {s+=1} END {print s}' 
printf "TKA, notWRG\t"
# number ofT49 proteins that aren't covered in WRG
grep TKA stats.txt | cut -f 4 | awk '!NF {s+=1} END {print s}'
printf "TKA, notT49\t"
# number of MUC1 proteins that aren't covered in T49
grep TKA stats.txt | cut -f 5 | awk '!NF {s+=1} END {print s}'  

#for WRG
# number of P488 proteins that aren't covered in P488
printf "WRG, notP488\t"
grep WRG stats.txt | cut -f 2 | awk '!NF {s+=1} END {print s}' 
printf "WRG notTKA\t"
# number of T49 proteins that aren't covered in TKA
grep WRG stats.txt | cut -f 3 | awk '!NF {s+=1} END {print s}' 
printf "WRG notWRG\t"
# number ofT49 proteins that aren't covered in WRG
grep WRG stats.txt | cut -f 4 | awk '!NF {s+=1} END {print s}'
printf "WRG, notT49\t"
# number of MUC1 proteins that aren't covered in T49
grep WRG stats.txt | cut -f 5 | awk '!NF {s+=1} END {print s}'  

printf "Total T49 genes:"
grep T49 last-table | wc

printf "Total T49 genes after filter:"
grep T49 stats.txt | wc

printf "Total P488 genes:"
grep P488 last-table | wc

printf "Total P488 genes after filter:"
grep P488 stats.txt | wc

printf "Total WRG genes:"
grep WRG last-table | wc

printf "Total WRG genes after filter:"
grep WRG stats.txt | wc

printf "Total TKA genes:"
grep TKA last-table | wc

printf "Total TKA genes after filter:"
grep TKA stats.txt | wc

#for WRG
# number of P488 proteins that aren't covered in P488
printf "WRG, notP488\t"
grep WRG stats.txt | cut -f 2 | awk '!NF {s+=1} END {print s}' 
printf "WRG notTKA\t"
# number of T49 proteins that aren't covered in TKA
grep WRG stats.txt | cut -f 3 | awk '!NF {s+=1} END {print s}' 
printf "WRG notWRG\t"
# number ofT49 proteins that aren't covered in WRG
grep WRG stats.txt | cut -f 4 | awk '!NF {s+=1} END {print s}'
printf "WRG, notT49\t"
# number of MUC1 proteins that aren't covered in T49
grep WRG stats.txt | cut -f 5 | awk '!NF {s+=1} END {print s}' 

printf "WRG above 0"
grep WRG last-table | cut -f 7  | awk '$1 > 1 {print}' | wc

printf "WRG above 1"
grep WRG last-table | cut -f 7  | awk '$1 > 1 {print}' | wc

printf "WRG above IQR "
grep WRG last-table | cut -f 7  | awk '$1 > 17 {print}' | wc

printf "TKA above 0"
grep TKA last-table | cut -f 5  | awk '$1 > 1 {print}' | wc

printf "TKA above 1"
grep TKA last-table | cut -f 5  | awk '$1 > 1 {print}' | wc

printf "TKA above IQR "
grep TKA last-table | cut -f 5  | awk '$1 > 12 {print}' | wc

printf "P488 above 0"
grep P488 last-table | cut -f 3  | awk '$1 > 1 {print}' | wc

printf "P488 above 1"
grep P488 last-table | cut -f 3  | awk '$1 > 1 {print}' | wc

printf "P488 above IQR "
grep P488 last-table | cut -f 3  | awk '$1 > 35 {print}' | wc

printf "T49 above 0"
grep T49 last-table | cut -f 9  | awk '$1 > 1 {print}' | wc

printf "T49 above 1"
grep T49 last-table | cut -f 9  | awk '$1 > 1 {print}' | wc