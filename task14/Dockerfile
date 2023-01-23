# image
FROM alpine:3.17.0

# install, update pakages
RUN apk update && apk upgrade
RUN apk add bash
RUN apk add nginx
# images filter for rotate picture
RUN apk add nginx-mod-http-image-filter 
# user 
RUN adduser -u 1000 -D -S -G www-data www-data
# create main folder
RUN mkdir -p "/var/www/tutorial/" 
RUN mkdir -p "/var/www/tutorial/my_music"
RUN mkdir -p "/var/www/tutorial/my_page2"

# create folder for ssl
#RUN mkdir -p "/etc/letsencrypt/live/www.domentask.site/"
#RUN mkdir -p "/etc/letsencrypt/live/www.domentask.site/"
#RUN mkdir -p "/etc/letsencrypt/"
# copy data ssl
#COPY fullchain.pem /etc/letsencrypt/live/www.domentask.site/fullchain.pem
#COPY privkey.pem /etc/letsencrypt/live/www.domentask.site/privkey.pem
#COPY options-ssl-nginx.conf /etc/letsencrypt/options-ssl-nginx.conf
#COPY ssl-dhparams.pem /etc/letsencrypt/ssl-dhparams.pem

# main
COPY nginx.conf /etc/nginx/nginx.conf
COPY ./tutorial/index.html /var/www/tutorial/index.html 
COPY ./tutorial/my_page2/index2.html /var/www/tutorial/my_page2/index2.html  
COPY ./tutorial/my_music/BloodyStream.mp3 /var/www/tutorial/my_music/BloodyStream.mp3 
COPY ./tutorial/image1.png /var/www/tutorial/image1.png
COPY ./tutorial/image2.jpg /var/www/tutorial/image2.jpg

# set all access
RUN chmod 777 /etc/nginx/nginx.conf
RUN chmod 777 /var/www/tutorial/index.html
RUN chmod 777 /var/www/tutorial/my_page2/index2.html
RUN chmod 777 /var/www/tutorial/my_music/BloodyStream.mp3
RUN chmod 777 /var/www/tutorial/image1.png
RUN chmod 777 /var/www/tutorial/image2.jpg
 
# ports
EXPOSE 80 
EXPOSE 443
EXPOSE 8080

# daemon
CMD nginx -g "daemon off;"