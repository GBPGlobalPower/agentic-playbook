# Threat model: <feature> (YYYY-MM-DD)

- **Ticket**: <id> · **Requirements**: <ids> · **Reviewed by**: <…>

## 1. What we're protecting

| Asset | Why it matters | Who should have it |
| -- | -- | -- |
| <e.g. invoice PDFs> | Customer billing data | The issuing workspace; the customer through a signed link |

## 2. Who might attack

<Other tenants, a member after leaving, someone with an unlocked device, a malicious client build, a compromised dependency, an insider with dashboard access.>

## 3. Entry points

| Entry point | Auth | Trust boundary |
| -- | -- | -- |
| <RPC / endpoint / bucket / deep link / push payload> | <…> | <client → API> |

## 4. Threats (STRIDE per entry point)

| Entry point | Threat (S/T/R/I/D/E) | Scenario | Existing control | Gap? | Severity |
| -- | -- | -- | -- | -- | -- |
| | **I**nformation disclosure | <another tenant selects the column directly> | <column revoked; RPC checks membership> | none | — |

S = spoofing, T = tampering, R = repudiation, I = information disclosure, D = denial of service, E = elevation of privilege.

## 5. Mitigations

| Gap | Mitigation | Ticket | Test that proves it |
| -- | -- | -- | -- |

## 6. Accepted risks

<Logged in the Decision Log with revisit triggers.>
