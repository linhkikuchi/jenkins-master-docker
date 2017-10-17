import jenkins.model.*
import hudson.security.*
import hudson.plugins.active_directory.*
   
def instance = Jenkins.getInstance()
String domain = ''
String site = ''
String server = ''
String bindName = ''
String bindPassword = ''
def adrealm = new ActiveDirectorySecurityRealm(domain, site, bindName, bindPassword, server)
instance.setSecurityRealm(adrealm)

// If no authorisation strategy is in place, default to "Authenticated users can do anything"
def authStrategy = Hudson.instance.getAuthorizationStrategy()

if (authStrategy instanceof AuthorizationStrategy.Unsecured) {
	println "Defaulting to 'Authenticated users can do anything' rather than 'unsecure'."
	instance.setAuthorizationStrategy(new FullControlOnceLoggedInAuthorizationStrategy())
}

// Save the state
instance.save()