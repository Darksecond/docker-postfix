## Hostname
Hostname (`-h`) should be a subdomain of `MAILNAME`, usually.
So `radiant.darksecond.nl` could be the hostname and `darksecond.nl` the `MAILNAME`.

## Certificates
Make sure the certificate has the intermediate CA's attached. (you can cat them both together)
The filenames should be the FQDN, with dots replaced with dashes.
So `radiant-darksecond-nl.pem` for example.
The private key should be decrypted.
Mount the certificates as volume under `/certs`

## Example
```
docker build .
docker run --name=postfix \
  --link dovecot:dovecot \
  --rm \
  -p 25:25 \
  -p 587:587 \
  -p 465:465 \
  -h radiant.darksecond.nl \
  -e MAILNAME=darksecond.nl \
  -v ~/certs:/certs \
  <image_id>
```
