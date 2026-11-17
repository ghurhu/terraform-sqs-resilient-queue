mock_provider "aws" {}
run "safe_defaults" {
  command = apply
  variables {
    name = "test-queue"
  }
  assert {
    condition     = aws_sqs_queue.main.sqs_managed_sse_enabled && aws_sqs_queue.dead_letter.sqs_managed_sse_enabled
    error_message = "Both queues must use server-side encryption."
  }
  assert {
    condition     = aws_sqs_queue.dead_letter.message_retention_seconds > aws_sqs_queue.main.message_retention_seconds
    error_message = "DLQ retention must exceed source retention."
  }
  assert {
    condition     = jsondecode(aws_sqs_queue_redrive_policy.main.redrive_policy).maxReceiveCount == 5
    error_message = "Default receive threshold must be five."
  }
  assert {
    condition     = jsondecode(aws_sqs_queue_policy.tls["main"].policy).Statement[0].Effect == "Deny"
    error_message = "TLS policy must be an explicit deny."
  }
}
run "reject_invalid_name" {
  command = plan
  variables {
    name = "not a queue"
  }
  expect_failures = [var.name]
}
run "reject_fractional_retry_count" {
  command = plan
  variables {
    name              = "valid-name"
    max_receive_count = 1.5
  }
  expect_failures = [var.max_receive_count]
}
