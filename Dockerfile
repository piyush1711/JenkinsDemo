FROM ubuntu:latest

LABEL Description="processavgcallduration"

#ENV WORKING_DIRECTORY=/site/processavgcallduration

WORKDIR ${WORKING_DIRECTORY}

ADD bin/ bin/

RUN apt-get -y update && apt-get -y install python3.8 python3-pip ucommon-utils ssmtp mpack &&\
    pip3 install recurly snowflake-connector-python==2.6.2 python-dateutil==2.7.0 &&\
    pip3 freeze && mkdir -p work logs var run &&\
    chmod -R 775 var logs work run /etc/ssmtp/ssmtp.conf &&\
    adduser --disabled-password --gecos '' billing &&\
    sed -i 's/=mail/=smtp.marchex.com/g' /etc/ssmtp/ssmtp.conf &&\
    chown billing:billing logs /etc/ssmtp/ssmtp.conf bin/

USER billing

#CMD bin/entrypoint_processAvgCallDuration.sh
