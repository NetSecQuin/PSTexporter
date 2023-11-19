# PSTexporter
Export/Extract email attachments from all Microsoft .pst file(s) present in a directory. 

### Background

A PST (Personal Storage Table) file is a Micorsoft exclusive filetype that can contain an entire users inbox, calendar events, and contacts. 

This repository aims to simplify extracting the emails out of the inbox included in a .pst file, then additionally extracting all of the attachments out of all of the .eml files. 
The original use-case for this script aimed to extract all attachments contained/compressed within a .pst file for analysis. 

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
### Output

This script will extract all embedded attachments from a .pst file that contains .eml file(s). It will generate directories for each .eml and each assocaited attachment. It also will create a file called ``` results.txt``` which will show a list off files that were extracted, and which PSTs or EMLs that they were derived from. 

An example output of what can be seen in results.txt is shown below.

```
PST Filepath: /path/to/input/firstlast.pst
Recipient/Mailbox Owner: firstlast
Subject: email1subject

Attachment Name: attachment1.txt
Attachment SHA256:
b2c3d4e5f6a1b2c3d4e5f6a1b2c3d4e5f6a1b2c3d4e5f6a1b2c3d4e5f6a1b2c3d4e5f6
Attachment Name: attachment2.doc
Attachment SHA256:
b2c3d4e5f6a1b2c3d4e5f6a1b2c3d4e5f6a1b2c3d4e5f6a1b2c3d4e5f6a1b2c3d4e5f6
```

### Cleanup

This script will create a number of new directories and files for each .pst, .eml, and embedded attachment. It is recommended that you run the cleanup.sh script following execution and analysis in order to keep your filesystem tidy 🧹


