---

**RBAC**

---

Developer:
Can view PODs
Can create PODs
Can Delete PODs
Can Create ConfigMaps

**developer-role.yaml**

`kubectl get role`
`kubectl get rolebindings`

**check access**
`kubectl auth can-i create deployments`
`kubectl auth can-i delete node`
`kubectl auth can-i create deployments --as dev-user`
`kubectl auth can-i create pods --as dev-user`

**k8s resource names**
**metadata.name: Specifies the name of the resource.**
all resource name: purple ,green,pink , blue ,orange
developer sesource name: blue ,orange
