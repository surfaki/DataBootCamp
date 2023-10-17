import os
import csv
print(os.getcwd())
budget_filename = os.path.join('.', 'Resources', 'budget_data.csv')

with open(budget_filename, 'r') as csvfile:
    month=[]
    netTotal=0
    profitChange=[]
    greatIncProfit=0
    greatDecProfit=0

# Split the data on commas
    csvreader = csv.reader(csvfile, delimiter=',')
    next(csvreader)

    for row in csvreader:
# Split the month on "-"
        month.append(row[0].split("-")[0])
        netTotal=netTotal+int(row[1])

#Calculate the average of changes in "Profit/Losses"
        if csvreader.line_num == 2: 
            profitChange0 = int(row[1])
        profitChange1=int(row[1])
        profitChangeV=profitChange1-profitChange0
        profitChange.append(profitChangeV)
        profitChange0=int(row[1])
        
#Calculate the greatest increase/decrease in profits
        if greatIncProfit < profitChangeV:
            greatIncProfit = profitChangeV
            greatIncDate = row[0]
        if greatDecProfit > profitChangeV:
            greatDecProfit = profitChangeV
            greatDecDate = row[0]
            
#Report generation
output_path = os.path.join(".", "analysis", "budget_data_Summary.csv")
with open(output_path, 'w') as csvfile:
    csvwriter = csv.writer(csvfile, delimiter=',')
    csvwriter.writerow(['Financial Analysis'])
    csvwriter.writerow(['----------------------------'])
    csvwriter.writerow([f"Total months: {len(month)-1}"])
    csvwriter.writerow([f"Total: ${netTotal}"])
    csvwriter.writerow(["Average Change: {0:.2f}".format((sum(profitChange)/(csvreader.line_num-2)))])
    csvwriter.writerow([f"Greatest Increase in Profits: {greatIncDate} (${greatIncProfit})"])
    csvwriter.writerow([f"Greatest Decrease in Profits: {greatDecDate} (${greatDecProfit})"])
with open(output_path, 'r') as csvfile:
    csvreader = csv.reader(csvfile, delimiter=',')
    for row in csvreader:
        print(row)

#Alternatively:
#     print('''Financial Analysis
# ----------------------------''')
#     print(f"Total months: {len(month)-1}")
#     print(f"Total: ${netTotal}")
#     print("Average Change: {0:.2f}".format((sum(profitChange)/(csvreader.line_num-2))))
#     print(f"Greatest Increase in Profits: {greatIncDate} (${greatIncProfit})")
#     print(f"Greatest Decrease in Profits: {greatDecDate} (${greatDecProfit})")
    
