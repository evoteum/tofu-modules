output "table_arn" {
  value = aws_dynamodb_table.main.arn
}

output "table_name" {
  value = aws_dynamodb_table.main.name
} 