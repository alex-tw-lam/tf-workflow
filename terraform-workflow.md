```mermaid
flowchart-elk TB
    %% Node definitions
    Start((Start)) --> A[User Input Schema]
    A -->|Code| CI

    subgraph CI[Continuous Integration]
        direction TB
        V1[Format Test: terraform fmt] & V2[Syntax Test: terraform validate] & V3[Best Practices: tflint] & V4[Security Scan: checkov/tfsec] & V7[Secret Detection: gitleaks] & V8[Policy Check: OPA/Conftest] --> V5{All Valid?}
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
    V5 -->|Fail| Stop((End))
    F -->|No| Stop
    K -->|No| Stop
    I -->|No| Stop
    J --> Stop

    %% Styling
    style Start fill:#2ecc71,stroke:#27ae60,stroke-width:2px,color:white
    style Stop fill:#e74c3c,stroke:#c0392b,stroke-width:2px,color:white
    
    %% Activity nodes
    style A fill:#3498db,stroke:#2980b9,stroke-width:2px,color:white
    style D fill:#3498db,stroke:#2980b9,stroke-width:2px,color:white
    style G fill:#3498db,stroke:#2980b9,stroke-width:2px,color:white
    style L fill:#3498db,stroke:#2980b9,stroke-width:2px,color:white
    style H fill:#3498db,stroke:#2980b9,stroke-width:2px,color:white
    style J fill:#3498db,stroke:#2980b9,stroke-width:2px,color:white

    %% Test nodes
    style V1 fill:#9b59b6,stroke:#8e44ad,stroke-width:2px,color:white
    style V2 fill:#9b59b6,stroke:#8e44ad,stroke-width:2px,color:white
    style V3 fill:#9b59b6,stroke:#8e44ad,stroke-width:2px,color:white
    style V4 fill:#9b59b6,stroke:#8e44ad,stroke-width:2px,color:white
    style V7 fill:#9b59b6,stroke:#8e44ad,stroke-width:2px,color:white
    style V8 fill:#9b59b6,stroke:#8e44ad,stroke-width:2px,color:white

    %% Decision nodes
    style V5 fill:#f1c40f,stroke:#f39c12,stroke-width:2px,color:black
    style E fill:#f1c40f,stroke:#f39c12,stroke-width:2px,color:black
    style F fill:#f1c40f,stroke:#f39c12,stroke-width:2px,color:black
    style K fill:#f1c40f,stroke:#f39c12,stroke-width:2px,color:black
    style I fill:#f1c40f,stroke:#f39c12,stroke-width:2px,color:black

```

# Infrastructure Change Flow

The basic steps:

1. **Start**: Begin workflow
2. **User Input Schema**: Define infrastructure changes using structured schema
3. **Continuous Integration**:
   - Format Test: Ensure consistent code style and formatting
   - Syntax Test: Validate HCL configuration structure
   - Best Practices: Check for Terraform best practices and patterns
   - Security Scan: Comprehensive security and compliance scanning (checkov/tfsec)
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