# PSTexporter
Export/Extract all attachments from a Microsoft PST file. 

Background: A PST (Pain_in_the_ass stupid table) file is a Micorsoft exclusive filetype that is commonly used by O365 that can contain an entire users inbox, calendar, and more. 

This repository aims to simplify extracting the emails out of the inbox included in a .pst file, then additionally extracting all of the attachments out of all of the .eml files. 
The original usecase for this script aimed to extract all attachments contained/compressed within a .pst file for analysis. 

It can be pared with the RepuationCheck.sh script included in this repositiory in order to identify malicious attachments embedded inside the .pst file. 
