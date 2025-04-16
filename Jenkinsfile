pipeline {
    agent any

    environment {
        IMAGE_NAME = 'simple-time-service'
        IMAGE_TAG = 'latest'
    }

    stages {
        stage('clone-repository') {
            steps {
                git branch: 'main', url: 'https://github.com/justmirr/devops-challenge.git'
            }
        }

        stage('build-image') {
            steps {
                dir('app') {
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                        sh '''
                            docker build -t $DOCKER_USERNAME/$IMAGE_NAME:$IMAGE_TAG .
                        '''
                    }
                }
            }
        }

        stage('push-to-dockerhub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                    sh '''
                        echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin
                        docker push $DOCKER_USERNAME/$IMAGE_NAME:$IMAGE_TAG
                    '''
                }
            }
        }

        stage('terraform-init-apply') {
            steps {
                dir('terraform') {
                    sh '''
                        terraform init
                        terraform apply --auto-approve
                    '''
                }
            }
        }
    }

    post {
        success {
            echo 'pipeline completed!'
        }
        failure {
            echo 'pipeline failed!'
        }
    }
}