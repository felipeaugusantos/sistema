inherited frmMostrarTotalPorUnidade: TfrmMostrarTotalPorUnidade
  Width = 514
  Height = 415
  BorderIcons = [biSystemMenu]
  Caption = 'Total por unidade'
  Constraints.MaxWidth = 514
  Constraints.MinWidth = 500
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 514
  ExplicitHeight = 415
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 341
    Width = 508
    ExplicitTop = 341
    ExplicitWidth = 508
    inherited FlwBotoes: TFlowPanel
      Width = 504
      ExplicitWidth = 504
    end
  end
  inherited pnlStatus: TPanel
    Top = 370
    Width = 508
    ExplicitTop = 370
    ExplicitWidth = 508
    inherited pnlNomeForm: TPanel
      Left = 337
      ExplicitLeft = 337
    end
    inherited pnlInfo: TPanel
      Width = 337
      ExplicitWidth = 337
    end
  end
  inherited pgcDados: TPageControl
    Align = alNone
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 761
      ExplicitHeight = 428
    end
  end
  object pnlBotoesMostra: TPanel [3]
    Left = 0
    Top = 341
    Width = 508
    Height = 29
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 4
    DesignSize = (
      508
      29)
    object lblTotalKG: TLabel
      Left = 16
      Top = 9
      Width = 67
      Height = 14
      Caption = 'Total KG: 0,00'
    end
    object lblTotalLT: TLabel
      Left = 128
      Top = 9
      Width = 62
      Height = 14
      Caption = 'Total LT: 0,00'
    end
    object btnFechar: TBitBtnLocked
      Left = 420
      Top = 4
      Width = 77
      Height = 21
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
      OnClick = btnFecharClick
    end
  end
  object cxGrid1: TcxGrid [4]
    Left = 0
    Top = 0
    Width = 508
    Height = 341
    Align = alClient
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxGrid1DBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsLitrag
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Format = '#0.00'
          Kind = skSum
          FieldName = 'ITE_QTDITE'
          Column = cxGrid1DBTableView1Column3
          DisplayText = 'Quantidade'
        end
        item
          Format = '#0.00'
          Kind = skSum
          FieldName = 'ITE_PESLIT'
          Column = cxGrid1DBTableView1Column4
          DisplayText = 'Litragem'
        end>
      DataController.Summary.SummaryGroups = <>
      OptionsSelection.CellSelect = False
      OptionsView.Footer = True
      OptionsView.GroupByBox = False
      object cxGrid1DBTableView1Column1: TcxGridDBColumn
        Caption = 'Unidade'
        DataBinding.FieldName = 'ITE_SIGUNI'
        Options.Editing = False
        Width = 61
      end
      object cxGrid1DBTableView1Column2: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'ITE_DESUNI'
        Options.Editing = False
        Width = 276
      end
      object cxGrid1DBTableView1Column3: TcxGridDBColumn
        Caption = 'Quantidade'
        DataBinding.FieldName = 'ITE_QTDITE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#0.00'
        Options.Editing = False
      end
      object cxGrid1DBTableView1Column4: TcxGridDBColumn
        Caption = 'Litragem'
        DataBinding.FieldName = 'ITE_PESLIT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#0.000'
        Options.Editing = False
      end
      object cxGrid1DBTableView1UNI_KILLIT: TcxGridDBColumn
        Caption = 'KG/LT'
        DataBinding.FieldName = 'UNI_KILLIT'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        MinWidth = 40
        Width = 40
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 272
    Top = 24
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 368
    Top = 40
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 384
    Top = 104
  end
  object dtsLitrag: TDataSource
    Left = 176
    Top = 80
  end
end
