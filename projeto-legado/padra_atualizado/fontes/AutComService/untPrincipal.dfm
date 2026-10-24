object frmAutcomSvc: TfrmAutcomSvc
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize, biMaximize, biHelp]
  Caption = '..:: Monitor de Tarefas do Autcom ::..'
  ClientHeight = 633
  ClientWidth = 1071
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 660
    Top = 65
    Width = 5
    Height = 549
    Align = alRight
    ExplicitLeft = 458
    ExplicitHeight = 271
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 614
    Width = 1071
    Height = 19
    Panels = <
      item
        Text = 'Desconectado'
        Width = 180
      end
      item
        Text = 'Status: Aguardando'
        Width = 250
      end
      item
        Width = 180
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1071
    Height = 65
    Align = alTop
    TabOrder = 1
    object lblNumReg1: TLabel
      Left = 259
      Top = 36
      Width = 51
      Height = 13
      Caption = 'Mostrar as'
    end
    object lblNumReg2: TLabel
      Left = 367
      Top = 36
      Width = 122
      Height = 13
      Caption = #250'ltimas tarefas realizadas'
    end
    object btmExecTarefas: TBitBtnLocked
      Left = 73
      Top = 1
      Width = 80
      Height = 63
      Align = alLeft
      Caption = 'Executar tarefas agora'
      TabOrder = 0
      WordWrap = True
      OnClick = btmExecTarefasClick
    end
    object btnMinimiza: TBitBtnLocked
      Left = 1
      Top = 1
      Width = 72
      Height = 63
      Align = alLeft
      Caption = '&Minimizar'
      TabOrder = 1
      OnClick = btnMinimizaClick
    end
    object spNumReg: TSpinEdit
      Left = 313
      Top = 33
      Width = 50
      Height = 22
      MaxValue = 100
      MinValue = 1
      TabOrder = 2
      Value = 50
      OnChange = spNumRegChange
    end
    object btnUpdate: TBitBtnLocked
      Left = 153
      Top = 1
      Width = 80
      Height = 63
      Align = alLeft
      Caption = 'Atualizar Tarefas executadas'
      TabOrder = 3
      WordWrap = True
      OnClick = btnUpdateClick
    end
    object chkOcultarTarefasRealizadas: TCheckBox
      Left = 259
      Top = 10
      Width = 257
      Height = 17
      Caption = 'Ocultar tarefas realizadas'
      TabOrder = 4
      OnClick = chkOcultarTarefasRealizadasClick
    end
  end
  object cxgUltimosProcessos: TcxGridCitel
    Left = 0
    Top = 65
    Width = 660
    Height = 549
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgUltimosProcessosTableView1: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsUltimos
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = True
      Destaque = True
      CorZebra = clGradientActiveCaption
      object cxgUltimosProcessosTableView1Column1: TcxGridDBColumn
        Caption = 'Parametro'
        DataBinding.FieldName = 'SVC_COMAND'
        Width = 154
      end
      object cxgUltimosProcessosTableView1Column2: TcxGridDBColumn
        Caption = 'Data/Hora Inclus'#227'o'
        DataBinding.FieldName = 'SVC_DTTINC'
        Width = 120
      end
      object cxgUltimosProcessosTableView1Column3: TcxGridDBColumn
        Caption = 'Data/Hora Execu'#231#227'o'
        DataBinding.FieldName = 'SVC_DTTEXC'
        Width = 120
      end
      object cxgUltimosProcessosTableView1Column4: TcxGridDBColumn
        Caption = 'Data/Hora Termino Exec.'
        DataBinding.FieldName = 'SVC_DTTFIN'
        Width = 136
      end
    end
    object cxgUltimosProcessosLevel1: TcxGridLevel
      GridView = cxgUltimosProcessosTableView1
    end
  end
  object dbeLogCmd: TDBMemoFocus
    Left = 665
    Top = 65
    Width = 406
    Height = 549
    Align = alRight
    DataField = 'SVC_LOGCMD'
    DataSource = dtsUltimos
    TabOrder = 3
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    StringQuebra = '<<csq>>'
  end
  object TrayIcon1: TTrayIcon
    BalloonFlags = bfInfo
    Icon.Data = {
      0000010001001010000001002000680400001600000028000000100000002000
      0000010020000000000000040000130B0000130B00000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0001010112606060B66060
      60B601010111000000090000002B000000520000428E231F6A7706050006FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009A9A99D9E4E4E4FFDEDE
      DEFF464646D0000000750000009400025BE3241EBBFF8275FFFF292F6B66FFFF
      FF00FFFFFF000000000F545454AD191919611C1C1C6ED1D1D0F8C0BFBEFF9A9A
      99FF7A7A7AF8090909A9050865E92D29C8FF7968F1FF2226C6FF2A62D643FFFF
      FF00FFFFFF00777776C5FFFFFFFFEDEDECFEE6E6E5FECACAC9FFA4A4A2FFA4A4
      A2FFD7D7D5FF5A5B90FF2C28C7FF8575F4FF201EBDFF1D4EC27AFFFFFF00FFFF
      FF00FFFFFF00848484E7F8F8F6FFE9E9E8FFD3D3D2FFC8C7C7FFC9C8C6FFC9C8
      C7FF9B9BB1FF2720BEFF7D6CF1FF1E1CBBFF425AA0F4FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0053535395F6F5F4FFE6E5E4FFBFBEBDFFEBEBEAFFD4D3D2FF9292
      BFFF2B25BBFF6F5FF5FF2E34C8FF92A1CFFF4949498DFFFFFF00FFFFFF000000
      000F606060B5ABAAAAE7E4E3E2FFD1D0CFFFF0F0EFFFAEAEAEFF6E6DAAF6362C
      C8FF7B6FF5FF4956D1FFB1B8C9FFE0DFDDFFA2A2A0E4606060B50000000F3535
      356DE4E4E3FFD8D6D5FFD2D1D0FFC5C4C3FFEDECEBFF8D8D8DBA514E8A5C9D95
      F5FF4553E1FFC9D0DEFFB6B5B4FFD6D5D3FFE2E1E0FFE0E0DFFF313131664241
      4176ECEBE8FFDAD9D7FFD4D3D1FFC6C5C4FFDEDCDCFF504F4D9FFFFFFFFF8699
      D0484E618BB5DDDCDBFFC8C6C5FFE2E2E1FFE1E1DFFFEEEDECFF3E3D3D6F6868
      684A919191EBDADAD9FCDEDDDCFFCBCACAFFBDBCBDFFFFFFFFFF494846671515
      155CB9B9B8EBEEEEECFFCCCBCBFFE7E6E5FFDCDCDBFC939393EB3A3A3A43FFFF
      FF00FFFFFF00929291CEE1E0DEFFB5B3B4FFFFFFFFFFDCDBDAFFD4D3D3FDE4E3
      E2FDF6F6F5FFC0C0BFFFEAE9E8FFF3F3F2FF8F8F8EC9FFFFFF00FFFFFF00FFFF
      FF00FFFFFF004C4C4C91B7B6B5FFFFFFFFFFDDDCDBFFCCCBCBFFC4C3C2FFCFCF
      CEFFDEDEDDFFF0F0EFFFF0F0EFFFF6F6F5FF47474787FFFFFF00FFFFFF00FFFF
      FF00121212028D8D8DEDE8E8E9FFD1D0D0FFEEEEEDFFEBEBEAFFE3E2E1FFE8E8
      E7FFEAEAE9FFF3F3F2FFF5F5F4FFFAF9F8FFA9A9A9DFFFFFFF00FFFFFF00FFFF
      FF00FFFFFF00B5B5B59D9D9D9BFEA0A09FE7ABAAAAF3E8E7E6FFE7E6E5FFEDED
      ECFFFBFBFAFFB1B1B1F2A4A4A3E7BEBEBEFE98989768FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF009C9C9C146A6A6A0E767676AAEFEEEDFFF4F4
      F3FF7B7B7BA47272720B8E8E8E17FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF005353534A9F9F9FF0A0A0
      A0EF34343443FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FC00
      0000FC000000C0000000C0010000C0030000C003000000000000000000000000
      000000000000C0030000C003000080030000C0030000F00F0000FC3F0000}
    Visible = True
    OnDblClick = TrayIcon1DblClick
    Left = 672
    Top = 64
  end
  object tmrInicia: TTimer
    Enabled = False
    OnTimer = tmrIniciaTimer
    Left = 640
    Top = 128
  end
  object Database: TUniConnection
    ProviderName = 'MySQL'
    Port = 3306
    Username = 'root'
    LoginPrompt = False
    AfterConnect = DatabaseAfterConnect
    AfterDisconnect = DatabaseAfterDisconnect
    Left = 696
    Top = 132
    EncryptedPassword = '9CFF96FF8BFF9AFF93FFCEFFCCFFCCFFCBFFC8FF'
  end
  object qryUltimos: TUniQuery
    Connection = Database
    Left = 248
    Top = 176
  end
  object dtsUltimos: TDataSource
    DataSet = qryUltimos
    Left = 304
    Top = 176
  end
  object qryProcessar: TUniQuery
    SQLInsert.Strings = (
      'INSERT INTO AUTSVC'
      '  (SVC_COMAND, SVC_DTTINC, SVC_DTTEXC, SVC_DTTFIN, SVC_LOGCMD)'
      'VALUES'
      
        '  (:SVC_COMAND, :SVC_DTTINC, :SVC_DTTEXC, :SVC_DTTFIN, :SVC_LOGC' +
        'MD)')
    SQLDelete.Strings = (
      'DELETE FROM AUTSVC'
      'WHERE'
      '  SVC_COMAND = :Old_SVC_COMAND AND SVC_DTTINC = :Old_SVC_DTTINC')
    SQLUpdate.Strings = (
      'UPDATE AUTSVC'
      'SET'
      
        '  SVC_COMAND = :SVC_COMAND, SVC_DTTINC = :SVC_DTTINC, SVC_DTTEXC' +
        ' = :SVC_DTTEXC, SVC_DTTFIN = :SVC_DTTFIN, SVC_LOGCMD = :SVC_LOGC' +
        'MD'
      'WHERE'
      '  SVC_COMAND = :Old_SVC_COMAND AND SVC_DTTINC = :Old_SVC_DTTINC')
    SQLLock.Strings = (
      'SELECT * FROM AUTSVC'
      'WHERE'
      '  SVC_COMAND = :Old_SVC_COMAND AND SVC_DTTINC = :Old_SVC_DTTINC'
      'FOR UPDATE')
    SQLRefresh.Strings = (
      
        'SELECT SVC_COMAND, SVC_DTTINC, SVC_DTTEXC, SVC_DTTFIN, SVC_LOGCM' +
        'D FROM AUTSVC'
      'WHERE'
      '  SVC_COMAND = :SVC_COMAND AND SVC_DTTINC = :SVC_DTTINC')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM AUTSVC')
    Connection = Database
    SQL.Strings = (
      'SELECT * '
      'FROM AUTSVC '
      'WHERE SVC_DTTEXC IS NULL'
      '  AND SVC_DTTINC <= NOW()'
      'ORDER BY SVC_DTTINC')
    Left = 152
    Top = 304
  end
  object dspProcessar: TUniDataSetProvider
    DataSet = qryProcessar
    Options = []
    Left = 256
    Top = 304
  end
  object cdsProcessar: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspProcessar'
    Left = 368
    Top = 304
    object cdsProcessarSVC_COMAND: TStringField
      FieldName = 'SVC_COMAND'
      Required = True
      Size = 40
    end
    object cdsProcessarSVC_DTTINC: TDateTimeField
      FieldName = 'SVC_DTTINC'
      Required = True
    end
    object cdsProcessarSVC_DTTEXC: TDateTimeField
      FieldName = 'SVC_DTTEXC'
    end
    object cdsProcessarSVC_DTTFIN: TDateTimeField
      FieldName = 'SVC_DTTFIN'
    end
    object cdsProcessarSVC_LOGCMD: TBlobField
      FieldName = 'SVC_LOGCMD'
    end
    object cdsProcessarSVC_COMAUX: TStringField
      FieldName = 'SVC_COMAUX'
      Size = 255
    end
  end
  object tmrTarefas: TTimer
    Enabled = False
    OnTimer = tmrTarefasTimer
    Left = 640
    Top = 288
  end
  object ApplicationEvents1: TApplicationEvents
    OnMinimize = ApplicationEvents1Minimize
    Left = 448
    Top = 200
  end
end
