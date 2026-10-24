object dmContabilidadeModuloLog: TdmContabilidadeModuloLog
  OldCreateOrder = False
  Height = 150
  Width = 215
  object sqlMonitor: TUniSQLMonitor
    Options = [moDialog, moSQLMonitor, moDBMonitor]
    TraceFlags = [tfQPrepare, tfQExecute, tfError, tfMisc, tfParams]
    OnSQL = sqlMonitorSQL
    Left = 96
    Top = 8
  end
end
