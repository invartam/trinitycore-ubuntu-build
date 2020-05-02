FROM ubuntu:19.10

RUN apt-get update
RUN apt-get dist-upgrade -y
RUN apt-get install -y cmake make git gcc g++ pkg-config \
        libssl-dev libreadline-dev zlib1g-dev libboost-all-dev \
        libncurses-dev libbz2-dev libpthread-workqueue-dev wget libace-dev \
        libace-6.4.5 libmariadbd-dev libmariadb-client-lgpl-dev-compat

#RUN update-alternatives --install /usr/bin/cc cc /usr/bin/clang 100
#RUN update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang 100

#RUN ln -s /lib/x86_64-linux-gnu/ /usr/lib64
#RUN ln -s /lib/x86_64-linux-gnu/librt.so.1 /lib64/

RUN touch /usr/include/stropts.h

ADD build.sh /usr/bin/build.sh

RUN groupadd -g 1000 psadmin && useradd -g psadmin -u 1000 psadmin
RUN chmod 755 /usr/bin/build.sh
RUN mkdir /tc && chmod 755 /tc && chown -R 1000:1000 /tc

VOLUME [ "/src" ]

WORKDIR /src
USER psadmin

CMD [ "build.sh" ]
