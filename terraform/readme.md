# README.md addition:
"""
# Podman-based FastAPI Application

## Prerequisites
- Podman (latest version)
- podman-compose
- Python 3.9+
- Terraform (for infrastructure)

## Local Development
1. Install Podman and podman-compose:
   ```bash
   # Fedora/RHEL
   sudo dnf install podman podman-compose

   # Ubuntu
   sudo apt-get install podman podman-compose
   ```

2. Build and run the container:
   ```bash
   podman-compose up --build
   ```

3. Access the API at http://localhost:8000

## Running Tests
```bash
podman run --rm -v .:/app:Z localhost/myapp pytest app/tests/
```

## Security Notes
- Container runs as non-root user
- SELinux contexts are properly set with :Z volume mount
- Image scanning enabled in ECR
"""
