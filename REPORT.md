# Brief report on design choices

## Why I chose alternative two

I took a good look at all the alternatives. I also imagined what the project would look like structurally even before I started setting it up. I also needed to take into consideration how complex the app would turn out and how complex I wanted the github workflows to be.

Because of all this, and because I didn't really see a reason why the different environments (dev, staging and prod) would have different configurations and resources, I decided on the "simplest" solution that shared everything. In order for this to work I leveraged terraform workspaces, but I could have just as easily set a variable in the root module that could set the current environment.

## Why I would choose alternative one in the future / for more complex projects

I like the idea of having separate terraform code for separate environments. That lets you test out different resources in a controlled manner, as well as being very flexible in general. It would also cause quite some 