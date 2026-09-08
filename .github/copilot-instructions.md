# Cookbook instructions

Read [AGENTS.md](../AGENTS.md) for migration decisions and platform constraints. Use `chef install Policyfile.rb`, `cookstyle`, `chef exec rspec --format documentation`, then the Kitchen commands in [TESTING.md](../TESTING.md). Custom resources live in `resources/`; shared properties are in `resources/_partial/`; examples are in `test/cookbooks/test/recipes/`.
