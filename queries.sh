# Object construction
jq '.[].commit.author | {fullName: .name}' commits.json
# Shorthand object construction
jq '.[].commit.author | {name, email}' commits.json
# Mixed object construction
jq '.[].commit.author | {name, email, author: true}' commits.json
# Key expresions
jq '.[].commit.author | {(.name): .email}' commits.json
# Recursive descent, search for name key and filter out non-null values
jq '.. | .name? | values' commits.json
# Length (works with strings, arrays, objects, and null)
jq '[.[].commit.author] | length' commits.json
# keys and first
jq 'first(.[].commit.author | keys)' commits.json
# Recursive
jq 'recurse(.children[]) | .name' filesystem.json
# String interpolation
jq '.[].commit.author | "Author: \(.name)"' commits.json
# Alternative operator
jq '.[] | .score // 0' scores.json
# has
jq '.[] | select(has("score")) | .name' scores.json
# if-then-else
jq '.[] | .score // 0 | if . == 0 then 50 else . end' scores.json
# path, type
jq 'path(.. | select(type=="number"))' scores.json
# built-in select fns: arrays, objects, strings, numbers, values, scalars
jq 'path(.. | numbers)' scores.json
# path to a particular value
jq 'path(.. | select(. == "riley.avron@gmail.com"))' commits.json
# Spread multiple values into array
jq '[.[].commit.author.name]' commits.json
# map
jq 'map(.commit.author.name)' commits.json
# add
jq 'map(.score) | add' scores.json
# any
jq 'any(.score > 95)' scores.json
# all
jq 'all(.score > 95)' scores.json
# sort
jq 'map(.score) | sort' scores.json
# sorty_by
jq 'sort_by(.score)' scores.json
# slice (first two elements)
jq '.[:2]' scores.json
# slice (skip first element)
jq '.[1:]' scores.json
# slice (last two elements)
jq '.[-2:]' scores.json
# slice (middle element)
jq '(length / 2 | floor) as $middle | .[$middle:($middle + 1)]' scores.json
# + (add numbers)
jq '10 + .[1].score' scores.json
# + (concatenate strings)
jq '"foo" + "bar"' scores.json
# + (concatenate arrays)
jq '[1,2,3] + [4,5,6]' scores.json
# + (merge objects non-recursively)
jq '.[] | .commit.author + .author' commits.json
# - (subtract arrays)
jq '([.. | .email? | values] | unique) - ["nico@cryptonector.com"]' commits.json
# / (split strings)
jq '.[].commit.author.date / "T"' commits.json
# Filter by equality
jq '.[].commit.author | select(.email == "riley.avron@gmail.com") | .name' commits.json
# Filter by inequality
jq '.[].commit | select(.comment_count > 0) | {message, comment_count}' commits.json
# Boolean operators
jq '.[].commit | select(.comment_count > 0 and .verification.verified)' commits.json
# Drill into arrays
jq '.[].parents[].sha' commits.json
# Filter by regex
jq '.[].commit.author | select(.email | test("gmail.com$"))' commits.json
# endswith
jq '.[].commit.author | select(.email | endswith("gmail.com"))' commits.json
# variables/destructuring
jq '.[] | (.commit.author | select(.email | endswith("gmail.com"))) as {$name, $email} | {sha, $name, $email}' commits.json
