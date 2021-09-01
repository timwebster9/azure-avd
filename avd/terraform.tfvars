location = "uksouth"

host_pools = {
    pooled = {
        name               = "pooledhostpool"
        description        = "A pooled host pool"
        type               = "Pooled"
        max_sessions       = "2"
        load_balancer_type = "DepthFirst"
    }
    personal = {
        name               = "personalhostpool"
        description        = "A personal host pool"
        type               = "Personal"
        max_sessions       = "2"
        load_balancer_type = "BreadthFirst"
    }
}

registration_expiry_date = "2021-09-20T08:00:00Z"