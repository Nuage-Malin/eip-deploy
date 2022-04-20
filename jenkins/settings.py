import yaml
import sys

def getYml(filepath):
    with open(filepath, "r") as file:
        data = file.read()
    return yaml.load(data, Loader=yaml.SafeLoader)

def rewriteFile(filepath, yml):
    with open(filepath, "w") as file:
        file.write(yaml.dump(yml))

def addUsers(users, destYml):
    if ("users" not in destYml['jenkins']['securityRealm']['local']):
        destYml['jenkins']['securityRealm']['local']['users'] = []
    for user in users:
        usernameWords = user['name'].split(" ")
        destYml['jenkins']['securityRealm']['local']['users'].append({
            'id': user['name'],
            'password': "${{JENKINS_USER_{}_PASSWORD}}".format((user['name'][0].upper() + usernameWords[1].upper()) if len(usernameWords) > 1 else user['name'].upper())
        })

def addUsersRoles(users, destYml):
    for user in users:
        for userRole in user['roles']:
            for role in destYml['jenkins']['authorizationStrategy']['roleBased']['roles']['global']:
                if (role['name'] == userRole):
                    if ("assignments" not in role):
                        role['assignments'] = []
                    role['assignments'].append(user['name'])
                    break


def main():
    print("Edit jenkins settings")
    if (len(sys.argv) != 3):
        return 1

    print("Getting users file")
    srcYml = getYml(sys.argv[1])
    if ("users" not in srcYml):
        return 1
    print("Getting jenkins config")
    destYml = getYml(sys.argv[2])

    print("Adding users")
    addUsers(srcYml['users'], destYml)
    print("Adding users roles")
    addUsersRoles(srcYml['users'], destYml)

    print("Saving")
    rewriteFile(sys.argv[2], destYml)

    print("Finish")
    return 0


exit(main())