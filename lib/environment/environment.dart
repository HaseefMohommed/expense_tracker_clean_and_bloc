enum Environment {
  development(baseUrl: 'http://localhost:3000'),
  production(baseUrl: 'http://localhost:3000'),
  uat(baseUrl: 'http://localhost:3000'),
  qa(baseUrl: 'http://localhost:3000');

  final String baseUrl;
  const Environment({
    required this.baseUrl,
  });
}
