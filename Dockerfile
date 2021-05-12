# First stage: downloading zip, unzipping
FROM kubeless/unzip:latest AS builder

# Downloading server-files and unpacking them.
# Since its zip it cannot be unpacked by ADD
ADD https://media.forgecdn.net/files/3255/643/RAD-Serverpack-1.45.zip /tmp/RAD-Serverpack-1.45.zip
RUN unzip /tmp/RAD-Serverpack-1.45.zip

FROM openjdk:8u292-oraclelinux7
COPY --from=builder /tmp/RAD-Serverpack-1.45/ /srv/forge-rad

WORKDIR /srv/forge-rad
EXPOSE 25565

#aut-accept EULA
RUN rm /srvforge-rad/eula.txt && echo "eula=true" > /srv/forge-rad/eula.txt

RUN chmod 744 /var/forge-rad/LaunchServer.sh
CMD /var/forge-rad/LaunchServer.sh