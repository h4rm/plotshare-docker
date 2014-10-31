# DOCKER-VERSION 0.3.4
FROM harmonics/orbit

RUN cd /home
RUN apt-get install -y libpango1.0-dev
RUN wget http://sourceforge.net/projects/gnuplot/files/gnuplot/4.6.6/gnuplot-4.6.6.tar.gz
RUN tar xzf gnuplot-4.6.6.tar.gz
RUN mkdir build && cd build
RUN ../gnuplot-4.6.6/configure --with-readline=gnu --program-suffix=safer
#make it a safe gnuplot installation
RUN sed -i -e 's/#define HAVE_PCLOSE 1//' config.h
RUN sed -i -e 's/#define HAVE_POPEN 1//' config.h
RUN sed -i -e 's/#define PIPES 1//' config.h
RUN make
RUN sudo make install
RUN rm -rf /home/*
RUN apt-get clean

COPY config/lighttpd.conf /etc/lighttpd/lighttpd.conf

EXPOSE 80
