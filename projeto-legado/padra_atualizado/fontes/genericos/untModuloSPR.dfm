object frmModuloSPR: TfrmModuloSPR
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 157
  Width = 179
  object qryRelatorio: TUniQuery
    Connection = frmModulo.Database
    ReadOnly = True
    Options.SetFieldsReadOnly = False
    Left = 32
    Top = 32
  end
  object dtsRelatorio: TDataSource
    DataSet = qryRelatorio
    Left = 96
    Top = 32
  end
end
