pipeline {
  agent  { label 'cloud-arm64' }
  environment {
    SNAPSHOT = '1' // Set to '1' for snapshot builds, otherwise set to '0'
  }
  stages {
    stage('Create Package') {
      steps {
        dir("bms-cockpit") {
          script {
            def version = ""
            if (env.SNAPSHOT == '1') {
              def snap = sh(script: "date -u +%Y%m%dT%H%M%SZ", returnStdout: true).trim()
              def gitSha = sh(script: "git rev-parse --short HEAD 2>/dev/null || echo 'nogit'", returnStdout: true).trim()
              version = "~dev.${snap}.${gitSha}"
            }
            sh """
              sed "s/@VERSION@/${version}/" DEBIAN/control.in > DEBIAN/control
              chmod 755 DEBIAN/postinst DEBIAN/postrm DEBIAN/prerm
            """
          }
        } 
        sh '''
          set -e
          PKG=$(grep '^Package:' bms-cockpit/DEBIAN/control | awk '{print $2}')
          VER=$(grep '^Version:' bms-cockpit/DEBIAN/control | awk '{print $2}')
          ARCH=$(grep '^Architecture:' bms-cockpit/DEBIAN/control | awk '{print $2}')

          dpkg-deb --build bms-cockpit "${PKG}_${VER}_${ARCH}.deb"
        '''        
      }
    }
    stage('Publish Package') {
//       when {
//         expression {
//           return env.BRANCH_NAME == 'develop' || env.BRANCH_NAME == 'master'
//         }
//       }
      steps {
        sh '''
          set -e
          DEB_FILE=$(ls -1 *.deb | head -n1)
          echo "Found package: $DEB_FILE"
          sudo -u jenkins -H bash -lc '
            aptly mirror update gtiremote
            aptly repo import gtiremote gtirepo "Name (~ .*)"
            aptly repo add gtirepo "'"$DEB_FILE"'"
            aptly -passphrase-file=/home/jenkins/gpg_sec.txt publish update bookworm s3:gtirepo:
          '
        '''        
      }
    }
  }
}
