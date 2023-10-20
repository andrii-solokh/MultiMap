@IsTest
class MultiMapTest {
    @IsTest
    static void fieldsInit_noRecords_noExceptions() {
        MultiMap multiMap = new MultiMap(new List<SObjectField> {Account.Name, Account.BillingCity});
    }

    @IsTest
    static void fieldPaths_NoRecords_noExceptions() {
        MultiMap multiMap = new MultiMap(new List<String> {'Name', 'BillingCity'});
    }

    @IsTest
    static void idsInit_noExceptions() {
        List<Account> accounts = getAccounts(100);
        MultiMap multiMap = new MultiMap(accounts);
    }
    @IsTest
    static void fieldsInit_noExceptions() {
        List<Account> accounts = getAccounts(100);
        MultiMap multiMap = new MultiMap(
            accounts,
            new List<SObjectField>{ Account.Name, Account.BillingCity }
        );
    }

    @IsTest
    static void fieldPathInit_noExceptions() {
        List<Account> accounts = getAccounts(100);
        MultiMap multiMap = new MultiMap(
            accounts,
            new List<String>{ 'Name', 'BillingCity' }
        );
    }

    @IsTest
    static void getAllByRecord_notEmpty_gotAll() {
        List<Account> accounts = getAccounts(100);
        MultiMap multiMap = new MultiMap(
            accounts,
            new List<String>{ 'Name', 'BillingCity' }
        );
        List<Account> gotAccounts = (List<Account>) multiMap.getAll(
            accounts[0]
        );
        System.assertEquals(1, gotAccounts.size());

        // duplicate records
        accounts.addAll(getAccounts(100));
        multiMap = new MultiMap(
            accounts,
            new List<String>{ 'Name', 'BillingCity' }
        );
        gotAccounts = (List<Account>) multiMap.getAll(accounts[0]);

        System.assertEquals(2, gotAccounts.size());
    }

    @IsTest
    static void getAllByRecord_empty_gotEmptyList() {
        List<Account> accounts = new List<Account>();
        MultiMap multiMap = new MultiMap(
            accounts,
            new List<String>{ 'Name', 'BillingCity' }
        );
        List<Account> gotAccounts = (List<Account>) multiMap.getAll(
            getAccounts(1)[0]
        );
        System.assertEquals(0, gotAccounts.size());
    }

    @IsTest
    static void getAll_empty_gotEmptyList() {
        List<Account> accounts = new List<Account>();
        MultiMap multiMap = new MultiMap(
            accounts,
            new List<String>{ 'Name', 'BillingCity' }
        );
        List<Account> gotAccounts = (List<Account>) multiMap.getAll();
        System.assertEquals(0, gotAccounts.size());
    }

    @IsTest
    static void getFirst_NullKey_gotNull() {
        List<Account> accounts = getAccounts(100);
        MultiMap multiMap = new MultiMap(
            accounts,
            new List<String>{ 'Name', 'BillingCity' }
        );
        String key = null;
        Account gotAccount = (Account) multiMap.getFirst(key);
        System.assertEquals(null, gotAccount);
    }

    @IsTest
    static void getAll_NullKey_gotEmptyList() {
        List<Account> accounts = getAccounts(100);
        MultiMap multiMap = new MultiMap(
            accounts,
            new List<String>{ 'Name', 'BillingCity' }
        );
        Account newAccount = new Account();
        List<Account> gotAccounts = (List<Account>) multiMap.getAll(newAccount);
        System.assertEquals(0, gotAccounts.size());
    }

    @IsTest
    static void getAll_notEmpty_gotAll() {
        List<Account> accounts = getAccounts(100);
        MultiMap multiMap = new MultiMap(
            accounts,
            new List<String>{ 'Name', 'BillingCity' }
        );
        List<Account> gotAccounts = (List<Account>) multiMap.getAll();
        System.assertEquals(100, gotAccounts.size());
    }

    @IsTest
    static void getAllByValues_notEmpty_gotAll() {
        List<Account> accounts = getAccounts(100);
        MultiMap multiMap = new MultiMap(
            accounts,
            new List<String>{ 'Name', 'BillingCity' }
        );
        List<Account> gotAccounts = (List<Account>) multiMap.getAll(
            new List<Object>{ 'Test Account 0', 'Test City 0' }
        );
        System.assertEquals(1, gotAccounts.size());

        // duplicate records
        accounts.addAll(getAccounts(100));
        multiMap = new MultiMap(
            accounts,
            new List<String>{ 'Name', 'BillingCity' }
        );
        gotAccounts = (List<Account>) multiMap.getAll(
            new List<Object>{ 'Test Account 0', 'Test City 0' }
        );

        System.assertEquals(2, gotAccounts.size());
    }

    @IsTest
    static void getAllByValues_empty_gotEmptyList() {
        List<Account> accounts = new List<Account>();
        MultiMap multiMap = new MultiMap(
            accounts,
            new List<String>{ 'Name', 'BillingCity' }
        );
        List<Account> gotAccounts = (List<Account>) multiMap.getAll(
            new List<Object>{ 'Test Account 0', 'Test City 0' }
        );
        System.assertEquals(0, gotAccounts.size());
    }

    @IsTest
    static void getFirstByRecord_notEmpty_gotFirst() {
        List<Account> accounts = getAccounts(100);
        accounts.addAll(getAccounts(100));

        MultiMap multiMap = new MultiMap(
            accounts,
            new List<String>{ 'Name', 'BillingCity' }
        );
        Account gotAccount = (Account) multiMap.getFirst(accounts[0]);
        System.assertNotEquals(null, gotAccount);
    }

    @IsTest
    static void getFirstByRecord_empty_gotEmptyList() {
        List<Account> accounts = new List<Account>();
        MultiMap multiMap = new MultiMap(
            accounts,
            new List<String>{ 'Name', 'BillingCity' }
        );
        Account gotAccount = (Account) multiMap.getFirst(getAccounts(1)[0]);
        System.assertEquals(null, gotAccount);
    }

    @IsTest
    static void getFirstByValues_notEmpty_gotFirst() {
        List<Account> accounts = getAccounts(100);
        accounts.addAll(getAccounts(100));

        MultiMap multiMap = new MultiMap(
            accounts,
            new List<String>{ 'Name', 'BillingCity' }
        );
        Account gotAccount = (Account) multiMap.getFirst(
            new List<Object>{ 'Test Account 0', 'Test City 0' }
        );
        System.assertNotEquals(null, gotAccount);
    }

    @IsTest
    static void getFirstByValues_empty_gotEmptyList() {
        List<Account> accounts = new List<Account>();
        MultiMap multiMap = new MultiMap(
            accounts,
            new List<String>{ 'Name', 'BillingCity' }
        );
        Account gotAccount = (Account) multiMap.getFirst(
            new List<Object>{ 'Test Account 0', 'Test City 0' }
        );
        System.assertEquals(null, gotAccount);
    }

    @IsTest
    static void getKetSet_notEmpty_gotAll() {
        List<Account> accounts = getAccounts(100);
        MultiMap multiMap = new MultiMap(
            accounts,
            new List<String>{ 'Name', 'BillingCity' }
        );
        System.assertEquals(100, multiMap.keySet().size());
    }

    @IsTest
    static void getKetSet_empty_gotEmptySet() {
        List<Account> accounts = new List<Account>();
        MultiMap multiMap = new MultiMap(
            accounts,
            new List<String>{ 'Name', 'BillingCity' }
        );
        System.assertEquals(0, multiMap.keySet().size());
    }

    @IsTest
    static void putRecord_newKey_noExceptions() {
        List<Account> accounts = new List<Account>();
        MultiMap multiMap = new MultiMap(
            accounts,
            new List<String>{ 'Name', 'BillingCity' }
        );
        Account gotAccount = (Account) multiMap.getFirst(
            new List<Object>{ 'Test Account 0', 'Test City 0' }
        );
        System.assertEquals(null, gotAccount);

        Account account = getAccounts(1)[0];
        multiMap.put(account);

        gotAccount = (Account) multiMap.getFirst(
            new List<Object>{ 'Test Account 0', 'Test City 0' }
        );

        System.assertNotEquals(null, gotAccount);
    }

    @IsTest
    static void putRecord_oldKey_noExceptions() {
        List<Account> accounts = getAccounts(100);
        MultiMap multiMap = new MultiMap(
            accounts,
            new List<String>{ 'Name', 'BillingCity' }
        );
        List<Account> gotAccounts = (List<Account>) multiMap.getAll(
            new List<Object>{ 'Test Account 0', 'Test City 0' }
        );

        System.assertEquals(1, gotAccounts.size());

        Account account = getAccounts(1)[0];
        multiMap.put(account);

        gotAccounts = (List<Account>) multiMap.getAll(
            new List<Object>{ 'Test Account 0', 'Test City 0' }
        );

        System.assertEquals(2, gotAccounts.size());
    }

    @IsTest
    static void putRecords_newKeys_noExceptions() {
        List<Account> accounts = new List<Account>();

        MultiMap multiMap = new MultiMap(
            accounts,
            new List<String>{ 'Name', 'BillingCity' }
        );

        List<Account> gotAccounts = (List<Account>) multiMap.getAll(
            new List<Object>{ 'Test Account 0', 'Test City 0' }
        );

        System.assertEquals(0, gotAccounts.size());

        multiMap.put(getAccounts(100));

        gotAccounts = (List<Account>) multiMap.getAll(
            new List<Object>{ 'Test Account 0', 'Test City 0' }
        );

        System.assertEquals(1, gotAccounts.size());
    }

    @IsTest
    static void putRecords_oldKeys_noExceptions() {
        List<Account> accounts = getAccounts(100);

        MultiMap multiMap = new MultiMap(
            accounts,
            new List<String>{ 'Name', 'BillingCity' }
        );

        List<Account> gotAccounts = (List<Account>) multiMap.getAll(
            new List<Object>{ 'Test Account 0', 'Test City 0' }
        );

        System.assertEquals(1, gotAccounts.size());

        multiMap.put(getAccounts(100));

        gotAccounts = (List<Account>) multiMap.getAll(
            new List<Object>{ 'Test Account 0', 'Test City 0' }
        );

        System.assertEquals(2, gotAccounts.size());
    }

    @IsTest
    static void getAllByKey_notEmpty_gotAll() {
        List<Account> accounts = getAccounts(100);

        MultiMap multiMap = new MultiMap(
            accounts,
            new List<String>{ 'Name', 'BillingCity' }
        );

        List<Account> gotAccounts = (List<Account>) multiMap.getAll(
            'Test Account 0|Test City 0'
        );

        System.assertEquals(1, gotAccounts.size());

        multiMap.put(getAccounts(100));

        gotAccounts = (List<Account>) multiMap.getAll(
            'Test Account 0|Test City 0'
        );

        System.assertEquals(2, gotAccounts.size());
    }

    @IsTest
    static void getAllByKey_empty_gotEmptyList() {
        List<Account> accounts = new List<Account>();

        MultiMap multiMap = new MultiMap(
            accounts,
            new List<String>{ 'Name', 'BillingCity' }
        );

        List<Account> gotAccounts = (List<Account>) multiMap.getAll(
            'Test Account 0|Test City 0'
        );

        System.assertEquals(0, gotAccounts.size());
    }

    @IsTest
    static void getFirstByKey_notEmpty_gotRecord() {
        List<Account> accounts = getAccounts(100);

        MultiMap multiMap = new MultiMap(
            accounts,
            new List<String>{ 'Name', 'BillingCity' }
        );

        Account gotAccount = (Account) multiMap.getFirst(
            'Test Account 0|Test City 0'
        );

        System.assertNotEquals(null, gotAccount);
    }

    @IsTest
    static void getFirstByKey_empty_gotNull() {
        List<Account> accounts = new List<Account>();

        MultiMap multiMap = new MultiMap(
            accounts,
            new List<String>{ 'Name', 'BillingCity' }
        );

        Account gotAccount = (Account) multiMap.getFirst(
            'Test Account 0|Test City 0'
        );

        System.assertEquals(null, gotAccount);
    }

    @IsTest
    static void getKey_valuesNull_noException() {
        List<Account> accounts = new List<Account>();

        MultiMap multiMap = new MultiMap(
            accounts,
            new List<String>{ 'Name', 'BillingCity' }
        );

        List<Object> values = null;
        String key = multiMap.key(values);
        System.assertEquals(null, key);
    }

    @IsTest
    static void putRecord_keyNull_noException() {
        List<Account> accounts = new List<Account>();

        MultiMap multiMap = new MultiMap(
            accounts,
            new List<String>{ 'Name', 'BillingCity' }
        );

        multiMap.put(new Account());

        System.assertEquals(0, multiMap.getAll().size());
    }

    @IsTest
    static void putRecord_valuesNull_noException() {
        List<Account> accounts = new List<Account>();

        MultiMap multiMap = new MultiMap(
            accounts,
            new List<String>{ 'Name', 'BillingCity' }
        );

        multiMap.put(getAccounts(1)[0], null);

        System.assertEquals(0, multiMap.getAll().size());
    }

    @IsTest
    static void putRecordWithValues_newKey() {
        List<Account> accounts = new List<Account>();

        MultiMap multiMap = new MultiMap(
            accounts,
            new List<String>{ 'Name', 'BillingCity' }
        );

        Account gotAccount = (Account) multiMap.getFirst(
            'Test Account 0|Test City 0'
        );

        System.assertEquals(null, gotAccount);

        multiMap.put(
            getAccounts(1)[0],
            new List<Object>{ 'Test Account 0', 'Test City 0' }
        );

        gotAccount = (Account) multiMap.getFirst('Test Account 0|Test City 0');

        System.assertNotEquals(null, gotAccount);
    }

    private static List<Account> getAccounts(Integer count) {
        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < count; i++) {
            accounts.add(
                new Account(
                    Name = 'Test Account ' + i,
                    BillingCity = 'Test City ' + i
                )
            );
        }
        return accounts;
    }
}
