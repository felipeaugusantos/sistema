object frmModulo: TfrmModulo
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 150
  Width = 215
  object Database: TUniConnection
    ProviderName = 'MySQL'
    Port = 3306
    LoginPrompt = False
    AfterConnect = DatabaseAfterConnect
    Left = 24
    Top = 8
    EncryptedPassword = '9CFF96FF8BFF9AFF93FFCEFFCCFFCCFFCBFFC8FF'
  end
  object sqlMonitor: TUniSQLMonitor
    Options = [moDialog, moSQLMonitor, moDBMonitor]
    TraceFlags = [tfQExecute, tfError]
    Left = 96
    Top = 8
  end
end
