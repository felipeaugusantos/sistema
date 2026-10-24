object frmModuloCadPgi: TfrmModuloCadPgi
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 150
  Width = 215
  object qryCadPgi: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM CADPGI')
    Constraints = <>
    Left = 88
    Top = 56
  end
end
