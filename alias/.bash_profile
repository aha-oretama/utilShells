alias ll=`ls -l`

targzFunction()
{
  tar zcvf "$@"
}
alias targz=targzFunction

tarbz2Function()
{
  tar jcvf "$@"
}
alias tarbz2=tarbz2Function
