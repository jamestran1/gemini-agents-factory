param(
    [string]$Prompt
)

# Core Orchestration Logic: Determine the target agent based on the prompt.
# In a more advanced implementation, this would involve a model call to classify the request.

$lowerPrompt = $Prompt.ToLower()

if ($lowerPrompt -match "build|vision|concept|requirements") {
    return "Product Owner"
} elseif ($lowerPrompt -match "design|layout|visual|ui|ux") {
    return "Designer"
} elseif ($lowerPrompt -match "tasks|schedule|plan|manage") {
    return "Project Manager"
} elseif ($lowerPrompt -match "implement|code|python|logic|build") {
    # 'build' is ambiguous, checking implementation context first
    return "Software Engineer"
} elseif ($lowerPrompt -match "verify|test|correct|quality|qa") {
    return "QA"
}

return "General"
