This is a reminder to the package's author of how to build the Docker container.

   - Start the [Docker Desktop app](https://www.docker.com/products/docker-desktop).
   
   - In the directory with the Dockerfile, type the command:
   
         docker build -t jupyter-pyroot .
         
   - The primary reason to rebuild this docker container is to take advantage of new versions of the various packages. Therefore, the first time you run the above command, you probably want to use the `--no-cache` option. Without that, docker will use the cached results from the previous build and won't actually rebuild anything:
   
         docker build --no-cache -t jupyter-pyroot .
         
