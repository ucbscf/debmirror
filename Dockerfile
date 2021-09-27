FROM debian:buster-slim

ENV MIRROR_DIR=/srv/mirror

ENV GNUPGHOME=/srv/keyring

RUN apt-get update && \
	apt-get install -y debmirror gpg ubuntu-archive-keyring

RUN mkdir -p $GNUPGHOME
RUN gpg --no-default-keyring \
	--keyring $GNUPGHOME/trustedkeys.gpg \
	--import /usr/share/keyrings/ubuntu-archive-keyring.gpg

# ansible
RUN gpg --no-default-keyring \
	--keyring $GNUPGHOME/trustedkeys.gpg \
	--keyserver keyserver.ubuntu.com \
	--recv \
	93C4A3FD7BB9C367 && \
	gpg --no-default-keyring \
	--keyring $GNUPGHOME/trustedkeys.gpg \
	--export \
	--armor \
	93C4A3FD7BB9C367 | apt-key add -

# macaulay2
RUN gpg --no-default-keyring \
	--keyring $GNUPGHOME/trustedkeys.gpg \
	--keyserver keyserver.ubuntu.com \
	--recv \
	53F8BD99F40DCB31 && \
	gpg --no-default-keyring \
	--keyring $GNUPGHOME/trustedkeys.gpg \
	--export \
	--armor \
	53F8BD99F40DCB31 | apt-key add -

RUN mkdir -p ${MIRROR_DIR}

ADD mirror-ansible.sh /usr/local/sbin/
ADD mirror-macaulay2.sh /usr/local/sbin/
