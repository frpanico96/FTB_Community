public with sharing class FTB_UTL_Security 
{

    private final String KEY = 'BARC';

    public String ftbEncryption(String stringToEncrypt)
    {
        return ftbEncryptAlgo(stringToEncrypt);
    }

    private String ftbEncryptAlgo(String stringToEncrypt)
    {
        String[] binaryKey = createBinaryKey(KEY);
        List<List<String>> binaryInput = createBinaryInput(stringToEncrypt);
    }

    private String xorCipher(String x, String key)
    {
        String[] xArr = x.split('');
        String[] keyArr = key.split('');
        
        String result = '';
        
        for(Integer i=0; i < 8; ++i)
        {
            result += String.valueOf(Integer.valueOf(xArr[i]) ^ Integer.valueOf(keyArr[i]));
        }
        return result;
    }

    private List<List<String>> createBinaryInput(String stringToEncrypt)
    {
        List<List<String>> result = new List<List<String>>();
        for(Integer i = 0; i <= (stringToEncrypt.length()/KEY.length()); ++i)
        {
            List<String> binaryChar = new List<String>();
            if(i < (stringToEncrypt.length()/KEY.length()))
            {
                String sub = stringToEncrypt.substring(KEY.length()*i, KEY.length() * (i+1));
                binaryChar = createBinaryKey(sub);
            }
            else
            {
                String sub = stringToEncrypt.substring(KEY.length()*i, stringToEncrypt.length());
                if(sub.length() < KEY.length())
                {
                    sub += '0';
                }
                binaryChar = createBinaryKey(sub);
            }
            result.add(binaryChar);
        }
    }

    private List<String> createBinaryKey(String value)
    {
        List<String> result = new List<String>();
        for(String s : value.split(''))
        {
            String binaryNum = integerToBinary(s.getChars()[0]);
            while(binaryNum.length() < 8)
            {
                binaryNum = '0' + binaryNum;
            }
            result.add(binaryNum);
        }
        return result;
    }

    private Integer binaryToInteger(String value)
    {
        Integer result;
        if(value != null && value.containsOnly('01'))
        {
            result = 0;
            for(String s : value.split(''))
            {
                result = (result << 1) | (s == '1' ? 1 : 0);
            }
        }
        return result;
    }

    private String integerToBinary(Integer value)
    {
        String result = '';
        while(value != 0)
        {
            result = (value & 1) + result;
            n >>>= 1;
        }
        return result;
    }
}
