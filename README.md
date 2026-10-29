Start the local redis:latest image in the background and publish Redis on port 6379:

docker run -d --name redis -p 6379:6379 redis:latest
-d runs it in the background.
--name redis gives the container a convenient name.
-p 6379:6379 maps port 6379 on your machine to Redis inside the container.
Connect to it with docker exec -it redis redis-cli.

To retain Redis snapshots in a named volume, run:

docker run -d --name redis-persistent -p 6379:6379 -v redis-data:/data redis:latest redis-server --save 60 1 --loglevel warning
If either container name is already taken, choose a different name. Let me know if you have any questions!

Sources:

https://hub.docker.com/_/redis
