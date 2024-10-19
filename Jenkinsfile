pipeline {
    agent any
    
   //   triggers {
     //   pollSCM('H/5 * * * *') // Poll for changes every 5 minutes, but only trigger if changes are detected
    //}
    
    //  environment {
      //  KUBECONFIG = "/home/omar/.kube/config"
    //}

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/arabi7398/Final-project.git'
            }
        }
        stage('Build') {
            steps {
                script {
                    // Generate a timestamp tag (as an example)
                    def timestamp = sh(returnStdout: true, script: 'date +%Y%m%d-%H%M%S').trim()
                    def dockerTag = "flask-app:${timestamp}"
                    
                    // Set the environment variable
                    env.DOCKER_TAG = dockerTag // Set the docker_tag variable

                    withDockerRegistry(credentialsId: '0e4973b2-9699-4084-968a-390e33067f6f', url: 'https://index.docker.io/v1/') {
                        // Build the Docker image with the timestamp tag
                        sh "docker build -t ${dockerTag} ."
                        echo "Build finished with tag ${dockerTag}"

                        // Tag image with Docker Hub repository
                        sh "docker tag ${dockerTag} omarelaraby987/flask-app:${timestamp}"
                        echo "Docker image tagged as omarelaraby987/flask-app:${timestamp}"

                        // Push the image to Docker Hub
                        sh "docker push omarelaraby987/flask-app:${timestamp}"
                        echo "Image pushed to Docker Hub with tag ${timestamp}"
                    }
                }
            }
        }
       //   stage('Run Unit Tests') {
         //   steps {
           //     script {
             //       // Run the Flask unit tests
               //     sh 'python3 -m unittest discover'
                //}
            //}
    //    }
        stage('Deploy with Ansible') {
            steps {
                // Ensure that Ansible is installed and run the playbook
                sh "ansible-playbook -i inventory_2.ini deploy_helm_v5.yml --ask-become-pass"
                 //  sh  "ansible-playbook -i inventory_2.ini deploy_helm_v5.yml --ask-become-pass" 
                //   sh 'helm install flask-app "/var/lib/jenkins/workspace/CI-CD test 2/flask-app" --namespace=default'
              //   sh  "ansible-playbook -i inventory.ini deploy_docker_v11.yml --ask-become-pass" 
                // sh  "ansible-playbook -i inventory.ini deploy_docker_v3.yml" 
               //sh  "ansible-playbook -i inventory.ini deploy_docker_v2.yml" 
               //sh "ansible-playbook -i inventory.ini deploy_docker.yml --extra-vars \"docker_tag=${env.DOCKER_TAG}\" --ask-become-pass"
            }
        }
    }
        post {
        success {
            emailext (
                from: 'CI-CD Pipeline <ot059346@gmail.com>',
                to: 'omoor213@gmail.com', 
                subject: "Build Successful: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                body: """\
                Good news! The build ${env.JOB_NAME} #${env.BUILD_NUMBER} succeeded.

                - Project: ${env.JOB_NAME}
                - Build URL: ${env.BUILD_URL}
                """
            )
        }
        failure {
            emailext (
                from: 'CI-CD Pipeline <ot059346@gmail.com>',
                to: 'omoor213@gmail.com', 
                subject: "Build Failed: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                body: """\
                Unfortunately, the build ${env.JOB_NAME} #${env.BUILD_NUMBER} has failed.

                - Project: ${env.JOB_NAME}
                - Build URL: ${env.BUILD_URL}
                """
            )
        }
        unstable {
            emailext (
                from: 'CI-CD Pipeline <ot059346@gmail.com>',
                to: 'omoor213@gmail.com', 
                subject: "Build Unstable: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                body: """\
                The build ${env.JOB_NAME} #${env.BUILD_NUMBER} is unstable.

                - Project: ${env.JOB_NAME}
                - Build URL: ${env.BUILD_URL}
                """
            )
        }
    }
}