docker run -d --name redis-persistent -p 6379:6379 -v redis-data:/data redis:latest redis-server --save 60 1 --loglevel warning
