inherited frmCfgCamposClientesCRM: TfrmCfgCamposClientesCRM
  Width = 569
  Caption = 'Defini'#231#227'o da exibi'#231#227'o dos campos do Cadastro de Clientes'
  Position = poMainFormCenter
  ExplicitWidth = 569
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 434
    Width = 563
    Height = 26
    Enabled = True
    Visible = True
    ExplicitTop = 434
    ExplicitWidth = 563
    ExplicitHeight = 26
    DesignSize = (
      563
      26)
    inherited FlwBotoes: TFlowPanel
      Width = 482
      Height = 22
      ExplicitTop = 2
      ExplicitWidth = 482
      ExplicitHeight = 22
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 103
        Height = 22
        Caption = '&Confirma [F10]'
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333333333333333330000333333333333333333333333F33333333333
          00003333344333333333333333388F3333333333000033334224333333333333
          338338F3333333330000333422224333333333333833338F3333333300003342
          222224333333333383333338F3333333000034222A22224333333338F338F333
          8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
          33333338F83338F338F33333000033A33333A222433333338333338F338F3333
          0000333333333A222433333333333338F338F33300003333333333A222433333
          333333338F338F33000033333333333A222433333333333338F338F300003333
          33333333A222433333333333338F338F00003333333333333A22433333333333
          3338F38F000033333333333333A223333333333333338F830000333333333333
          333A333333333333333338330000333333333333333333333333333333333333
          0000}
        ModalResult = 1
        NumGlyphs = 2
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
      object btnDesmarcar: TBitBtnLocked
        Left = 103
        Top = 0
        Width = 120
        Height = 22
        Caption = '&Desmarcar Todos [F9]'
        NumGlyphs = 2
        TabOrder = 1
        OnClick = btnDesmarcarClick
      end
      object btnMarcar: TBitBtnLocked
        Left = 223
        Top = 0
        Width = 120
        Height = 22
        Caption = '&Marcar Todos [F8]'
        NumGlyphs = 2
        TabOrder = 2
        OnClick = btnMarcarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Top = -29
      TabOrder = 2
      ExplicitTop = -29
    end
    object BitBtn1: TBitBtnLocked
      Left = 484
      Top = 2
      Width = 77
      Height = 22
      Align = alRight
      Caption = '&Sair'
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        08000000000000010000120B0000120B0000000100000001000000520000006B
        0000006B0800106B0800008C080000940800007B100000731800087B180008A5
        1800089C21001094290010A529001084310010A5310018A5310010A539001884
        4200DE844200218C42002194420018AD420018B5420021B5420021944A00299C
        4A0029BD4A00DE8C52003194520018B5520031C6520031945A00299C5A0031AD
        5A00BD5A6300AD73630029AD630039D66300DEA5840042B59400FFD69C0073A5
        AD00DEBDAD006BA5B5009CBDB500B5C6B500DED6B500FFDEB500D6C6BD00FFE7
        BD00088CC600DECEC60073D6C600E7D6C600EFD6C600F7E7C600FFE7C600088C
        CE000894CE00E7D6CE00109CD600189CD600219CD600299CD60018A5D60021A5
        D60029A5D60031A5D60042ADD600F7E7D600FFE7D600FFEFD60021A5DE0031AD
        DE00E7D6DE00FFEFE700FFF7E7004ACEEF005ADEEF0052CEF7005ADEF70094E7
        F700A5E7F7006BEFF7007BEFF70084F7F7008CF7F7009CF7F700FFFFF700FF00
        FF0063DEFF006BDEFF005AEFFF0073F7FF007BF7FF0084F7FF0094F7FF009CF7
        FF00A5F7FF0073FFFF007BFFFF0084FFFF008CFFFF0094FFFF009CFFFF00A5FF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00593232595959
        5959595959595959595932514E32323232325959595959595959325266655F5F
        5E5A32320203595959593A44685D5E27141819130604085959594144575D651F
        1A1A17150E0905015959424E4465651F1E251A17170E09040059425444696327
        21242432101D0A0D325942562B44606067665D5D0F0B1154415942552A444444
        44446153081F4F5F4D594255305846312E2C445134605B605F3D4255306A4B45
        372F2D444444444444434355336A584B45372F28295C3D5959593F57356A6A58
        4B452323233E3E595959593F366A6A6A6A3B23122259595959595959356A6A6A
        6A4A231B59595959595959592626262626262359595959595959}
      TabOrder = 1
      OnClick = btnSairClick
    end
  end
  inherited pgcDados: TPageControl
    Width = 563
    Height = 434
    ExplicitWidth = 563
    ExplicitHeight = 434
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 555
      ExplicitHeight = 402
    end
  end
  object pnlGeral: TPanel [3]
    Left = 0
    Top = 0
    Width = 563
    Height = 434
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object dbgConf: TcxGrid
      Left = 1
      Top = 1
      Width = 561
      Height = 432
      Align = alClient
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      object dbgConfDBTableView1: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dtsClientes
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        NewItemRow.InfoText = 'Clique aqui para adicionar um novo registro'
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Inserting = False
        OptionsView.GroupByBox = False
        object dbgConfDBTableView1CRM_TIP_FC: TcxGridDBColumn
          DataBinding.FieldName = 'CRM_TIP_FC'
          Visible = False
        end
        object dbgConfDBTableView1CRM_NOMCAM: TcxGridDBColumn
          Caption = 'Campo Tabela'
          DataBinding.FieldName = 'CRM_NOMCAM'
          Visible = False
          Width = 90
        end
        object dbgConfDBTableView1CRM_EXIBIR: TcxGridDBColumn
          Caption = 'Exibir'
          DataBinding.FieldName = 'CRM_EXIBIR'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.Alignment = taCenter
          Properties.ValueChecked = 'S'
          Properties.ValueUnchecked = 'N'
          HeaderAlignmentHorz = taCenter
          Width = 90
        end
        object dbgConfDBTableView1CRM_DESCAM: TcxGridDBColumn
          Caption = 'Nome'
          DataBinding.FieldName = 'CRM_DESCAM'
          Options.Editing = False
          Width = 300
        end
        object dbgConfDBTableView1CRM_CODEMP: TcxGridDBColumn
          Caption = 'Empresa'
          DataBinding.FieldName = 'CRM_CODEMP'
          Options.Editing = False
          Width = 70
        end
      end
      object dbgConfLevel1: TcxGridLevel
        GridView = dbgConfDBTableView1
      end
    end
  end
  inherited pnlStatus: TPanel
    Width = 563
    ExplicitWidth = 563
    inherited pnlNomeForm: TPanel
      Left = 392
      ExplicitLeft = 392
    end
    inherited pnlInfo: TPanel
      Width = 392
      ExplicitWidth = 392
    end
  end
  object dtsClientes: TDataSource
    DataSet = cdsClientes
    Left = 135
    Top = 128
  end
  object cdsClientes: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspClientes'
    Left = 168
    Top = 128
    object cdsClientesCRM_TIP_FC: TStringField
      FieldName = 'CRM_TIP_FC'
      Size = 1
    end
    object cdsClientesCRM_NOMCAM: TStringField
      FieldName = 'CRM_NOMCAM'
      Size = 10
    end
    object cdsClientesCRM_EXIBIR: TStringField
      FieldName = 'CRM_EXIBIR'
      Size = 1
    end
    object cdsClientesCRM_DESCAM: TStringField
      FieldName = 'CRM_DESCAM'
      Size = 100
    end
    object cdsClientesCRM_CODEMP: TStringField
      FieldName = 'CRM_CODEMP'
      Size = 3
    end
  end
  object dspClientes: TUniDataSetProvider
    DataSet = qryClientes
    Options = []
    Left = 199
    Top = 128
  end
  object qryClientes: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM CLICRM')
    Constraints = <>
    Left = 231
    Top = 128
    object qryClientesCRM_TIP_FC: TStringField
      FieldName = 'CRM_TIP_FC'
      Size = 1
    end
    object qryClientesCRM_NOMCAM: TStringField
      FieldName = 'CRM_NOMCAM'
      Size = 10
    end
    object qryClientesCRM_EXIBIR: TStringField
      FieldName = 'CRM_EXIBIR'
      Size = 1
    end
    object qryClientesCRM_DESCAM: TStringField
      FieldName = 'CRM_DESCAM'
      Size = 100
    end
    object qryClientesCRM_CODEMP: TStringField
      FieldName = 'CRM_CODEMP'
    end
  end
end
