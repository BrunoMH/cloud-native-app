pipeline {
  agent any

  environment {
    AWS_REGION      = "us-east-1"
    ECR_REGISTRY    = "<ACCOUNT_ID>.dkr.ecr.us-east-1.amazonaws.com"
    ECR_REPO        = "backend-app"
    CLUSTER_NAME    = "cloud-native-cluster"
    IMAGE_TAG       = "${BUILD_NUMBER}"
  }

  stages {

    stage('Build') {
      steps {
        sh 'docker build -t $ECR_REPO:$IMAGE_TAG ./backend'
      }
    }

    stage('Push to ECR') {
      steps {
        withAWS(credentials: 'aws-credentials', region: AWS_REGION) {
          sh '''
            aws ecr get-login-password --region $AWS_REGION | \
            docker login --username AWS --password-stdin $ECR_REGISTRY

            docker tag $ECR_REPO:$IMAGE_TAG $ECR_REGISTRY/$ECR_REPO:$IMAGE_TAG
            docker push $ECR_REGISTRY/$ECR_REPO:$IMAGE_TAG
          '''
        }
      }
    }

    stage('Deploy to EKS') {
      steps {
        withAWS(credentials: 'aws-credentials', region: AWS_REGION) {
          sh '''
            aws eks update-kubeconfig --region $AWS_REGION --name $CLUSTER_NAME

            kubectl set image deployment/backend \
              backend=$ECR_REGISTRY/$ECR_REPO:$IMAGE_TAG
          '''
        }
      }
    }

  }
}