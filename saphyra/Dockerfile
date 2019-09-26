FROM ubuntu
SHELL ["/bin/bash", "-c"] 
# Perform the installation as root:
USER root
ENV HOME /home/caducovas
WORKDIR ${HOME}


RUN apt-get update -y && apt-get install -y build-essential && apt-get install -y python && apt-get install -y gcc && apt-get install -y g++ && apt-get install -y gfortran && apt-get install -y zlib1g-dev && apt-get install -y libssl-dev && apt-get install -y libsqlite3-dev && apt-get install -y make && apt-get install -y wget && apt-get install -y git  && apt-get install -y tar && apt-get install -y sudo && apt-get install -y tree && apt-get install -y libhdf5-serial-dev && apt-get install -y patch && apt-get install -y bzip2 && apt-get install -y libgdbm-dev && apt-get install -y liblzma-dev && apt-get install -y libncurses5-dev libncursesw5-dev && apt-get install libreadline6-dev && apt-get install -y uuid-dev && apt-get install -y libffi-dev && apt-get install -y bash-completion && apt-get install -y python-pip && apt-get install -y libboost-all-dev && apt-get install -y libboost-all-dev cmake && apt-get install -y curl && apt-get install -y vim
RUN apt-get install -y libx11-dev libxpm-dev libxft-dev libxext-dev libpcre3-dev libgl-dev libglu1-mesa-dev libglew-dev libftgl-dev libmysqlclient-dev libfftw3-dev libcfitsio-dev graphviz-dev libavahi-compat-libdnssd-dev libldap-dev python-dev libxml2-dev gsl-bin libgsl0-dev libboost-dev libboost-all-dev

#apt-get install -y tk-dev   -> the problema is that it asks for geographical location
#bash-completion-extras
#apt-get install -y epel-release 
#apt-get install -y which 


RUN pip install numpy==1.16.1 scipy tensorflow keras pandas sklearn matplotlib telepot prettytable

#RUN curl -o $HOME/root_ubuntu18.tar.gz https://root.cern/download/root_v6.18.00.Linux-ubuntu18-x86_64-gcc7.4.tar.gz

RUN curl -o $HOME/root_ubuntu16.tar.gz https://root.cern/download/root_v6.16.00.Linux-ubuntu18-x86_64-gcc7.3.tar.gz


RUN tar xfvz $HOME/root*ubuntu*tar.gz -C $HOME
RUN echo 'source $HOME/root/bin/thisroot.sh' >> ~/.bashrc
RUN source $HOME/root/bin/thisroot.sh
#RUN cd ${HOME} && git clone https://github.com/kaducovas/ringer.git && cd ringer && ./setup_modules.sh && ./setup_modules.sh --head
#ADD . .

#USER atlas

#ENV Athena_SETUP "off"

ENV ROOTSYS "$HOME/root/"

ENV PATH "$ROOTSYS/bin:$PATH"
ENV LD_LIBRARY_PATH "$ROOTSYS/lib:$LD_LIBRARY_PATH"
ENV PYTHONPATH "$HOME/root/lib"

ENV CPLUS_INCLUDE_PATH "$CPLUS_INCLUDE_PATH:/usr/include/python2.7/"
ENV LC_ALL ''
ENV RCM_NO_COLOR 0
ENV RCM_GRID_ENV 0
#ADD . .
RUN git clone https://gitlab.cern.ch/ccovasco/saphyra.git && ls -lrah

RUN cd $HOME/saphyra && source setup_module.sh && cd $HOME/saphyra && source setup_module.sh --head 
RUN cd $HOME/saphyra && source buildthis.sh 
RUN cd $HOME/saphyra && source setup.sh 

RUN mkdir ${HOME}/data
RUN ln -sf ${HOME}/saphyra/build/Core/TuningTools/libTuningTools_rdict.pcm ${HOME}/saphyra/build/lib
RUN ln -sf ${HOME}/saphyra/build/Gaugi/libGaugi_rdict.pcm ${HOME}/saphyra/build/lib
RUN ln -sf ${HOME}/saphyra/build/libsaphyra.so ${HOME}/saphyra/build/lib
ENV LD_LIBRARY_PATH  "${HOME}/saphyra/build/lib:$LD_LIBRARY_PATH"
ENV PYTHONPATH "${HOME}/saphyra/build/lib:$PYTHONPATH"
ENV PYTHONPATH "${HOME}/saphyra/build/python:$PYTHONPATH"
ENV PATH "${HOME}/saphyra/build/scripts:$PATH"

#RUN cd $HOME/ringer/root && source setrootcore.sh
#RUN cd $HOME/ringer/root && source setrootcore.sh
#RUN cd $HOME/ringer/root && rm -R TuningTools && git clone https://github.com/kaducovas/TuningTools.git && cd TuningTools && git checkout container

RUN cd $HOME && ls -lh && git clone https://github.com/kaducovas/run.git && ls $HOME/run -lah

RUN apt install -y libpq-dev python-dev python-psycopg2 postgresql-client
RUN pip install dataset psycopg2 seaborn

#RUN cd ${HOME} && cd saphyra && source setup_module.sh && source setup_module.sh --head && sed -i 's/cmake3/cmake/g' buildthis.sh && source buildthis.sh && source setup.sh
ENTRYPOINT ["./run/mainNoLog.sh"]

#git clone https://github.com/wsfreund/RingerCore.git
#git clone https://github.com/wsfreund/RootCoreMacros.git

#export PYTHONPATH /usr//lib/python2.7/site-packages:/usr//lib/python2.7/lib-dynload:/usr//lib/python2.7:/root/ringer/root/RootCore/lib/generic/:/root/ringer/root/RootCore/python:/root/root/lib

#docker build -t ringer:2.0 .
#docker run --name ringer -v /home/caducovas/Development/volume:/volume -ti ringer:2.0
