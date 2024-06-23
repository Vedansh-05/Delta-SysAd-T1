#Use the ubuntu base image
FROM ubuntu

#Setup a wokrdir
WORKDIR /scripts

#Run the basic commands
RUN apt-get update && \
    apt-get install -y cron apache2

#Copy all the scripts
COPY ./*.sh /scripts/
COPY ./*.txt /scripts/
COPY ./gemini.conf /etc/apache2/sites-available/000-default.conf

RUN a2enmod rewrite

#Set executable permissions to the script
RUN chmod 755 /scripts/*.sh

RUN mkdir -p /var/www/html

#Setting the entrypoint script
ENTRYPOINT [ "./scripts/entrypoint.sh" ]

CMD [ "cron" ]