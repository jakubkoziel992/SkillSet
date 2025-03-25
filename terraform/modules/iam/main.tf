resource "aws_iam_policy" "getsecretsvalue" {
  name   = var.policy_name
  path   = "/"
  policy = var.iam_policy

  
}


resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = var.iam_role
  policy_arn = aws_iam_policy.getsecretsvalue.arn

  depends_on = [ aws_iam_policy.getsecretsvalue ]
}


