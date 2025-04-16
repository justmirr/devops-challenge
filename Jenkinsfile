pipeline {
    agent {
        docker {
            image 'docker:24.0.7-dind'
            args '-v /var/run/docker.sock:/var/run/docker.sock --privileged'
        }
    }

    environment {
        IMAGE_NAME = 'simple-time-service'
        IMAGE_TAG = 'latest'
        AWS_REGION = 'us-east-1'
    }

    stages {
        stage('clone-repository') {
            steps {
                sh '''
                    apk add --no-cache git curl bash
                '''
                git branch: 'main', url: 'https://github.com/justmirr/devops-challenge.git'
            }
        }

        stage('build-image') {
            steps {
                dir('app') {
                    withCredentials([usernamePassword(
                        credentialsId: 'dockerhub-credentials',
                        usernameVariable: 'DOCKER_USERNAME',
                        passwordVariable: 'DOCKER_PASSWORD'
                    )]) {
                        sh '''
                            docker build -t $DOCKER_USERNAME/$IMAGE_NAME:$IMAGE_TAG .
                        '''
                    }
                }
            }
        }

        stage('push-to-dockerhub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-credentials',
                    usernameVariable: 'DOCKER_USERNAME',
                    passwordVariable: 'DOCKER_PASSWORD'
                )]) {
                    sh '''
                        echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin
                        docker push $DOCKER_USERNAME/$IMAGE_NAME:$IMAGE_TAG
                    '''
                }
            }
        }

        stage('terraform-init-apply') {
            steps {
                sh '''
                    apk add --no-cache curl unzip bash
                    curl -fsSL https://releases.hashicorp.com/terraform/1.7.5/terraform_1.7.5_linux_amd64.zip -o terraform.zip
                    unzip terraform.zip && mv terraform /usr/local/bin/ && terraform -version
                '''
                dir('terraform') {
                    withCredentials([usernamePassword(
                        credentialsId: 'aws-credentials',
                        usernameVariable: 'AWS_ACCESS_KEY_ID',
                        passwordVariable: 'AWS_SECRET_ACCESS_KEY'
                    )]) {
                        sh '''
                            export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
                            export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
                            export AWS_REGION=$AWS_REGION
                            terraform init
                            terraform apply --auto-approve
                        '''
                    }
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