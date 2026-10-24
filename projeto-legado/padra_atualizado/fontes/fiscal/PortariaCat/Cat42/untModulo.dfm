object frmModulo: TfrmModulo
  OldCreateOrder = False
  Height = 528
  Width = 325
  object Database: TUniConnection
    ProviderName = 'MySQL'
    Port = 3306
    LoginPrompt = False
    AfterConnect = DatabaseAfterConnect
    Left = 24
    Top = 8
    EncryptedPassword = '9CFF96FF8BFF9AFF93FFCEFFCCFFCCFFCBFFC8FF'
  end
end
