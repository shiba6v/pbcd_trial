set -u
COMPARE_FILE=$1
BASE_BRANCH=$2

# pip install git+https://github.com/googleapis/proto-breaking-change-detector.git

TMP_FILE=$(uuidgen)
git show ${BASE_BRANCH}:${COMPARE_FILE} > tmp/${TMP_FILE}.proto

PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION=python proto-breaking-change-detector \
--original_api_definition_dirs  \
--update_api_definition_dirs ${COMPARE_FILE} \
--human_readable_message

rm tmp/${TMP_FILE}.proto