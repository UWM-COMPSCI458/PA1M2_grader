#!/bin/bash

SUBMISSION=$1

TOTAL_SCORE=0

function test_asm() {
  MAX_SCORE=$2
  SCORE=$(("$2" + 0))
  echo "## Testing $1.asm"

  echo "### Assembly code:"
  echo "\`\`\`"
  cat "$1.asm"
  echo "\`\`\`"
  echo

  cp "$1.asm" curtest.asm
  $(./$SUBMISSION curtest.asm)

  cp "$1.text" "curtest.text"
  cp "$1.data" "curtest.data"
  
  if [ ! -f "curtest.text" ]; then
    echo "> [!WARNING]"
    echo "> Your solution did not generate a .text file (or it has an incorrect location/name)."
    echo
    SCORE=0
  fi
  if [ ! -f "curtest.data" ]; then
    echo "> [!WARNING]"
    echo "> Your solution did not generate a .data file (or it has an incorrect location/name)."
    echo
    SCORE=0
  fi

  if [ "$SCORE" -eq 0 ]; then
    echo "**Score for $1: 0 / $MAX_SCORE**"
    echo "********"
    echo
    rm curtest.*
    return 0;
  fi
    

  echo "### Evaluating .text"
  echo "<table><tr><th style=\"width: 50%; vertical-align: top;\">Evaluated .text contents</th>
<th style=\"width: 50%; vertical-align: top;\">Expected .text contents</th></tr><tr><td><pre>"
  cat "curtest.text"
  echo "</pre></td><td><pre>"
  cat "$1.text"
  echo "</pre></td></tr></table>"
  
  echo
  echo "#### Resulting .text diff"
  echo "\`\`\`diff"
  diff -y "curtest.text" "$1.text"
  echo "\`\`\`"
  echo
  if [[ $(diff -q "$1.text" "curtest.text") ]]; then
    echo "> [!WARNING]"
    echo "> Your .text file does not match the solution."
    echo
    SCORE=0
  fi


  echo "### Evaluating .data"
  echo "<table><tr><th style=\"width: 50%; vertical-align: top;\">Evaluated .data contents</th>
<th style=\"width: 50%; vertical-align: top;\">Expected .data contents</th></tr><tr><td><pre>"
  cat "curtest.data"
  echo "</pre></td><td><pre>"
  cat "$1.data"
  echo "</pre></td></tr></table>"

  echo
  echo "#### Resulting .data diff"
  echo "\`\`\`diff"
  diff -y "curtest.data" "$1.data"
  echo "\`\`\`"
  echo
  if [[ $(diff -q "$1.data" "curtest.data") ]]; then
    echo "> [!WARNING]"
    echo "> Your .data file does not match the solution."
    echo
    SCORE=0
  fi

  echo
  echo "**Score for $1: $SCORE / $MAX_SCORE**"
  echo "********"
  echo

  ((TOTAL_SCORE+=SCORE))

  rm curtest.*
}


test_asm test1 5
test_asm test2 10
test_asm test3 10
test_asm test4 15
test_asm test5 25
test_asm test6 35

echo
echo "# Total score: $TOTAL_SCORE / 100"
exit $TOTAL_SCORE
