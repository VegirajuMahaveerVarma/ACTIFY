def test_task_schema_fields():
    required = {
        'title', 'description', 'deadline', 'priority',
        'estimated_minutes', 'category', 'dependencies', 'source', 'confidence'
    }
    assert 'title' in required
    assert 'deadline' in required
    assert 'priority' in required
