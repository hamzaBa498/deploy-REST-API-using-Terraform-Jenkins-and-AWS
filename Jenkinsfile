pipeline {
    agent any

    parameters {
            booleanParam(name: 'PLAN_TERRAFORM', defaultValue: false, description: 'Check to plan Terraform changes')
            booleanParam(name: 'APPLY_TERRAFORM', defaultValue: false, description: 'Check to apply Terraform changes')
            booleanParam(name: 'DESTROY_TERRAFORM', defaultValue: false, description: 'Check to apply Terraform changes')
    }

    stages {
        stage('Clone Project Repository Step') {
            steps {
                // Clean workspace before cloning (optional)
                deleteDir()

                // Clone the Git repository
                git branch: 'main',
                    url: 'https://github.com/hamzaBa498/deploy-REST-API-using-Terraform-Jenkins-and-AWS.git'

                sh "ls -lart"
            }
        }

        stage('Terraform Init Step') {
                    steps {
                       withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-crendentials-hamza']]){
                            dir('infra_app_provisioning') {
                            sh 'echo "================= Terraform Init =================="'
                            sh 'terraform init'
                        }
                    }
                }
        }

        stage('Terraform Plan Step') {
            steps {
                script {
                    if (params.PLAN_TERRAFORM) {
                       withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-crendentials-hamza']]){
                            dir('infra_app_provisioning') {
                                sh 'echo "================= Terraform Plan =================="'
                                sh 'terraform plan'
                            }
                        }
                    }
                }
            }
        }

        stage('Terraform Apply Step') {
            steps {
                script {
                    if (params.APPLY_TERRAFORM) {
                       withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-crendentials-hamza']]){
                            dir('infra_app_provisioning') {
                                sh 'echo "================= Terraform Apply8 =================="'
                                sh 'terraform apply -auto-approve'
                            }
                        }
                    }
                }
            }
        }

        stage('Terraform Destroy Step') {
            steps {
                script {
                    if (params.DESTROY_TERRAFORM) {
                       withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-crendentials-hamza']]){
                            dir('infra_app_provisioning') {
                                sh 'echo "================= Terraform Destroy =================="'
                                sh 'terraform destroy -auto-approve'
                            }
                        }
                    }
                }
            }
        }
    }
}