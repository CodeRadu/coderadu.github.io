FROM ubuntu AS build

# Update list of packages
RUN apt update

# Install HUGO
RUN apt install hugo git -y

WORKDIR /opt
COPY . .

# Checkout git submodule
RUN git submodule update --init --recursive

RUN hugo -v

FROM nginx AS server
COPY --from=build /opt/public /usr/share/nginx/blog
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80
