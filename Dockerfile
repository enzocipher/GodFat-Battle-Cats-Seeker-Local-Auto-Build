FROM ruby:3.3

RUN apt-get update && \
    apt-get install -y build-essential libssl-dev libreadline-dev zlib1g-dev \
                       memcached libmemcached-dev \
                       git curl clang-17 clang++-17 dos2unix && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install

COPY . .

# Convertir scripts a UNIX y poner permisos (paths corregidos)
RUN find Seeker/bin -type f -name "*.sh" -exec dos2unix {} \; \
    && chmod +x Seeker/bin/*.sh \
    && find bin -type f -exec dos2unix {} \; \
    && chmod +x bin/*

ENV CC=clang-17
ENV CXX=clang++-17

# Compila seed seekers
RUN Seeker/bin/build-VampireFlower.sh && \
    Seeker/bin/build-8.6.sh

# Exponer puertos
EXPOSE 8080 9090

# Arranca memcached y luego el servidor
CMD memcached -u root -p 11211 -d && ./bin/server
