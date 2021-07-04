# EctoApi

This is one idea that I've been experiment with and I'm making it public so there can be some discussion to improve these ideas.
Although the name initially might drive someone to think that it's only for http api, the way i'm envisioning this is that it can be used with any sort of communication protocol.
Even asynchronous protocols might fit here.

## Proposed API

I'm thinking t mimic `Ecto.Repo` for `EctoApi` with some restrictions and additions:

- `insert_all` and `update_all` aren't planned to be available.
- `all` might happen, but not soon. I'm still uncertain if it's better to support a limitted version of `Ecto.Query` or build a proper DSL for this.
- `get_by` from `Ecto.Repo`usually just return a single entry so for the current lack of `all` I'm adding `get_all`.
- I'm currently working on how `preload` should work.
- so the available functions are `insert`, `update`, `delete`, `get`, `get_by`, `get_all`.

## Behaviours and internal nomenclature

- `EctoApi.Client`: this is where the side effects happen. All the communication are wrapped around this.
- `EctoApi.Resolver`: receives the metadata from the resource and received params and build all the information that `EctoApi.Client` needs to do the external communication.
- `EctoApi.Builder`: takes the response from the `EctoApi.Client` and cast the resource from it. It also dumps the resource to a proper structure that `EctoApi.Resolver` can use to build requests with it.

Although `EctoApi.Client` and `EctoApi.Resolver` hints to http and crud operations, this is not supposed to restrict implementations of those behaviors.
A GrapQL that only requires a `get` and `post` methods, might use the `put` and `delete` functions just to build context for the way to build the request.

## Current explorations and doubts

### Configuration and sensible defaults

I'm not a fan of library wide configurations.
I've been thinking to do something like `Ecto.Repo`, in a way that you implement `EctoApi` for your application and you set it for a single implementation.
Other possibility here is that the resource itself describes what should be used to resolve it, so a `User` would have `client/0`, `resolver/0` and `builder/0` functions returning the proper ones to be used with that specific resource.
The former might lead to difficuties when using resources that requires different resolvers, clients and builders.
The later might require a lot of boiler plate in place for a resource to be used.

### Preload and relations

There are some issues with relations and preloading them.

The first one that comes to mind is that some relations might just not work back and forth.
What I mean with it is that a `belongs_to` might not translate properly to a `has_one` or `has_many` relation.

Other issue that I see is about pagination.
For http apis this would make impossible to preload all the related resources with a single request.
Should it go through all pages with a single preload or it's better to set pagination options when preloading and allow to preload more data with other later requests.
This not only relates to the lazyness of the operation but on the proper way to configure the relation and set the default pagination.

## Additions and possible nice features to have in the future

I'm thinking to add some caching and pooling strategies but this only can come up once the configuration and preload explorations are done.
Besides that I'm thinking to have a default Clients/Resolvers for basic restful apis, jsonapi specification and graphql.
I didn't explore grpc yet, but it might make sense to have one for it too.
