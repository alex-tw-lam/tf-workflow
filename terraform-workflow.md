```mermaid
flowchart-elk TB
    Start((Start)) --> A[User Input Schema]
    A -->|Code| CI

    subgraph CI[Continuous Integration]
        direction TB
        V1[Format Test: terraform fmt] & V2[Syntax Test: terraform validate] & V3[Best Practices: tflint] & V4[Security Scan: checkov] & V6[Cloud Security: tfsec] & V7[Secret Detection: gitleaks] & V8[Policy Check: OPA/Conftest] --> V5{All Valid?}
    end

    subgraph CD[Continuous Delivery]
        direction TB
        D[Plan] --> E{Destroy in Plan?}
        E -->|No| G[Cost Estimation]
        E -->|Yes| F{Confirm Destroy?}
        F -->|Yes| G
        G --> K{Accept Costs?}
        K -->|Yes| L[Commit tfvars]
        L --> H[Apply]
        H --> I{Success?}
        I -->|Yes| J[Show Connection Credentials]
    end

    V5 -->|Success| D
    V5 -->|Fail| End((End))
    F -->|No| End
    K -->|No| End
    I -->|No| End
    J --> End
```

# Infrastructure Change Flow

The basic steps:

1. **Start**: Begin workflow
2. **User Input Schema**: Define infrastructure changes using structured schema
3. **Continuous Integration**:
   - Format Test: Ensure consistent code style and formatting
   - Syntax Test: Validate HCL configuration structure
   - Best Practices: Check for Terraform best practices and patterns
   - Security Scan: Detect security vulnerabilities and misconfigurations
   - Cloud Security: Identify cloud-specific security risks
   - Secret Detection: Find exposed secrets and credentials
   - Policy Check: Enforce organizational policies and compliance
   - All checks must pass to proceed
   - If any check fails, workflow ends
   - If all checks pass, continue to delivery phase
4. **Continuous Delivery**:
   - Plan: Preview what will change
   - Check for destroy operations
   - Estimate and review costs
   - Commit approved changes as tfvars
   - Apply changes
   - Verify success
   - Show access credentials
5. **End**: Workflow complete