# Microservices Order System Infrastructure

This repository contains the supporting AWS infrastructure for the **Microservices Order System** portfolio project.

Its purpose is to separate cloud infrastructure and operational concerns from the application source code. The application repository focuses on the design and implementation of the microservices, while this repository focuses on the environment required to deploy, run, secure, and observe the system in AWS.

---

## Purpose

This repository serves as a practical demonstration of how a distributed application can be supported by a dedicated cloud infrastructure layer.

It is intended to document and evolve the AWS environment behind the project, including the architectural decisions required to operate the system outside a local development environment.

The main goals are to:

- Provide a clear separation between application code and infrastructure.
- Create a reproducible AWS environment for the portfolio project.
- Demonstrate Infrastructure as Code (IaC) and cloud architecture practices.
- Apply secure identity and access management principles.
- Support deployment, observability, reliability, and cost-aware infrastructure.
- Document architectural decisions and the evolution from a portfolio environment toward production-ready patterns.

---

## Relationship to the Application Repository

The business services and application architecture are maintained separately in:

**microservices-order-system**

Repository responsibilities are intentionally separated:

### Application Repository

- Business logic
- Microservice implementation
- Messaging and communication
- Testing
- Docker images
- Kubernetes application manifests

### Infrastructure Repository

- AWS infrastructure
- Infrastructure as Code
- Identity and Access Management (IAM)
- Networking
- Compute resources
- Container registry
- Observability
- Deployment infrastructure
- Infrastructure documentation
- Architecture Decision Records (ADRs)

---

## Scope

This is a learning and portfolio project rather than a production system.

The objective is to demonstrate how a modern distributed application can be deployed to AWS using industry practices while understanding the architectural trade-off behind each infrastructure component.

Whenever the portfolio intentionally differs from a production-grade solution, those trade-offs will be documented together with possible future improvements.

---

## Guiding Principles

The infrastructure evolves according to the following principles:

- Infrastructure should be reproducible rather than manually configured.
- Prefer temporary credentials and IAM roles over long-lived access keys.
- Apply the Principle of Least Privilege.
- Keep application and infrastructure responsibilities clearly separated.
- Introduce complexity only when it solves a concrete architectural problem.
- Consider security, observability, reliability, and cost from the beginning.
- Document important architectural decisions and trade-offs.
