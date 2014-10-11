#!/bin/sh
SITE=test.yml
ansible-playbook -i $INVENTORY tests/$SITE --syntax-check
ansible-playbook -i $INVENTORY tests/$SITE --sudo
  # Rerun for idempotency check.
ansible-playbook -i $INVENTORY tests/$SITE --sudo \
| grep -q 'changed=0.*failed=0' \
&& (echo 'Idempotence test: pass' && exit 0) \
|| (echo 'Idempotence test: fail' && exit 1)
