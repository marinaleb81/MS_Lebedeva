import redis

r = redis.Redis(host='redis-server', port=6379)
r.set('message', 'Hello from Python')
print("Message set in Redis")


"""
docker run --rm --name python-setter --network my-network -v E:\docker_test\set_message.py:/set_message.py python:3.8-slim sh -c "pip install redis && python /set_message.py"
"""