FROM mcr.microsoft.com/devcontainers/base:ubuntu

RUN echo '#!/bin/bash' > /workspace/docker-entrypoint.sh && \
    echo 'echo "Dockerfile entrypoint ran" > /workspace/dockerfile_test.txt' >> /workspace/docker-entrypoint.sh && \
    echo 'exec "$@"' >> /workspace/docker-entrypoint.sh && \
    chmod +x /workspace/docker-entrypoint.sh

ENTRYPOINT ["/workspace/docker-entrypoint.sh"]
CMD ["sleep", "infinity"]
