folder("Production") {
    description("Production builds");
}
// job("Production/Front") {
//     scm {
//         git {
//             remote {
//                 github("$GIT_REPOSITORY_URL_PROD_FRONT", 'ssh')
//                 credentials('repositories_credential')
//                 branch("main")
//             }
//         }
//     }
//     triggers {
//         pollSCM {
//             scmpoll_spec('* * * * *')
//         }
//     }
//     steps {
//         shell('')
//     }
// }