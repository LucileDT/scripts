#!/usr/bin/env bash

fileTextAppendOnceTest() {
  filePath=${_TEST_RUN_DIR_SAMPLES}fileTextSample1.txt

  original=$(< ${filePath})

  # Try to append a line which exists
  wexample fileTextAppendOnce ${filePath} "[INNER LINE]"
  # No change expected
  modified=$(< ${filePath})
  differences=$(diff <(echo "${original}") <(echo "${modified}"))
  if [[ ${differences} != '' ]]; then
    wexampleTestError "Differences found tyring insert existing line"
    echo ${differences}
  fi

  # Try to append a line which looks like another on but not exactly
  wexample fileTextAppendOnce ${filePath} "\r\n[INNER LINE"
  # File should have changed
  modified=$(< ${filePath})
  differences=$(diff <(echo "${original}") <(echo "${modified}"))
  if [ ${#differences} == 0 ]; then
    wexampleTestError "File not changed when expected"
  fi

  # Try to append config line
  configValue="true; # With an unsupported comment"
  configKey="SuperConf"
  configTest="${configKey} = ${configValue}"
  wexample fileTextAppendOnce ${filePath} "${configTest}"
  inserted=$(wexample configGetValue ${filePath} "${configKey}" " = ")
  wexampleTestAssertEqual "${inserted}" "${configValue}"

  # Reset
  git checkout HEAD -- ${filePath}
}
