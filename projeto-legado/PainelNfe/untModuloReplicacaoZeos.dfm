object frmModuloReplicacao: TfrmModuloReplicacao
  OldCreateOrder = False
  Height = 150
  Width = 215
  object sqlMonitor: TZSQLMonitor
    Active = True
    MaxTraceCount = 100
    OnTrace = sqlMonitorTrace
    Left = 96
    Top = 8
  end
end
