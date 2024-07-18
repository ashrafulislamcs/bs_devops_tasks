tf-plan:
	terraform plan -var-file=prod.tfvars

tf-apply:
	terraform apply -var-file=prod.tfvars
	terraform apply -target=modules.vpc

tf-destroy:
	kubectl config use-context arn:aws:eks:eu-west-1:123456789123:cluster/test-eks
	kubectl delete ingress flarie-ingress -n prod
	terraform destroy -var-file=prod.tfvars