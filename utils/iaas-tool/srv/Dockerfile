FROM centos:latest
ADD ./conf.d/exec.sh /tmp/exec.sh
RUN ["chmod", "+x", "/tmp/exec.sh"]
CMD /bin/bash /tmp/exec.sh
RUN  cat /etc/redhat-release

ADD ./conf.d/init.sh /tmp/init.sh
RUN ["chmod", "+x", "/tmp/init.sh"]
