#!/bin/sh

# resetwd.sh
# Reset working directory to state of "original" dir

echo "Resetting to original file list"
#rm *.fasta *merged* *.log
if [ -d original ]; then
    echo "Deleting all current files and making new hardlinks to read-only \"original\""
    rm -r *_db && rm *
    ln -v original/* .
fi
