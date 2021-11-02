FROM google/cloud-sdk:slim
COPY ./secrets.sh secrets.sh
RUN curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
RUN chmod +x ./kubectl && chmod +x secrets.sh
RUN mv ./kubectl /usr/local/bin/kubectl