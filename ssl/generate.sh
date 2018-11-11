domain=$1

openssl genrsa -des3 -passout pass:x -out ./certificates/$domain.pass.key 2048

openssl rsa -passin pass:x -in ./certificates/$domain.pass.key -out ./certificates/$domain.key

openssl req -new -key ./certificates/$domain.key -out ./certificates/$domain.csr \
  -subj "/C=CA/ST=ON/L=Remote/O=CodeLoop/OU=Remote/CN=$domain/emailAddress=samirmamer@gmail.com"

cat <<EOT >> ./certificates/$domain.ext
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names

[alt_names]
DNS.1 = $domain
EOT

openssl x509 -req -sha256 -extfile ./certificates/$domain.ext -days 3650 -in ./certificates/$domain.csr -signkey ./certificates/$domain.key -out ./certificates/$domain.crt

rm ./certificates/$domain.ext
rm ./certificates/$domain.pass.key

echo "$domain.csr, $domain.crt and $domain.key files created in certificates folder"
