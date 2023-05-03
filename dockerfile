FROM node:14-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install --production
COPY /server.js .
EXPOSE 8081
CMD ["npm", "start"]


#Useful docker commands for build and run

# docker build -t appnodes_v1 .
# docker run -d -p 3000:8081 appnodes_v1


# > docker images
# REPOSITORY                    TAG       IMAGE ID       CREATED        SIZE
# appnodes_v1                   latest    83a4906b985c   9 hours ago    123MB
# appnodes                      latest    6a28bde10832   9 hours ago    123MB
# appnode                       latest    02b27545877e   10 hours ago   863MB
# wiziocli.azurecr.io/wizcli    latest    68a968ea7d59   2 weeks ago    319MB
# gcr.io/k8s-minikube/kicbase   v0.0.37   55c37b5c9b24   3 months ago   1.06GB
# aws_lambda_builder_image      latest    c36b21f05012   7 months ago   272MB
# ubuntu                        latest    21735dab04ba   8 months ago   69.2MB
# amazonlinux                   latest    06c59c262be8   8 months ago   194MB
#  ~/Documents/Karunesh-Assignments-Apr2023/docker  docker build -t appnodes_v1 .

# > docker images
# REPOSITORY                    TAG       IMAGE ID       CREATED        SIZE
# appnodes_v1                   latest    83a4906b985c   9 hours ago    123MB
# appnodes                      latest    6a28bde10832   9 hours ago    123MB
# appnode                       latest    02b27545877e   9 hours ago    863MB
# wiziocli.azurecr.io/wizcli    latest    68a968ea7d59   2 weeks ago    319MB
# gcr.io/k8s-minikube/kicbase   v0.0.37   55c37b5c9b24   3 months ago   1.06GB
# aws_lambda_builder_image      latest    c36b21f05012   7 months ago   272MB
# ubuntu                        latest    21735dab04ba   8 months ago   69.2MB
# amazonlinux                   latest    06c59c262be8   8 months ago   194MB
# > docker run -d -p 3000:8081 appnodes_v1