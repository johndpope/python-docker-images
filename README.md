# python-docker-images
For using wheel caches and faster build times

### Using these dependencies:

```Dockerfile
FROM indico/sklearn as sklearn-base
FROM indico/indicoio as indicoio-base
FROM [YOUR BASE IMAGE]

# Copy in your requirements.txt file (make sure the versions specify match the ones you installed in the wheel-docker)
COPY ./requirements.txt /requirements.txt
COPY --from=sklearn-base /root/.cache/pip/wheels /root/sklearn.cache
COPY --from=sklearn-base /root/.cache/pip/wheels /root/indicoio.cache

RUN apk update && \
    apk add --no-cache zlib-dev libjpeg jpeg-dev openblas openblas-dev && \ # install any of these that the lib uses
    mkdir -p /root/.cache/pip/wheels && \
    cp -r /root/sklearn.cache/* /root/.cache/pip/wheels && \
    cp -r /root/indicoio.cache/* /root/.cache/pip/wheels && \
    pip3 install --find-links=/root/.cache/pip/wheels -r /requirements.txt && \
    rm -r /root/.cache # Remove the cache when you're done to minimize image size
```
