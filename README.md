# utilShells

## extract.sh

Usage:
  ./extract.sh [-o outputPath] targetFile

Description:
  Unzip file.
  File extension includes .tar .tar.gz .tar.Z .tar.bz2 .zip 

Options:
  -o  output-directory


## replace.sh

Usage:
  ./replace.sh [-R] [-e] directory|file oldChars newChars

Description:
  Repalce all occurrences of oldChar in the file or in the files of the directory with newChar.

Options:
  -R:find files in the directory recursively
  -e:enable regular expression

## sshExpect.ssh

Usage:
  ./sshExpect.ssh -p password username@hostname

Description:
  ssh with password.

Options:
  -p  password

## alias

Move .bash_profile to your home directory.
Convenient commands is defined as alias.


