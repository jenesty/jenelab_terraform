resource "aws_elb" "hands-on-ELB" {
    name = "hands-on-ELB"
    subnets = ["${aws_subnet.public.*.id}"]
    listener {
        instance_port = 80
        instance_protocol = "http"
        lb_port = 80 # 通過用
        lb_protocol = "http"
    }
    health_check {
        healthy_threshold = 3
        unhealthy_threshold = 3
        timeout = 5
        target = "HTTP:80/"
        interval = 30
    }
    security_groups = [
      "${aws_security_group.ELB-SG.id}"
    ]

    instances = [
      "${aws_instance.Web.*.id}"
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