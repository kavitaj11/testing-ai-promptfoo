# 📘 Week 2: Modular Prompts with Variables & External References

## 📖 Overview
This week demonstrates how to build **modular prompts** using variables and external file references.  
The approach ensures prompts are reusable, maintainable, and easy to extend.

---

## 📂 Project Structure
```plaintext
week_2/
├── promptfooconfig.yaml         # Main configuration file
├── providers/                   # Provider configurations
│   ├── providers.yaml           # Default providers
│   └── providers_spec.yaml      # Additional provider setup
├── prompts/                     # Prompt templates
│   ├── prompt_1.txt             # Description prompt
│   └── prompt_2.txt             # Story prompt
├── tests/                       # Test cases & assertions
│   └── tests.yaml
└── results.html                 # Generated evaluation results

```

## Configuration

The `promptfooconfig.yaml` uses file references:
```yaml
prompts:
  - file://prompts/prompt_1.txt
  - file://prompts/prompt_2.txt

providers:
  - file://providers/providers.yaml
  
tests:
  - file://tests/tests.yaml
```

## Prompts

We have two simple prompts that use the `{{topic}}` variable:

1. Description Prompt (prompt_1.txt):
```
Write a short 2 sentence description about {{topic}}
```

2. Story Prompt (prompt_2.txt):
```
Write a short 2 sentence funny story about {{topic}}
```

## Setup

1. Make sure promptfoo is installed globally:
```bash
npm install -g promptfoo
```

2. Set up your API keys in environment variables or `.env` file:
```bash
export OPENAI_API_KEY=your_key_here
export ANTHROPIC_API_KEY=your_key_here
```

## Running Tests

From the week_2 directory:
```bash
promptfoo eval promptfooconfig.yaml
```

To view results:
```bash
promptfoo view
```

## Test Structure

Test files use YAML format with:
- `vars`: Define the topic variable
- `assert`: Output validations
  - `contains`: Check for specific text
  - `llm-rubric`: Use AI to grade quality

Example:
```yaml
- description: "Test description about cats"
  vars:
    topic: "cats"
  assert:
    - type: contains
      value: "cats"
    - type: llm-rubric
      value: "Check if the response is exactly 2 sentences"
```

## Best Practices

1. Keep prompts simple and focused
2. Use clear variable names
3. Include specific assertions
4. Test different topics
5. Validate style, tone, or sentence count as required

## File References

- Use `file://` prefix for referencing files in config
- Group files in logical directories (prompts/, providers/, tests/)
- Use consistent and descriptive filenames

