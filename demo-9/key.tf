
################################################################################
#                                                                              #
#   Key_pair makes sure our pub key is installed on instance.                  #
#   keys/mykeypair.pub is uploaded to allow ssh. NEVER UPLOAD PRIVATE KEY!!!   #
#   It is just used for login. Bastion box probaby best way to allow entire    #
#   team access whithout having to deal with too many keys???                  #
#                                                                              #
################################################################################

resource "aws_key_pair" "mykeypair" {
  key_name   = "tfkey"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}

