import os
import csv

election_filename = os.path.join('.', 'Resources', 'election_data.csv')

with open(election_filename, 'r') as csvfile:
       
    data=[]
    candidates=[]
    VoteNumber=[]
# Split the data on commas
    csvreader = csv.reader(csvfile, delimiter=',')
    next(csvreader)[2]
    for row in csvreader:
        data.append(row)
    totalVotes=len(data)
    candidates = [data[0][2]]

#uniquing the candidate names
    for row in data:
        flag=True
        for candidate in candidates:
                if row[2]!=candidate:flag=flag*True
                if row[2]==candidate:flag=flag*False
        if flag==True:
            candidates.append(row[2])

# calculate total votes for each candidate
    for candidate in candidates:
        VoteSum=0
        for row in data:
            VoteSum=VoteSum+int(row[2]==candidate)
        VoteNumber.append(VoteSum)

#Report generation
output_path = os.path.join(".", "analysis", "election_data_Summary.csv")
with open(output_path, 'w') as csvfile:
    csvwriter = csv.writer(csvfile, delimiter=',')
    csvwriter.writerow(['Election Results'])
    csvwriter.writerow(['-------------------------'])
    csvwriter.writerow([f"Total Votes: {totalVotes}"])
    csvwriter.writerow(['-------------------------'])
    for x in range(len(candidates)):
        csvwriter.writerow([f"{candidates[x]}: {VoteNumber[x]/totalVotes*100:.3f}% ({VoteNumber[x]})"])
    csvwriter.writerow(['-------------------------'])
    csvwriter.writerow([f'Winner: {candidates[VoteNumber.index(max(VoteNumber))]}'])
    csvwriter.writerow(['-------------------------'])
    
with open(output_path, 'r') as csvfile:
    csvreader = csv.reader(csvfile, delimiter=',')
    for row in csvreader:
        print(row)