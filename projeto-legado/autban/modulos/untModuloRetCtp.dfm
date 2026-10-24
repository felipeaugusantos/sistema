object frmModuloRetCtp: TfrmModuloRetCtp
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 150
  Width = 215
  object qryRetCtp: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM RETCTP')
    Left = 48
    Top = 40
  end
  object dsRetCtp: TDataSource
    DataSet = qryRetCtp
    Left = 120
    Top = 40
  end
end
