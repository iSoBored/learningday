# Aim of Project

To show the difference between a multi-stage Dockerfile and how it can reduce improve development workflow. 

## Background 

**Dependencies:**
1. Dependencies are packages that are essential for the application to run in a production environment.
2. These packages play a crucial role in the runtime behavior of the application. They usually consist of modules and libraries used by the application itself.
3. During the deployment process, it's common practice to install only the production dependencies. This helps in keeping the deployed image or package size to a minimum, contributing to a more efficient and streamlined deployment.

**DevDependencies**
1. DevDependencies are packages that are only needed during development, such as tools, test frameworks, and build scripts.
2. These packages are not required for the runtime operation of the application and are typically used for testing, linting, bundling, transpiling, etc.
3. DevDependencies are not installed when someone runs npm install without the --dev flag or NODE_ENV=production. They are only installed when explicitly requested or when installing dependencies during development.

## Python Project Example
Run the following commands to build the sample application image file for run:

```bash
docker build -t typescript-docker-example .                                 # Build the application image with more dependencies
docker build -f Dockerfile.small -t typescript-docker-example-small .       # Build the application image with less dependencies and alpine image
```

Run the following commands to run the sample application (if required):
```bash
docker run -p 3000:3000 typescript-docker-example-small                     # Run the application on port 3000 (Host & Container port respectively)
```

Run the following command to stop and delete the container:
```bash
docker container list                                                       # List all running containers
docker stop <container-id>                                                  # Stop the container - Replace <container-id> with running container
docker rm <container-id>                                                    # Remove the container - Replace <container-id> with stopped container
```

Run the following command to delete the image:
```bash
docker image rm typescript-docker-example                                   # Delete the sample image typescript-docker-example 
docker image rm typescript-docker-example-small                             # Delete the sample image typescript-docker-example-small
```
## Additional Information

An example to explain docker run -p <host port>:<container port>:
```bash
docker run -p 8080:80 my_image                                              # This maps port 80 inside the container to port 8080 on the host machine
```