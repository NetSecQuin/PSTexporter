#!/bin/bash
# Directories for input/output. Note that input directory does not end in /
input_dir="/home/username/PSTfiles"
output_dir="/home/username/PSTfiles/"

# For loop to extract all pst files in directory into .eml in their own perspective directories
for file in "$input_dir"/*.pst; do
    filename=$(basename "$file")
    filename_noext="${filename%.*}"
    mkdir -p "$output_dir/$filename_noext"

    # add a -b flag to exclude the body-rtf file
    readpst -e -D -o "$output_dir/$filename_noext" "$file"

    # Finding what the following directory is and removing whitespace (identify the name of Inbox file)
    path="$input_dir"/"$filename_noext"/"$filename_noext"/
    InboxName="$(find "$path" -type d -print | awk -F'/' 'NF{print $NF}')"
    InboxName_nowhite="${InboxName#"${InboxName%%[![:space:]]*}"}"

    # Loop to extract attachments from all eml files in directory
    for emlfile in "$input_dir/$filename_noext"/*/*/*.eml; do
    
        emldirectory=$"${emlfile%.*}"
        mkdir "$emldirectory"
        EMLFileName="$(basename "$emldirectory")"

        echo "Extracting Attachments from: "$emlfile
        eml-extractor -f "$emlfile" -d "$emldirectory"/

        # Collect some details for later
        EMLname_noext="$(find "$emldirectory" -type d -print | awk -F'/' 'NF{print $NF}')"
        
        EMLname="$(find "$emldirectory" -type d -print | awk -F'/' 'NF{print $NF}')"
        EMLname_nowhite="${EMLname#"${EMLname%%[![:space:]]*}"}"

        # Add some space to make it pretty
        echo " "
        echo " "
        echo " " >> results.txt
        echo " " >> results.txt

        # Print some details, then ship to a text file
        echo "PST Filepath: "$file
        echo "PST Filepath: "$file >> results.txt

        # PST name with no extension, signifying the mailbox owner
        echo "Recipient/Mailbox Owner: "$filename_noext
        echo "Recipient/Mailbox Owner: "$filename_noext >> results.txt

        # EML File name, signifying the Email subject
        echo "Subject: "$EMLFileName
        echo "Subject: "$EMLFileName >> results.txt

        # Loop to get the sha256 hash of each extracted attachment
        for attachment in "$emldirectory"/*/*; do
            file_name="$(basename "$attachment")"
            echo "Attachment Name: "$file_name
            echo "Attachment Name: "$file_name >> results.txt
            echo "Attachment SHA256:"
            echo "Attachment SHA256:" >> results.txt

            sha256sum "$(echo "$attachment")"
            sha256sum "$(echo "$attachment")" >> results.txt
            
        done
    done
done

# Add hashes to separate file
grep -o -E '\b[0-9a-fA-F]\{64\}\b' results.txt >> hashes.txt

# Dedupe
sort -u hashes.txt > uniquehashes.txt
uniquehashes="uniquehashes.txt"
