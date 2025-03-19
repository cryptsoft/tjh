# Background

Diagrams to support discussion about the differences between the NIST and IETF viewpoints on ML-DSA and <i>external Mu</i>.


# FIPS 204 ML-DSA

Standard ML-DSA high level flow. No externalMu.

```mermaid
sequenceDiagram
  %% FIPS204 ML-DSA
  autonumber
  actor Application
  participant Module A as Module A
  
  Application->>+Module A: ML-DSA.Sign(sk,M,ctx)
  Module A->>+Module A: generate random rnd
  Module A->>+Module A: construct M'
  rect rgb(191,223,255)
    Module A->>+Module A: ML-DSA.Sign_internal(sk,M',rnd)
    Module A->>+Module A: compute mu from tr and M'
  end
  Module A-->>-Application: return signature
  ```

# FIPS 204 HashML-DSA

Standard HashML-DSA high level flow. No externalMu.

```mermaid
sequenceDiagram
  %% FIPS204 ML-DSA
  autonumber
  actor Application
  participant Module A as Module A
  
  Application->>+Module A: HashML-DSA.Sign(sk,M,ctx,PH)
  Module A->>+Module A: generate random rnd
  Module A->>+Module A: construct M'
  rect rgb(191,223,255)
    Module A->>+Module A: ML-DSA.Sign_internal(sk,M',rnd)
    Module A->>+Module A: compute mu from tr and M'
  end
  Module A-->>-Application: return signature
```  

# FIPS 204 NISTFAQ ML-DSA

Standard ML-DSA high level flow with
externalMu using flow documented in 
[NIST FAQ](https://csrc.nist.gov/Projects/post-quantum-cryptography/faqs#Rdc7)

```mermaid
sequenceDiagram
  %% FIPS204 NISTFAQ ML-DSA
  %% https://csrc.nist.gov/Projects/post-quantum-cryptography/faqs#Rdc7
  autonumber
  actor Application
  participant Module A as Module A<br><br>(computes mu)
  participant Module B as Module B<br><br>(signing module)
  
  Application->>+Module A: ML-DSA.Sign(sk,M,ctx)
  Module A->>+Module A: construct M'
  Module A->>+Module A: compute tr from pk
  Module A->>+Module A: compute mu from tr and M'
  rect rgb(191,223,255)
    Module A->>+Module B: ML-DSA.sign_mu(sk,mu)
    Module B->>Module B: generate random rnd
    Module B->>Module B: ML-DSA.Sign_internal_mu(sk,mu,rnd)
    Module B-->>-Module A: return signature
  end
  Module A-->>-Application: return signature
```  

# FIPS 204 NISTFAQ HashML-DSA

Standard HashML-DSA high level flow with
externalMu using flow documented in 
[NIST FAQ](https://csrc.nist.gov/Projects/post-quantum-cryptography/faqs#Rdc7)


```mermaid
sequenceDiagram
  %% FIPS204 NISTFAQ Hash-ML-DSA
  %% https://csrc.nist.gov/Projects/post-quantum-cryptography/faqs#Rdc7
  autonumber
  actor Application
  participant Module A as Module A<br><br>(computes mu)
  participant Module B as Module B<br><br>(signing module)
  
  Application->>+Module A: HashML-DSA.Sign(sk,M,ctx,PH)
  Module A->>+Module A: construct M'
  Module A->>+Module A: compute tr from pk
  Module A->>+Module A: compute mu from tr and M'
  rect rgb(191,223,255)
    Module A->>+Module B: ML-DSA.sign_mu(sk,mu)
    Module B->>Module B: generate random rnd
    Module B->>Module B: ML-DSA.Sign_internal_mu(sk,mu,rnd)
    Module B-->>-Module A: return signature
  end
  Module A-->>-Application: return signature
```  

# FIPS 204 IETF ExternalMu ML-DSA

IETF variant of ML-DSA using externalMu using flow documented in
[draft-ietf-lamps-dilithium-certificates-07](https://datatracker.ietf.org/doc/draft-ietf-lamps-dilithium-certificates/)


```mermaid
sequenceDiagram
  %% FIPS204 IETF External MU ML-DSA
  %% https://datatracker.ietf.org/doc/draft-ietf-lamps-dilithium-certificates/
  autonumber
  actor Application
  participant Module A as Module A<br><br>(computes mu)
  participant Module B as Module B<br><br>(signing module)
  
  Application->>+Module A: ExternalMu-ML-DSA.Prehash(pk, M, ctx)
  Module A->>+Module A: construct M'
  Module A->>+Module A: compute tr from pk
  Module A->>+Module A: compute mu from tr and M'
  Module A-->>-Application: return mu
  Application->>+Module B: ExternalMu-ML-DSA.Sign(sk, mu)
  rect rgb(191,223,255)
    Module B->>Module B: generate random rnd
    Module B->>Module B: ExternalMu-ML-DSA.Sign_internal(sk,mu,rnd)
  end
  Module B-->>-Application: return signature
  
```  

# FIPS 204 IETF ExternalMu ML-DSA In Reality

IETF variant of ML-DSA using externalMu using what 
the IETF participants expect to see. There is no special
module interface for externalMu calculation - it is just a
standard Hash usage. There are not two modules - only one.


```mermaid
sequenceDiagram
  %% FIPS204 IETF External MU ML-DSA In Reality
  %% https://datatracker.ietf.org/doc/draft-ietf-lamps-dilithium-certificates/
  autonumber
  actor Application
  participant Module A as Module A<br><br>(computes Hash, performs signing)
  
  Application->>+Application: construct M'
  Application->>+Application: compute tr from pk
  Application->>+Application: construct BytesToHash = BytesToBits(tr)||M' 
  Application->>+Module A: Hash(BytesToHash,64)
  Module A-->>-Application: return mu
  Application->>+Module A: ExternalMu-ML-DSA.Sign(sk, mu)
  rect rgb(191,223,255)
    Module A->>Module A: generate random rnd
    Module A->>Module A: ExternalMu-ML-DSA.Sign_internal(sk,mu,rnd)
  end
  Module A-->>-Application: return signature
  
```  

