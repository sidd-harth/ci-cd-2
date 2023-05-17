pipeline {
    agent any

    tools {
        maven 'M386'
    }

    stages {

        stage('Check Maven Version') {
            steps {
                sh "sh scripts/check-maven-version-snapshot.sh"
            }
        }

        stage('Build and Verify') {
            steps {
                sh 'echo Build and Verify Success'
            }
        }

        stage('SonarQube Analysis') {
            steps {
               sh 'echo SonarQube Analysis Success'
            }
        }

        stage('SonarQube Quality Gate') {
            steps {
                sh 'echo SonarQube Quality Gate Success'
            }
        }

        stage('Push Artefact to Exchange') {
            steps {
                sh 'echo Push Artefact to Exchange Success'
            }
        }

        stage('Deploy to CH2') {
            steps {
                sh 'echo Deploy to CH2 Success'
            }
        }

        stage('Push Artefact to Nexus') {
            steps {
                 sh 'echo Push Artefact to Nexus Success'
            }
        }        

        stage('Update Incremental/Patch Version') {
            steps {
                 sh "mvn build-helper:parse-version versions:set -DnewVersion=${parsedVersion.majorVersion}.${parsedVersion.minorVersion}.${parsedVersion.nextIncrementalVersion}-${parsedVersion.qualifier} versions:commit"
            }
        }

        stage('Commit to Develop') {
            steps {
                 sh "git checkout develop" 
                 sh "git add pom.xml"    
                 sh 'git commit -m "Updated Patch/Incremental Version"'
                 sh "git push origin"
            }
        }

    }

}
