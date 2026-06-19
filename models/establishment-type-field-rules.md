# Establishment Type Field Rules

This document lists the field-applicability rules that are expressed as SHACL shapes in `establishment-details-shacl.ttl`. Each rule says whether a field or group of fields is **required**, **optional** or **not applicable** for a given establishment type or type group.

Rules are grouped by type group, then by specific type where a type differs from the group rule. They map directly to shapes in the SHACL file — the shape name is given in brackets where useful for traceability.

---

## Rules that apply to every establishment

These rules apply regardless of establishment type.

| What | Rule |
| --- | --- |
| Establishment identity record | Required — exactly one |
| Unique Reference Number (URN) | Required — exactly one |
| Establishment lifecycle record | Required — exactly one |
| Establishment status | Required — exactly one |
| Establishment classification record | Required — exactly one |
| Establishment type | Required — exactly one |

---

## LA maintained schools

Covers: Community school, Voluntary aided school, Voluntary controlled school, Foundation school, Community special school, Foundation special school, Pupil referral unit, Local authority nursery school.

### Rules shared by the whole group

| What | Rule |
| --- | --- |
| Local authority accountability | Required — at least one |
| Academy trust accountability | Not applicable |
| Proprietor accountability | Not applicable |
| Education, admissions and provision record | Required |
| Gender of entry | Required |
| Boarding provision | Required |

### Additional rules for mainstream LA schools only

Covers: Community school, Voluntary aided school, Voluntary controlled school, Foundation school.

| What | Rule |
| --- | --- |
| Education phase | Required |
| Admissions policy | Required |
| Nursery provision | Required |
| Sixth-form provision | Required |
| Faith context | Optional |

### Additional rules for LA special schools

Covers: Community special school, Foundation special school.

These types differ from mainstream LA schools as follows.

| What | Rule | Reason |
| --- | --- | --- |
| SEN and resourced provision | Required | These establishments exist specifically to provide special educational needs support |
| Admissions policy | Not applicable | Places are allocated by local authority decision, not standard admissions |
| Nursery provision | Not applicable | |
| Sixth-form provision | Not applicable | |

### Additional rules for pupil referral units

| What | Rule | Reason |
| --- | --- | --- |
| Admissions policy | Not applicable | Places are allocated by local authority decision, not standard admissions |
| Nursery provision | Not applicable | |
| Sixth-form provision | Not applicable | |

### Additional rules for local authority nursery schools

| What | Rule |
| --- | --- |
| Education phase | Required (expected value: Nursery) |
| Admissions policy | Not applicable |
| Sixth-form provision | Not applicable |

---

## Non-maintained special schools

Covers: Non-maintained special school, Other independent special school.

| What | Rule | Reason |
| --- | --- | --- |
| Proprietor accountability | Required | These are privately operated, not LA maintained |
| Local authority accountability | Not applicable | |
| Academy trust accountability | Not applicable | |
| SEN and resourced provision | Required | These establishments exist specifically to provide special educational needs support |
| Admissions policy | Not applicable | Places are allocated by local authority decision |
| Sixth-form provision | Not applicable | |

---

## Independent schools

Covers: City technology college, Other independent school.

| What | Rule |
| --- | --- |
| Proprietor accountability | Required |
| Local authority accountability | Not applicable |
| Academy trust accountability | Not applicable |
| Education phase | Required |
| Gender of entry | Required |
| Admissions policy | Required |
| Boarding provision | Required |
| Faith context | Optional |

---

## Mainstream academies

Covers: Academy sponsor led, Academy converter.

| What | Rule |
| --- | --- |
| Academy trust accountability | Required |
| Local authority accountability | Not applicable |
| Proprietor accountability | Not applicable |
| Education phase | Required |
| Gender of entry | Required |
| Admissions policy | Required |
| Boarding provision | Required |
| Nursery provision | Required |
| Sixth-form provision | Required |
| Faith context | Optional |

### Academy special schools

Covers: Academy special sponsor led, Academy special converter.

These types differ from mainstream academies as follows.

| What | Rule | Reason |
| --- | --- | --- |
| SEN and resourced provision | Required | These establishments exist specifically to provide special educational needs support |
| Admissions policy | Not applicable | Places are allocated by local authority decision |
| Nursery provision | Not applicable | |
| Sixth-form provision | Not applicable | |

### Academy alternative provision

Covers: Academy alternative provision converter, Academy alternative provision sponsor led.

| What | Rule | Reason |
| --- | --- | --- |
| Admissions policy | Not applicable | Referral-based placement, not standard admissions |
| Nursery provision | Not applicable | |
| Sixth-form provision | Not applicable | |

### Academy 16-19

Covers: Academy 16-19 converter, Academy 16 to 19 sponsor led.

| What | Rule | Reason |
| --- | --- | --- |
| Admissions policy | Not applicable | |
| Nursery provision | Not applicable | |
| Sixth-form provision | Not applicable | These establishments are themselves 16-19 provision |

### Academy secure 16 to 19

This type has a significantly restricted public Details view — only 17 fields are publicly visible, compared to 30 or more that are mapped in the underlying database.

| What | Rule |
| --- | --- |
| Academy trust accountability | Required |
| Admissions policy | Not applicable in public view |
| Boarding provision | Not applicable in public view |
| Nursery provision | Not applicable |
| Sixth-form provision | Not applicable |
| Faith context | Not applicable in public view |

---

## Mainstream free schools

Covers: Free schools, University technical college, Studio schools.

| What | Rule |
| --- | --- |
| Academy trust accountability | Required |
| Local authority accountability | Not applicable |
| Proprietor accountability | Not applicable |
| Education phase | Required |
| Gender of entry | Required |
| Admissions policy | Required |
| Boarding provision | Required |
| Nursery provision | Required |
| Sixth-form provision | Required |
| Faith context | Optional |

### Free school special

| What | Rule | Reason |
| --- | --- | --- |
| SEN and resourced provision | Required | These establishments exist specifically to provide special educational needs support |
| Admissions policy | Not applicable | Places are allocated by local authority decision |
| Nursery provision | Not applicable | |
| Sixth-form provision | Not applicable | |

### Free school alternative provision

| What | Rule | Reason |
| --- | --- | --- |
| Admissions policy | Not applicable | Referral-based placement, not standard admissions |
| Nursery provision | Not applicable | |
| Sixth-form provision | Not applicable | |

### Free school 16 to 19

| What | Rule | Reason |
| --- | --- | --- |
| Admissions policy | Not applicable | |
| Nursery provision | Not applicable | |
| Sixth-form provision | Not applicable | These establishments are themselves 16-19 provision |

---

## Colleges

Covers: Further education, Sixth form centre.

| What | Rule | Reason |
| --- | --- | --- |
| Local authority accountability | Not applicable | Colleges are not LA maintained |
| Academy trust accountability | Not applicable | |
| Proprietor accountability | Not applicable | |
| Education phase | Not applicable | |
| Admissions policy | Not applicable | |
| Gender of entry | Not applicable | |
| Nursery provision | Not applicable | |
| Sixth-form provision | Not applicable | These establishments are sixth form or further education |
| Faith context | Not applicable | |
| SEN and resourced provision | Not applicable | |

---

## Higher education institutions

Covers: Higher education institution.

| What | Rule |
| --- | --- |
| Local authority accountability | Not applicable |
| Academy trust accountability | Not applicable |
| Proprietor accountability | Not applicable |
| Education phase | Not applicable |
| Admissions policy | Not applicable |
| Gender of entry | Not applicable |
| Boarding provision | Not applicable |
| Nursery provision | Not applicable |
| Sixth-form provision | Not applicable |
| Faith context | Not applicable |
| SEN and resourced provision | Not applicable |

---

## Children's centres

Covers: Children's centre, Children's centre linked site.

| What | Rule |
| --- | --- |
| Local authority accountability | Required |
| Academy trust accountability | Not applicable |
| Proprietor accountability | Not applicable |
| Education phase | Not applicable |
| Admissions policy | Not applicable |
| Gender of entry | Not applicable |
| Boarding provision | Not applicable |
| Sixth-form provision | Not applicable |
| Faith context | Not applicable |
| SEN and resourced provision | Not applicable |

---

## Online providers

Covers: Online provider.

This type has a distinct Details view. Open date represents accreditation date; closed date represents accreditation date ended. An accreditation and quality assurance section replaces the standard school provision fields.

| What | Rule |
| --- | --- |
| Local authority accountability | Not applicable |
| Academy trust accountability | Not applicable |
| Proprietor accountability | Not applicable |
| Education phase | Not applicable |
| Admissions policy | Not applicable |
| Gender of entry | Not applicable |
| Boarding provision | Not applicable |
| Nursery provision | Not applicable |
| Sixth-form provision | Not applicable |
| Faith context | Not applicable |
| SEN and resourced provision | Not applicable |

---

## Welsh establishments

Covers: Welsh establishment.

Rules mirror mainstream LA maintained schools.

| What | Rule |
| --- | --- |
| Local authority accountability | Required |
| Academy trust accountability | Not applicable |
| Proprietor accountability | Not applicable |
| Education phase | Required |
| Gender of entry | Required |
| Admissions policy | Required |
| Boarding provision | Required |
| Faith context | Optional |

---

## Special post-16 institutions

Covers: Special post 16 institution.

| What | Rule |
| --- | --- |
| SEN and resourced provision | Required |
| Admissions policy | Not applicable |
| Nursery provision | Not applicable |
| Sixth-form provision | Not applicable |

---

## British schools overseas

Covers: British schools overseas.

| What | Rule |
| --- | --- |
| Proprietor accountability | Required |
| Local authority accountability | Not applicable |
| Academy trust accountability | Not applicable |
| Education phase | Required |
| Gender of entry | Required |
| Faith context | Optional |

---

## Types with provisional or unknown rules

The following types require further analysis of actual GIAS data before strong field-applicability rules can be stated. No SHACL constraints are defined for them in the current version.

| Type | Type code | Notes |
| --- | --- | --- |
| Secure units | 24 | Variable field set |
| Offshore schools | 25 | Variable field set |
| Service children's education | 26 | Variable field set — similar to mainstream schools |
| Miscellaneous | 27 | Catch-all; rules depend on individual record |
| Institution funded by other government department | 56 | Variable; depends on nature of institution |
