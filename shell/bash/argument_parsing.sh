#!/bin/bash
#
# An example with argument parsing and a heredoc for the usage message.
#
#

#Show the usage message and exit with error:
exitUsage () {
    read -d '' usageContent <<"USAGE_BLOCK"
USAGE: $0 --outdir=...
This is the usage message for the script.

Options:

    -w, --workdir                Sets the working directory.
    -o, --outdir                 Sets the directory for the output rpm files.
    -d, --debug                  Debug mode.
    
USAGE_BLOCK
    echo -e "\n$usageContent\n" 1>&2
    exit 2
}


#Set default options in case they are not provided on the command line.
DEBUG_MODE=0
WORKING_DIRECTORY=`pwd`

#Parse the command line options:
for i in "$@"
do
case $i in
    -w=*|--workdir=*|-workdir=*)
    WORKING_DIRECTORY=`echo $i | sed 's/[-a-zA-Z0-9]*=//'`
    ;;
    -o=*|--outdir=*|-outdir=*)
    OUTPUT_DIRECTORY=`echo $i | sed 's/[-a-zA-Z0-9]*=//'`
    ;;
    -d|--debug|-debug)
    DEBUG_MODE="1"
    ;;
    *)
    # unknown option
    ;;
esac
done

#Make sure they specified a version:
if [[ -z "${OUTPUT_DIRECTORY}" ]]; then
    echo You must specify an output directory! 1>&2 
    exitUsage
fi


