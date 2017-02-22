FROM centos:7
MAINTAINER chvugrin@microsoft.com

RUN yum -y install libunwind.x86_64 icu && \
    yum -y install curl-devel expat-devel gettext-devel openssl-devel zlib-devel && \
    yum -y groupinstall "Development Tools" && \
    yum -y install gcc perl-ExtUtils-MakeMaker && \
    yum -y install wget && \
    yum -y install sudo && \
    cd /usr/src && \
    wget https://www.kernel.org/pub/software/scm/git/git-2.9.2.tar.gz && \
    tar xzf git-2.9.2.tar.gz && \
    cd git-2.9.2 && \ 
    make prefix=/usr/local/git all && \
    make prefix=/usr/local/git install && \
    useradd -m -d /vsts vsts && \
    cd /vsts/ && \
    mkdir myagent && cd myagent && \
    wget https://github.com/Microsoft/vsts-agent/releases/download/v2.111.1/vsts-agent-rhel.7.2-x64-2.111.1.tar.gz && \
    tar xzf vsts-agent-rhel.7.2-x64-2.111.1.tar.gz && \
    rm -f vsts-agent-rhel.7.2-x64-2.111.1.tar.gz  && \
    sudo -u vsts bash -c 'ssh-keygen -t rsa -f  ~/.ssh/id_rsa -P ""' && \
    chown -R vsts:vsts * 
 
#COPY conf/logstash.conf /logstash/config/logstash.conf

ENV PATH="${PATH}:/usr/local/git/bin"
#CMD ["-f","/logstash/config/logstash.conf"]
