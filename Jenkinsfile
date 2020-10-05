node {    
	try {
    stage('clean workspace') {
        cleanWs()
    }
    stage('git checkout') { 
        git 'https://github.com/mohitakataria/1223335_DevOps_CaseStudy_WebApp.git'        
    }
    stage('code build & test') {
        sh 'mvn clean install'
    }
    stage('sonarqube') {
        def sonarHome= tool 'SonarQube_Home';
        withSonarQubeEnv('SonarQube_Home') {
            sh "${sonarHome}/bin/sonar-scanner"
        }
    }
    
    stage('docker build'){
        sh "docker build -t mohitakataria/1223335_DevOps_CaseStudy_WebApp:latest ."
        withCredentials([usernamePassword(credentialsId: 'mohidoc', passwordVariable: 'dockerpwd', usernameVariable: 'dockeruser')]) { 
            sh "docker login -u ${dockeruser} -p ${dockerpwd}"
        }
    }
    stage('docker push'){
        sh 'docker push mohitakataria/1223335_DevOps_CaseStudy_WebApp:latest'
    }
    stage('docker run'){
        sh 'docker run -p 8888:8080 -d 1223335_DevOps_CaseStudy_WebApp:latest'
    }
    stage('email'){
            emailext body: '''$PROJECT_NAME - Build # $BUILD_NUMBER - $BUILD_STATUS:
			Check console output at $BUILD_URL to view the results.''', subject: '$PROJECT_NAME - Build # $BUILD_NUMBER - $BUILD_STATUS!', to: 'mohita.kataria@gmail.com'
        }
    }
    catch(e){
        emailext body: '''$PROJECT_NAME - Build # $BUILD_NUMBER - FAILED:
		Check console output at $BUILD_URL to view the results.''', subject: '$PROJECT_NAME - Build # $BUILD_NUMBER - FAILED!', to: 'mohita.kataria@gmail.com'
	} 
}

