FROM rodrigosaito/java:8

ENV DYNAMODB_BASE_PATH /usr/lib/dynamodb

RUN mkdir -p $DYNAMODB_BASE_PATH \
    && apk --update --virtual=build-dependencies add curl ca-certificates tar \
    && curl -fsSL http://dynamodb-local.s3-website-us-west-2.amazonaws.com/dynamodb_local_latest.tar.gz | tar xzf - -C $DYNAMODB_BASE_PATH \
    && apk del build-dependencies

WORKDIR $DYNAMODB_BASE_PATH

EXPOSE 8000

CMD [ "java", "-Djava.library.path=./DynamoDBLocal_lib", "-jar", "DynamoDBLocal.jar",  "-sharedDb" ]
