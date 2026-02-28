pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "vijay9592/nodejs-devops-app:latest"
    }

    stages {

        stage('Clone') {
            steps {
                git 'https://github.com/vijay9592/DevOps-Capstone.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE .'
            }
        }

        stage('Push to DockerHub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'USERNAME',
                    passwordVariable: 'PASSWORD'
                )]) {
                    sh '''
                    echo $PASSWORD | docker login -u $USERNAME --password-stdin
                    docker push $DOCKER_IMAGE
                    '''
                }
            }
        }

        stage('Deploy to App EC2') {
            steps {
                sh '''
                ssh -o StrictHostKeyChecking=no ubuntu@43.205.228.240 "
                docker pull $DOCKER_IMAGE &&
                docker stop nodeapp || true &&
                docker rm nodeapp || true &&
                docker run -d --name nodeapp -p 3000:3000 $DOCKER_IMAGE
                "
                '''
            }
        }
    }
}