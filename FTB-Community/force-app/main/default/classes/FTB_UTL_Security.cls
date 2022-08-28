public with sharing class FTB_UTL_Security 
{

    private final String KEY = 'ABBARCA';

    public String ftbEncryption(String stringToEncrypt)
    {
        return ftbEncryptAlgo(stringToEncrypt);
    }

    private String ftbEncryptAlgo(String stringToEncrypt)
    {
        return stringToEncrypt;
    }
}
