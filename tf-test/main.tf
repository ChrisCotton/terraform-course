variable "myvar" { 
    type = string
    default = "hello terraform"
}

variable "mymap" { 
    type = map
    default = {
        "key" = "myvalue"
    }
}

variable "mylist" { 
    type = list
    default = [ "key","myvalue",1,2,3 ]
}




