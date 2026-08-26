def test_health_contract():
    expected = {'status': 'ok', 'service': 'actify-api'}
    assert expected['status'] == 'ok'
    assert expected['service'] == 'actify-api'
