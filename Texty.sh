#!/bin/bash

kdialog --yesnocancel "Do you want to make a file? Press Yes to make, No to edit, and Cancel to cancel"

case $? in
    0)
        # Create new file
        filename=$(kdialog --inputbox "Name of file?")
        if [ -z "$filename" ]; then
            kdialog --warningyesno "The file was not created. Understand??"
        else
            text=$(kdialog --textinputbox "Text.")
            echo "$text" > "${filename}.txt"
            echo "Created ${filename}.txt"
        fi
        ;;
    1)
        # Edit existing file
        editfile=$(kdialog --getopenfilename "$HOME" "*.txt" "Choose a text file to edit")
        if [ -z "$editfile" ]; then
            echo "No file selected."
        else
            # Load contents of the file
            current=$(cat "$editfile")

            # Open textinputbox with current contents
            newtext=$(kdialog --textinputbox "Edit the file contents:" "$current")

            # If user didn’t cancel, overwrite file
            if [ $? -eq 0 ]; then
                echo "$newtext" > "$editfile"
                echo "File $editfile updated."
            else
                echo "Edit cancelled."
            fi
        fi
        ;;
    255)
        echo "User pressed Cancel or closed the dialog"
        ;;
esac
