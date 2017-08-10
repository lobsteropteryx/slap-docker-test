./data.sh
docker build\
  --force-rm=true\
  --no-cache\
  --ulimit nofile=65535:65535\
  --ulimit nproc=25059:25059\
  -t slap-test-10.4 .
