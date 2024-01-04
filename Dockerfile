FROM ubuntu AS build

# Update list of packages
RUN apt update

# Install HUGO
RUN apt install hugo -y

WORKDIR /opt
COPY . .

RUN hugo

FROM nginx AS server
COPY --from=build /opt/public /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
