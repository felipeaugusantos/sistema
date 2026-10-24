object frmModuloReplicacaoLibFuncoes: TfrmModuloReplicacaoLibFuncoes
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 150
  Width = 215
  object sqlMonitor: TUniSQLMonitor
    Options = [moDialog, moSQLMonitor, moDBMonitor]
    TraceFlags = [tfQExecute, tfError]
    OnSQL = sqlMonitorSQL
    Left = 96
    Top = 24
  end
end
