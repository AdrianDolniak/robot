.PHONY: test

test_all:
	robot robot_ssh.robot
	robot robot_web.robot

test_web:
	robot robot_web.robot

test_ssh:
	robot robot_ssh.robot
