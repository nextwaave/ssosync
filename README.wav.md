# Initial deployment without Jenkins

1. Pull or build waave deployer container (container assumed to be named `deployer:local` for this documentation)
2. Run `docker run -t --rm -v $(pwd):/project -v ${HOME}/.aws/:/home/ec2-user/.aws -e ACTION="deploy" -e GROUP_PATTERN='name:nonprod-dev*' deployer:local` 
