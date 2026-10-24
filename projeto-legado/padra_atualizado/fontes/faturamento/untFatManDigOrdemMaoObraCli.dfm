inherited frmFatManDigOrdemMaoObraCli: TfrmFatManDigOrdemMaoObraCli
  Width = 740
  Height = 450
  Caption = 'Digita'#231#227'o de Ordem de M'#227'o de Obra do Cliente'
  Position = poMainFormCenter
  ExplicitWidth = 740
  ExplicitHeight = 450
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 376
    Width = 734
    inherited FlwBotoes: TFlowPanel
      Width = 730
      ExplicitWidth = 765
    end
  end
  inherited pnlStatus: TPanel
    Top = 405
    Width = 734
    ExplicitTop = 460
    inherited pnlNomeForm: TPanel
      Left = 563
    end
    inherited pnlInfo: TPanel
      Width = 563
    end
  end
  inherited pgcDados: TPageControl
    Width = 69
    Height = 33
    Align = alNone
    Visible = False
    ExplicitWidth = 69
    ExplicitHeight = 33
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 761
      ExplicitHeight = 428
    end
  end
  object pnlBotoesMostra: TPanel [3]
    Left = 0
    Top = 376
    Width = 734
    Height = 29
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Caption = 
      'Pressione [F5] sobre um produto para copiar a ordem de m'#227'o de ob' +
      'ra para todos...'
    Color = 16770261
    TabOrder = 3
    ExplicitLeft = -249
    ExplicitTop = 395
    ExplicitWidth = 1018
    DesignSize = (
      734
      29)
    object btnFechar: TBitBtnLocked
      Left = 873
      Top = 3
      Width = 77
      Height = 22
      Anchors = [akRight, akBottom]
      Caption = '&Fechar'
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
      TabOrder = 0
      ExplicitLeft = 852
    end
    object btnConfirma: TBitBtnLocked
      Left = 4
      Top = 2
      Width = 101
      Height = 22
      Caption = '&[F10] Confirma'
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
      NumGlyphs = 2
      TabOrder = 1
      OnClick = btnConfirmaClick
    end
  end
  object dbgServicos: TcxGrid [4]
    Left = 0
    Top = 0
    Width = 734
    Height = 376
    Align = alClient
    TabOrder = 4
    ExplicitLeft = -8
    ExplicitTop = -2
    ExplicitWidth = 769
    ExplicitHeight = 431
    object dbgServicosDBTableView1: TcxGridDBTableView
      OnKeyDown = dbgServicosDBTableView1KeyDown
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = dbgServicosDBTableView1CustomDrawCell
      OnEditKeyPress = dbgServicosDBTableView1EditKeyPress
      DataController.DataSource = dtsDados
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para filtrar'
      FilterRow.Visible = True
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      object dbgServicosDBTableViewCODSER: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'CODSER'
        Options.Editing = False
        Width = 55
      end
      object dbgServicosDBTableViewDESSER: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'DESSER'
        Options.Editing = False
        Width = 337
      end
      object dbgServicosDBTableViewQTDSER: TcxGridDBColumn
        Caption = 'Quantidade'
        DataBinding.FieldName = 'QTDSER'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taRightJustify
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 66
      end
      object dbgServicosDBTableViewUNITAR: TcxGridDBColumn
        Caption = 'Vr. Unit'#225'rio'
        DataBinding.FieldName = 'VALUNI'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taRightJustify
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 71
      end
      object dbgServicosDBTableViewTOTSER: TcxGridDBColumn
        Caption = 'Vr. Total'
        DataBinding.FieldName = 'VALSER'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 73
      end
      object dbgServicosDBTableViewMAOCLI: TcxGridDBColumn
        Caption = 'Ordem de M'#227'o de Obra'
        DataBinding.FieldName = 'MAOCLI'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        Width = 120
      end
    end
    object dbgServicosLevel1: TcxGridLevel
      GridView = dbgServicosDBTableView1
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 464
    Top = 0
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 376
    Top = 0
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 288
    Top = 0
  end
  object dtsDados: TDataSource
    Left = 536
  end
end
