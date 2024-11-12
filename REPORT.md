# Brief report on design choices

## Why I chose alternative two

I took a good look at all the alternatives. I also imagined what the project would look like structurally even before I started setting it up. I also needed to take into consideration how complex the app would turn out and how complex I wanted the github workflows to be.

Because of all this, and because I didn't really see a reason why the different environments (dev, staging and prod) would have different configurations and resources, I decided on the "simplest" solution that shared everything. In order for this to work I leveraged terraform workspaces, but I could have just as easily set a variable in the root module that could set the current environment.

## Why I would choose alternative one in the future / for more complex projects

I like the idea of having separate terraform code for separate environments. That lets you test out different resources in a controlled manner, as well as being very flexible in general. It would also cause quite some redundant code at places, but as long as modules are being effectively used, it would be minimal. Going for this solution during this assignment could have worked great, but I ultimately opted not to. Considering the requirements for this assignment included a requirement about the TA's being able to effectively edit the project, I could see alternative one being better than alternative 2.

## Other details

I strayed a bit from the structure in the example alternatives. I didn't find the global folder to be useful at all. I rather created a backend project that sets up some remote storage. 

I also didn't create a deployments folder as I didn't see that necessary either. Having main.tf in the root provided some benefits and ease of use.

For the load balancing part I used a gateway in front of the app service. I did find some load balancing attributes you could use in the `azurerm_linux_web_app` resource, but since the assignment text specifically linked to `azurerm_lb`, I decided to go for an actual load balancer. `azurerm_lb` apparently wasn't that good for this type of project so I decided to use `azurerm_application_gateway` instead.