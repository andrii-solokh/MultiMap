public interface IMultiMap {
    List<SObject> getAll();
    List<SObject> getAll(List<Object> values);
    List<SObject> getAll(SObject record);
    List<SObject> getAll(String key);
    SObject getFirst(List<Object> values);
    SObject getFirst(SObject record);
    SObject getFirst(String key);
    SObject getById(Id recordId);
    void put(SObject record, List<Object> values);
    void put(SObject record);
    void put(List<SObject> records);
    String key(SObject record);
    String key(List<Object> values);
    Set<String> keySet();
}
