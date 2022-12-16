.PHONY: proto_detect_breaking_change
proto_detect_breaking_change:
# pip install git+https://github.com/googleapis/proto-breaking-change-detector.git

	DETECT_DIRECTORY=proto
	rm -rf tmp/proto_detect_breaking_change
	mkdir -p tmp/proto_detect_breaking_change
	ORIGINAL_BRANCH=$(shell git rev-parse --abbrev-ref HEAD)
	git checkout main
# rsyncで同期する時、ディレクトリの後に/を付けるべき。
	rsync ${DETECT_DIRECTORY}/ tmp/proto_detect_breaking_change/${DETECT_DIRECTORY}/
	git checkout ${ORIGINAL_BRANCH}
	PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION=python proto-breaking-change-detector \
	--original_api_definition_dirs tmp/proto_detect_breaking_change/${DETECT_DIRECTORY} \
	--update_api_definition_dirs ${DETECT_DIRECTORY} \
	--human_readable_message
