#!/usr/bin/env bash
set -evx

p=$(curl -Ss https://letsencrypt.org/certificates/ | grep -Eo '(https://){1}\w+(\.\w+)+.*.pem' | cut -d'"' -f5 | sort -u)
for r in ${p}; do
  f=$(echo ${r} | rev | cut -d'/' -f1 | rev | cut -d'.' -f1)
  curl -Ss https://letsencrypt.org${r} | tee /usr/local/share/ca-certificates/${f}.crt
  chmod ugo=rwx /usr/local/share/ca-certificates/${f}.crt
done
dpkg-reconfigure ca-certificates
update-ca-certificates
