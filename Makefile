.PHONY: test

test_all:
	robot test_ssh.robot
	robot test_web.robot
	robot test_sql.robot

test_web:
	robot test_web.robot

test_ssh:
	robot test_ssh.robot

test_sql:
    robot test_sql.robot