object frmModuloCadCbi: TfrmModuloCadCbi
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 151
  Width = 238
  object qryCadCbi: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM CADCBI')
    Constraints = <>
    Left = 48
    Top = 32
  end
end
