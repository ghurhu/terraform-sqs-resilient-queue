output "queue_url" {
  description = "Main queue URL."
  value       = aws_sqs_queue.main.url
}
output "queue_arn" {
  description = "Main queue ARN for consumer IAM policies."
  value       = aws_sqs_queue.main.arn
}
output "dead_letter_queue_url" {
  description = "DLQ URL for inspection and controlled redrive."
  value       = aws_sqs_queue.dead_letter.url
}
