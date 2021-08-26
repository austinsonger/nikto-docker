FROM alpine:3.12

LABEL maintainer "Austin Songer <austin@songer.pro>"

COPY ["program/", "/nikto"]

ENV  PATH=${PATH}:/nikto

RUN echo 'Installing packages for Nikto.' \
  && apk add --update --no-cache --virtual .build-deps \
     perl \
     perl-net-ssleay \
  && echo 'Creating the nikto group.' \
  && addgroup nikto \
  && echo 'Creating the nikto user.' \
  && adduser -G nikto -g "Nikto user" -s /bin/sh -D nikto \
  && echo 'Changing the ownership.' \
  && chown -R nikto.nikto /nikto \
  && echo 'Finishing image.'

USER nikto

ENTRYPOINT ["nikto.pl"]
