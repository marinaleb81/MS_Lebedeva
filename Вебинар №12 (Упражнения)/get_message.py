import redis

r = redis.Redis(host='redis-server', port=6379)
message = r.get('message')

if message:
    print("Message from Redis:", message.decode())
else:
    print("No message found in Redis")


"""
docker run --rm --name python-getter --network my-network -v E:\docker_test\get_message.py:/get_message.py python:3.8-slim sh -c "pip install redis && python /get_message.py"
"""