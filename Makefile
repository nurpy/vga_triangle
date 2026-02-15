
compile:
	compile_vivado compile PROJECT_NAME=TRIANGLE SRC_DIR=TRIANGLE/hdl TOP_MODULE=top
simulate:
	compile_vivado simulate PROJECT_NAME=TRIANGLE SRC_DIR=TRIANGLE/hdl TOP_MODULE=tb_top


program:
	compile_vivado program PROJECT_NAME=TRIANGLE TOP_MODULE=top
