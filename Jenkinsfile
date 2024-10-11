pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/arabi7398/Final-project.git'
            }
        }
        stage('Build') {
            steps {
                script {
                    try {
                        withDockerRegistry(credentialsId: '0697e2ce-e7da-4687-b1df-b7c8cf726dc3', url: 'https://index.docker.io/v1/') {
                            // Build the Docker image
                            bat 'docker build -t flask-app:latest .'
                            echo "Build finished"
                            
                            // Optional: Push the image to Docker Hub
                            bat 'docker push omarelaraby987/flask-app:latest'
                            echo "Image pushed to Docker Hub"
                        }
                    } catch (Exception e) {
                        echo "Error during the build process: ${e.message}"
                        currentBuild.result = 'FAILURE'
                    }
                }
            }
        }
    }
}
