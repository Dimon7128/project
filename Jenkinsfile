pipeline {
    agent {
        label 'Agent_WeatherApp1'
    }
    
    environment {
        AWS_CREDENTIALS = credentials('aws-credentials-id')
        AWS_DEFAULT_REGION = 'eu-west-3' // Replace with your AWS region
    }
    
    stages {
        stage('Checkout Code') {
            steps {
                // Debug: Print out Git credentials being used
                echo "Using Git credentials ID: 813dec95-17f9-4dd5-8485-ce61e0dccc0e"

                checkout([
                    $class: 'GitSCM', 
                    branches: [[name: '*/master']],
                    userRemoteConfigs: [[
                        url: 'http://13.36.136.165/the_dimi_gang/infrastracture_terraform.git', 
                        credentialsId: '813dec95-17f9-4dd5-8485-ce61e0dccc0e'
                    ]]
                ])
            }
        }
        
        stage('Terraform Init and Plan') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws-credentials-id', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                    // Debug: Print out AWS credentials being used
                    echo "Using AWS credentials ID: aws-credentials-id"
                    
                    // Debug: Ensure AWS credentials are masked
                    echo "AWS Access Key: ${env.AWS_ACCESS_KEY_ID}"
                    echo "AWS Secret Key: ${env.AWS_SECRET_ACCESS_KEY}"

                    // Debug: Print the Terraform version
                    sh 'terraform version'

                    // Run Terraform init and plan with detailed output for debugging
                    sh 'terraform init'
                    sh 'terraform plan'
                }
            }
        }
        
        stage('Terraform Apply') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws-credentials-id', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                    // Debug: Print the region
                    echo "AWS Region: ${env.AWS_DEFAULT_REGION}"

                    // Apply Terraform changes
                    sh 'terraform apply -auto-approve'
                }
            }
        }
    }
    
    post {
        always {
            echo 'Cleaning up...'
            // Debug: Run Terraform destroy with detailed output for debugging
            sh 'terraform destroy -auto-approve'
        }
    }
}
