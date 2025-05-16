# OnPrem RAG Pipeline Helm Chart

A Helm chart for deploying an on-prem Retrieval‑Augmented Generation (RAG) pipeline using:

* **ChromaDB**: Vector database for embeddings and similarity search
* **LangChain**: Orchestration layer for LLM-driven retrieval and generation
* **Ollama**: Locally‑hosted LLM service

---

## Prerequisites

* Kubernetes cluster (v1.20+)
* Helm v3.6+
* Docker registry access for your `Ollama` image (default: `localhost:5000/ollama`)

---

## Installation

1. Add this chart to your local workspace (or publish to your Helm repo):

   ```bash
   git clone https://github.com/t-chamb/onprem-rag-pipeline.git
   cd onprem-rag-pipeline
   ```

2. Review and customize `values.yaml`:

   * `chromadb.image.repository` / `tag`
   * `langchain.image.repository` / `tag`
   * `ollama.image.repository` / `tag`
   * Enable/disable **Ingress** and **HPA** by toggling the commented sections

3. Install the chart:

   ```bash
   helm install rag-pipeline ./ \
     --namespace rag-system --create-namespace \
     --set ingress.enabled=true \
     --set autoscaling.enabled=true
   ```

---

## Configuration

The following parameters can be configured in `values.yaml`:

| Parameter                                 | Description                                | Default                 |
| ----------------------------------------- | ------------------------------------------ | ----------------------- |
| `chromadb.image.repository`               | ChromaDB Docker image repository           | `chromadb/chromadb`     |
| `chromadb.image.tag`                      | ChromaDB image tag                         | `latest`                |
| `chromadb.service.port`                   | Service port for ChromaDB                  | `8000`                  |
| `langchain.image.repository`              | LangChain RAG app image repository         | `myrepo/langchain-rag`  |
| `langchain.image.tag`                     | LangChain app image tag                    | `latest`                |
| `langchain.service.port`                  | Service port for LangChain app             | `8080`                  |
| `ollama.image.repository`                 | Ollama image repository                    | `localhost:5000/ollama` |
| `ollama.image.tag`                        | Ollama image tag                           | `latest`                |
| `ollama.service.port`                     | Service port for Ollama LLM service        | `11434`                 |
| `ingress.enabled`                         | Enable Ingress (commented out by default)  | `false`                 |
| `autoscaling.enabled`                     | Enable HPA for deployments (commented out) | `false`                 |
| `autoscaling.minReplicas` / `maxReplicas` | Min/max replicas for HPA                   | `1` / `5`               |

---

## Usage

* Once installed, ChromaDB will be available at `http://<chart>-chromadb:<port>` inside your cluster.
* LangChain app will retrieve embeddings from ChromaDB and query Ollama for completion.
* Enable Ingress to expose endpoints externally, or port‑forward services for local testing.

### Port‑Forward (example)

```bash
kubectl port-forward svc/<release-name>-langchain 8080:8080 -n rag-system
```

Open your browser at `http://localhost:8080`.

---

## Contributing

1. Fork the repo
2. Create your feature branch: `git checkout -b feature/my-feature`
3. Commit your changes: `git commit -m "Add awesome feature"`
4. Push to the branch: `git push origin feature/my-feature`
5. Open a Pull Request

---

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.


