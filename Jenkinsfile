pipeline {
    agent {
        label 'Agent_WeatherApp1'
    }
    environment {
        AWS_DEFAULT_REGION = 'eu-west-3' // Use your actual AWS region
    }
    stages {
        stage('Checkout Code') {
            steps {
                checkout scm: [
                    $class: 'GitSCM', 
                    branches: [[name: '*/master']],
                    userRemoteConfigs: [[
                        url: 'http://13.36.136.165/the_dimi_gang/infrastracture_terraform.git',
                        credentialsId: '813dec95-17f9-4dd5-8485-ce61e0dccc0e'
                    ]]
                ]
            }
        }
        stage('Terraform Init and Plan') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credentials-id']]) {
                    sh 'terraform init'
                    sh 'terraform plan'
                }
            }
        }
        stage('Terraform Apply') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credentials-id']]) {
                    sh 'terraform apply -auto-approve'
                }
            }
        }
    }
    post {
        always {
            echo 'Cleaning up...'
            withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credentials-id']]) {
                sh 'terraform destroy -auto-approve'
            }
        }
    }
}
