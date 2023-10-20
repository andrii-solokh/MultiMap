public class MultiMap implements IMultiMap {
    Map<String, List<SObject>> mappedRecords;
    List<String> fieldPaths;

    Map<Id, SObject> mappedById;

    public MultiMap(List<SObject> records) {
        this(records, new List<String>{ 'Id' });
    }

    public MultiMap(List<SObjectField> fields) {
        this(new List<SObject>(), fields);
    }

    public MultiMap(List<String> fieldPaths) {
        this(new List<SObject>(), fieldPaths);
    }

    public MultiMap(List<SObject> records, List<SObjectField> fields) {
        this(records, getFieldNames(fields));
    }

    public MultiMap(List<SObject> records, List<String> fieldPaths) {
        this.mappedRecords = new Map<String, List<SObject>>();
        this.fieldPaths = fieldPaths;
        this.mappedById = new Map<Id, SObject>();
        put(records);
    }


    public List<SObject> getAll(List<Object> values) {
        return getAll(key(values));
    }

    public List<SObject> getAll(SObject record) {
        return getAll(key(record));
    }

    public List<SObject> getAll() {
        List<SObject> result = new List<SObject>();
        for (String key : keySet()) {
            result.addAll(getAll(key));
        }
        return result;
    }

    public List<SObject> getAll(String key) {
        List<SObject> result = mappedRecords.get(key);
        if (result == null || key == null) {
            result = new List<SObject>();
        }
        return result;
    }

    public SObject getFirst(List<Object> values) {
        return getFirstSafe(getAll(values));
    }

    public SObject getFirst(String key) {
        return getFirstSafe(getAll(key));
    }

    public SObject getFirst(SObject record) {
        return getFirstSafe(getAll(record));
    }

    public SObject getById(Id recordId) {
        return mappedById.get(recordId);
    }

    public void put(SObject record, List<Object> values) {
        String key = key(values);
        if (key == null) {
            return;
        }

        if (!mappedRecords.containsKey(key)) {
            mappedRecords.put(key, new List<SObject>());
        }
        mappedRecords.get(key).add(record);
    }

    public void put(SObject record) {
        String key = key(record);
        if (key == null) {
            return;
        }

        if (!mappedRecords.containsKey(key)) {
            mappedRecords.put(key, new List<SObject>());
        }
        mappedRecords.get(key).add(record);
        mappedById.put(record.Id, record);
    }

    public void put(List<SObject> records) {
        for (SObject record : records) {
            put(record);
        }
    }

    public Set<String> keySet() {
        return mappedRecords.keySet();
    }

    public String key(SObject record) {
        List<Object> keyValues = new List<Object>();
        for (String fieldPath : fieldPaths) {
            Object value = extractValue(record, fieldPath);
            if (value == null) {
                System.debug('MultiMap| Key value is null for field path: ' + fieldPath);
                return null;
            }
            keyValues.add(value);
        }

        return key(keyValues);
    }

    public String key(List<Object> values) {
        if (values == null) {
            System.debug('MultiMap| values list is null');
            return null;
        }
        return String.join(values, '|');
    }

    private Object extractValue(SObject record, String path) {
        List<String> keys = path.split('\\.');
        Integer i = 0;
        SObject value = record;
        for (String key : keys) {
            if (i == keys.size() - 1) {
                return value?.get(key);
            } else {
                value = value?.getSObject(key);
                i += 1;
            }
        }
        return null;
    }

    private SObject getFirstSafe(List<SObject> records) {
        if (records.isEmpty()) {
            return null;
        }
        return records.get(0);
    }

    private static List<String> getFieldNames(List<SObjectField> fields) {
        List<String> fieldNames = new List<String>();

        for (SObjectField field : fields) {
            fieldNames.add(String.valueOf(field));
        }
        return fieldNames;
    }
}
