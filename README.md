# bedrock-auto-updater
## References
* Minecraft Bedrock Linux Download
## notes

* element download match:

<a href="https://minecraft.azureedge.net/bin-linux/bedrock-server-1.21.0.03.zip" aria-label="Download Minecraft Dedicated Server software for Ubuntu (Linux)" class="btn btn-disabled-outline mt-4 downloadlink" role="button" data-platform="serverBedrockLinux" tabindex="0" aria-disabled="true">Download </a>

* use beautifulSoup to match element.   data-platform="serverBedrockLinux"
host default env vars:
BEDROCK_ISUPDATEALL=0
BEDROCK_LOCATION=/home/sliver/Games/minecraft/
BEDROCK_WORLD=ActiveCreative/



## Pre Reqs
1. bedrock server properties set, and firewall etc complete
2. Minecraft configured in systemctl services to run as a service "minecraft.service"
3. sudoers edited so that sudo is not required to edit/stop the minecraft service.


## Flow
1. pull candidate version
2. check new version against running.  if same, exit.
3. if candidate new, unpack to candidate folder
4. disable service
5. cp candidate/ files+folders to $BEDROCK_LOCATION
-rwxrwxr-x  bedrock_server
-rw-rw-r--  bedrock_server_how_to.html
-rwxr-xr-x  bedrock_server_symbols.debug
drwxrwxr-x  behavior_packs/
drwxrwxr-x  definitions/
-rw-rw-r--  release-notes.txt
drwxrwxr-x  resource_packs
6. enable the service
7. purge the candidate
