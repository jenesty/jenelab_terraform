resource "aws_elb" "hands-on-elb" {
    name = "hands-on-elb"
    subnets = ["${aws_subnet.public.*.id}"]
    listener {
        instance_port = 80
        instance_protocol = "http"
        lb_port = 80 # 通過用
        lb_protocol = "http"
    }
    listener {
        instance_port      = 80
        instance_protocol  = "http"
        lb_port            = 443
        lb_protocol        = "https"
        ssl_certificate_id = "arn:aws:acm:ap-northeast-1:056540312877:certificate/c8634856-b21f-49f7-97eb-f375a094490a"
    }
    health_check {
        healthy_threshold = 3
        unhealthy_threshold = 3
        timeout = 5
        target = "HTTP:80/index.html"
        interval = 30
    }
    security_groups = [
      "${aws_security_group.elb_security_group.id}"
    ]

    instances = [
      "${aws_instance.web.*.id}"
    ]
    cross_zone_load_balancing = true
    idle_timeout = 400
    connection_draining = true
    connection_draining_timeout = 400
    tags {
        Role = "ELB"
        Env= "Development"
    }
}