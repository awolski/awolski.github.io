---
layout: post
title:  "Refactoring with Groovy and runtime method invocation"
---

You can do some pretty awesome things with Groovy. 

I've been using the language in a number of projects for a couple of years now, and won't even think about whether to include it in anything new. It's in. No question. (Unless the enterprise forbids it.. rolling). I love the dynamic aspect of it. I love closures. I *really* love how easy the language makes it when working with Maps and Json (which I do a lot of lately); dot notation for field/attribute access is sooo powerful.

```groovy
def map = [firstName: 'Marty', surname: 'McFly']
println map.firstName
```

Last week I managed to take that power a little bit further by using dynamic/runtime method invocation. Reflection in Java but made *groovy*.

I have a class called `Jpa` which is a little wrapper around and `EntityManager` and the JPA criteria api. It uses a fluent builder type API so you can chain method calls in order to build up a query. For example

```groovy
@Inject Jpa jpa
...
List<Entity> list = jpa.queryFor(Entity.class)
                        .where(criteria)
                        .firstResult(first)
                        .maxResults(pageSize)
                        .orderBy(sortField)
                        .order(order)
                        .resultList()
```

In the above example `criteria` is a list of maps, each map a single criterion. For example, in Json this might look like:

```json
[
{
  "name": "firstName",
  "like": "Rich",
  ...
},
{
  "name": "surname",
  "like": "D",
  ...
},
  ...
] 
```

What got me looking into dynamic method invocation was needing to make a change to the `where(criteria)` method. What used to seem reasonably concise to me suddenly made me cringe. Way too much duplication in such a small code block:

```groovy
Query<T> where(criteria) {
   criteria.each { criterion ->
      if (criterion.containsKey('equals') && criterion.equals != null)
         predicates << cb.equal(root.get(criterion.name), criterion.equals)
      if (criterion.containsKey('like') && criterion.like != null)
         predicates << cb.like(root.get(criterion.name), "%$criterion.like%")
      if (criterion.containsKey('min') && Strings.emptyToNull(criterion.min) != null)
         predicates << cb.greaterThanOrEqualTo(root.get(criterion.name), criterion.min)
      if (criterion.containsKey('max') && Strings.emptyToNull(criterion.max) != null)
         predicates << cb.lessThanOrEqualTo(root.get(criterion.name), criterion.max)
      if (criterion.containsKey('in') && criterion.in)
         predicates << cb.in(root.get(criterion.name), criterion.in)
   }
   return this
}
```

Yuck... you can could do better than that!

Firstly, there's no need for multiple calls to `root.get(criterion.name)` in each and every if block, let's pull that out to a single statement at the top of the closure:

```groovy
criteria.each { criterion ->
   <b>Path<?> path = root.get(criterion.name)</b>
   ...
   if (criterion.containsKey('equals') && criterion.equals != null)
      predicates << cb.equal(<b>path</b>, criterion.equals)
   ...
```

The next thing I noticed was that the key checks, e.g. `criterion.containsKey('equals')`,  `criterion.containsKey('like')` were in nearly all cases checking the same method as was being invoked on the criteria builder, e.g. `cb.equal`, `cb.like`. I knew Groovy had an `eval` feature that would allow you to execute plain strings as though they were code, so I did some searching and found [this post](http://mrhaki.blogspot.co.uk/2010/03/groovy-goodness-invoke-methods.html) over at [mrhaki.com](http://www.mrhaki.com/) (awesome site btw).

So it looked like I could something along the lines of:

```groovy
cb."${like}"(path, param)
```

in place of all those explicit calls. I tested it out briefly with a small snippet of code and BOOM! it worked straight out of the box. I admit I got a little bit excited about the prospect of removing so much unnecessary code. I got to work riding that excitement...

I went about changing the operation keys in each criterion to match JPA's `CriteriaBuilder`'s methods: `equals` became `equal`, `min` became `greaterThanOrEqualTo` ... you get the idea.

Next I needed to pull only the **operation** key out of each criterion. For this I needed a list of supported operations

```groovy
final def operations = [ 
   'equal', 'like', 'greaterThanOrEqualTo', 'lessThanOrEqualTo', 'in' 
]
```
And pulling those out of each criterion:

```groovy
criteria?.each { c ->
   def ops = c.subMap(operations.keySet())
```

Now it's just a matter of checking that the `ops` and value for each `op` are present, and executing the operation on the `CriteriaBuilder` instance with the given name (path) and value. And now that there is only one call to root.get(c.name) there is no need to extract it to a local variable. Below is the complete method**:

```groovy
Query<T> where(criteria) {
   criteria?.each { c ->
      def ops = c.subMap(operations.keySet())
      ops?.each { k, v ->
         if (v) {
            predicates << cb."${k}"(root.get(c.name), v)
         }
      }
   }
   return this
}
```

Awesome sauce!

** I've omitted a few pieces of the final puzzle for brevity and to get the point across a little clearer. For example, what happens if `v` is actually a `Boolean` value of false, i.e. you're really searching for a field where the value is `false`? You'd never enter the block where the predicate is created. In my code I've created a few transform and filter functions for the supported operations, but I've left those out of the above snippet for clarity.