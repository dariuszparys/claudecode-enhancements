# Azure Boards Plugin

Azure DevOps Boards integration for Claude Code. Provides an auto-invoked skill for working with Product Backlog Items (PBIs), Bugs, and Tasks using the `az boards` CLI.

## Prerequisites

### 1. Azure CLI

Install the Azure CLI:

```bash
# macOS
brew install azure-cli

# Windows
winget install Microsoft.AzureCLI

# Linux (Ubuntu/Debian)
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
```

### 2. Azure DevOps CLI Extension

Install the Azure DevOps extension:

```bash
az extension add --name azure-devops
```

### 3. Personal Access Token (PAT)

Create a PAT with the required permissions:

1. Go to Azure DevOps → User Settings → Personal Access Tokens
2. Click **New Token**
3. Set the following:
   - **Name**: `claude-code-boards` (or any name)
   - **Organization**: Select your organization
   - **Expiration**: Set appropriate expiration
   - **Scopes**: Select **Custom defined**, then:
     - **Work Items**: Read & Write
     - **Project and Team**: Read (optional, for iteration paths)

4. Copy the token and store it securely

### 4. Authentication

Authenticate with your PAT:

```bash
# Option A: Environment variable (recommended)
export AZURE_DEVOPS_EXT_PAT=<your-pat>

# Option B: Login interactively
az login

# Option C: Login with PAT directly
az devops login --token <your-pat>
```

## Configuration

Set your default organization and project:

```bash
az devops configure --defaults \
  organization=https://dev.azure.com/<your-org> \
  project=<your-project>
```

### Verify Configuration

```bash
# Test the connection
az boards work-item show --id 1

# List your assigned work items
az boards query --wiql "SELECT [System.Id], [System.Title] FROM WorkItems WHERE [System.AssignedTo] = @Me" --output table
```

## Customization

### Iteration Path

The skill uses iteration paths for sprint queries. Update the SKILL.md if your organization uses a different iteration path structure:

Default pattern: `{Project}\{Sprint}`
Example: `MyProject\Sprint 1`

Some organizations use deeper paths:
- `MyProject\Release 1\Sprint 1`
- `MyProject\2024\Q1\Sprint 1`

### Work Item Types

The skill is configured for common work item types:
- Product Backlog Item
- Bug
- Task

If your organization uses custom work item types, you may need to update the WIQL queries in the skill.

## What This Plugin Provides

### Auto-Invoked Skill

The `azure-boards` skill is automatically invoked by Claude when you:
- Mention Azure DevOps, Azure Boards, or PBI
- Provide a work item ID to fetch or update
- Ask about sprint work or iteration paths
- Need WIQL queries

### Capabilities

| Operation | Command |
|-----------|---------|
| Fetch work item | `az boards work-item show --id {id}` |
| Update fields | `az boards work-item update --id {id} --fields ...` |
| Query work items | `az boards query --wiql "..."` |
| Create task | `az boards work-item create --type Task ...` |

## Usage Examples

Once the plugin is installed and configured, Claude will automatically use Azure Boards commands when relevant:

```
User: "Show me PBI 12345"
Claude: [Uses az boards work-item show --id 12345]

User: "What work items are assigned to me in Sprint 3?"
Claude: [Uses az boards query with WIQL for your sprint]

User: "Update the description of work item 12345"
Claude: [Uses az boards work-item update]
```

## Troubleshooting

### "az: command not found"
Azure CLI is not installed or not in PATH. Install it following the prerequisites above.

### "The following extension is not installed: azure-devops"
Run: `az extension add --name azure-devops`

### "TF401019: The Git repository with name or identifier does not exist"
Your default project is not set correctly:
```bash
az devops configure --defaults project=<correct-project-name>
```

### "VS403392: Personal access token is invalid"
Your PAT may have expired or lacks the required permissions. Create a new token with Work Items: Read & Write scope.

### "The iteration path does not exist"
Your iteration path format may differ. Check your organization's iteration structure:
```bash
az boards iteration project list --output table
```
