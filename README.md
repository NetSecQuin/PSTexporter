# PSTexporter
Export/Extract all attachments from a Microsoft PST file. 

### Background

A PST (Personal Storage Table) file is a Micorsoft exclusive filetype that is commonly used by O365 that can contain an entire users inbox, calendar events, and contacts. 

This repository aims to simplify extracting the emails out of the inbox included in a .pst file, then additionally extracting all of the attachments out of all of the .eml files. 
The original usecase for this script aimed to extract all attachments contained/compressed within a .pst file for analysis. 

It can be pared with the RepuationCheck.sh script included in this repositiory in order to identify malicious attachments embedded inside the .pst file through static analysis. 

### Installation

This script does not install anything, though it does have some dependancies as listed in the requirements.txt file. 

### Usage

The PSTexporter.sh script does not take in any inputs, however it does require that the user adjust the input and output directory variables to match where the .pst files are located. 

```
# Directories for input/output
input_dir="/home/username/PSTfiles"
output_dir="/home/username/PSTfiles/"
```

### Cleanup

This script will create a number of new directories and files for each .pst, .eml, and embedded attachment. It is recommended that you run the cleanup.sh script following execution and analysis in order to keep your filesystem tidy 🧹
