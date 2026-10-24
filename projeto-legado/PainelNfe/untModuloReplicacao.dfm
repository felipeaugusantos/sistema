object frmModuloReplicacao: TfrmModuloReplicacao
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 150
  Width = 215
  object sqlMonitor: TUniSQLMonitor
    Options = [moDialog, moSQLMonitor, moDBMonitor]
    TraceFlags = [tfQExecute, tfError]
    OnSQL = sqlMonitorSQL
    Left = 96
    Top = 8
  end
end
