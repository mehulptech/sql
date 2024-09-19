# Assignment 1: Design a Logical Model

## Question 1

Create a logical model for a small bookstore. 📚

At the minimum it should have employee, order, sales, customer, and book entities (tables). Determine sensible column and table design based on what you know about these concepts. Keep it simple, but work out sensible relationships to keep tables reasonably sized. Include a date table. There are several tools online you can use, I'd recommend [_Draw.io_](https://www.drawio.com/) or [_LucidChart_](https://www.lucidchart.com/pages/).

![ER Diagram](./model-design-answer-1.png)

## Question 2

We want to create employee shifts, splitting up the day into morning and evening. Add this to the ERD.

![ER Diagram](./model-design-answer-2.png)

## Question 3

The store wants to keep customer addresses. Propose two architectures for the CUSTOMER_ADDRESS table, one that will retain changes, and another that will overwrite. Which is type 1, which is type 2?

_Hint, search type 1 vs type 2 slowly changing dimensions._

## Schema for Overwriting (Type 1):

![ER Diagram](./model-design-answer-3-type-1.png)

## Schema for Retaining Changes (Type 2):

![ER Diagram](./model-design-answer-3-type-2.png)

Bonus: Are there privacy implications to this, why or why not?

```
** Yes, there are both security and privacy implications of deciding to go with either Type 1 or Type 2 table schema.

1) With Type 1 (overwrite), the customer always has one single address stored at any given time, while all their old addresses are overwritten. This helps retain lesser amount of personal identifiable information about the customer.
==> Typical Usage of this schema: This type of schema is ideal for an school/college student record database allowing to forget old student addresses and overwriting it with the new one.

2) With Type 2 (retaining old historical changes), all prior addresses of the customer are retained unless explicitly deleted from the system. This creates higher security and privacy issues compared to Type 1 schema.
==> Typical Usage of this schema: May be a credit score company would like to retain all the customer addresses to make sure they can validate a customer based on any of the older addresses. Or, an ecommerce store allowing customer to add any number of shipping addresses. **

```

## Question 4

Review the AdventureWorks Schema [here](https://i.stack.imgur.com/LMu4W.gif)

Highlight at least two differences between it and your ERD. Would you change anything in yours?

```
**
Yes, there is a lot of things that I might prefer to change in my ERD when I see the AdventureWorks Schema. Not in any particular order, but some of these things would be:
1) Better color coding to group similar category of tables together for easy identification. Like Employee and Shift tables can be grouped together, customer and customer_address can be grouped together and book, order, sales table can be grouped together in a different colour notation for better readability and understanding of the architecture.
2) Majority of the tables in the AdventureWorks Schema has the "ModifiedDate" column signifying the tracking of changes happened in the database. This helps with the audit trail of the data management in terms of carrying out various Create, Read, Update and Delete (CRUD) operations
3) AdventureWorks Schema also uses a separate group of tables that resides under "dbo" to record host of information like various accesses to the database, database errors, and meta data about the database like version, modified date, etc. which helps with the server upgrades and migrations when needed.
**
```

# Criteria

[Assignment Rubric](./assignment_rubric.md)

# Submission Information

🚨 **Please review our [Assignment Submission Guide](https://github.com/UofT-DSI/onboarding/blob/main/onboarding_documents/submissions.md)** 🚨 for detailed instructions on how to format, branch, and submit your work. Following these guidelines is crucial for your submissions to be evaluated correctly.

### Submission Parameters:

- Submission Due Date: `September 28, 2024`
- The branch name for your repo should be: `model-design`
- What to submit for this assignment:
  - This markdown (design_a_logical_model.md) should be populated.
  - Two Entity-Relationship Diagrams (preferably in a pdf, jpeg, png format).
- What the pull request link should look like for this assignment: `https://github.com/<your_github_username>/sql/pull/<pr_id>`
  - Open a private window in your browser. Copy and paste the link to your pull request into the address bar. Make sure you can see your pull request properly. This helps the technical facilitator and learning support staff review your submission easily.

Checklist:

- [ ] Create a branch called `model-design`.
- [ ] Ensure that the repository is public.
- [ ] Review [the PR description guidelines](https://github.com/UofT-DSI/onboarding/blob/main/onboarding_documents/submissions.md#guidelines-for-pull-request-descriptions) and adhere to them.
- [ ] Verify that the link is accessible in a private browser window.

If you encounter any difficulties or have questions, please don't hesitate to reach out to our team via our Slack at `#cohort-4-help`. Our Technical Facilitators and Learning Support staff are here to help you navigate any challenges.
