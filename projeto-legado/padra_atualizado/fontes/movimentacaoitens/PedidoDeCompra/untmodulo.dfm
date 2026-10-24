object frmModulo: TfrmModulo
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 150
  Width = 215
  object Database: TUniConnection
    Left = 64
    Top = 40
    EncryptedPassword = '9CFF96FF8BFF9AFF93FFCEFFCCFFCCFFCBFFC8FF'
  end
  object MySQLUniProvider: TMySQLUniProvider
    Left = 104
    Top = 96
  end
end
