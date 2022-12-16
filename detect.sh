set -u
ORIGINAL_BRANCH=$1
UPDATE_FILE=$2

# pip install git+https://github.com/googleapis/proto-breaking-change-detector.git

# 適当なディレクトリにcloneする
TMP_DIR=/tmp/$(uuidgen)
mkdir -p ${TMP_DIR}
git clone --depth=1 -b ${ORIGINAL_BRANCH} $(git remote get-url $(git remote)) ${TMP_DIR}
ORIGINAL_FILE=${TMP_DIR}/${UPDATE_FILE}

# --original_api_definition_dirs: 比較元の--proto-pathに指定するディレクトリをカンマ区切りで
# --original_proto_files: 比較元のbeaking changeを検出したいファイルをカンマ区切りで
# --update_api_definition_dirs: 比較先
# --update_proto_files: 比較先

PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION=python proto-breaking-change-detector \
    --original_api_definition_dirs=$(dirname ${ORIGINAL_FILE}) \
    --update_api_definition_dirs=$(dirname ${UPDATE_FILE}) \
    --original_proto_files=${ORIGINAL_FILE} \
    --update_proto_files=${UPDATE_FILE} \
    --human_readable_message

rm -rf ${TMP_DIR}
