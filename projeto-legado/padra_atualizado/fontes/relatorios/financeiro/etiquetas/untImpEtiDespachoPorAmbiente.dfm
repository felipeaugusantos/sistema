inherited frmEtiDespachoPorAmbiente: TfrmEtiDespachoPorAmbiente
  Width = 598
  Height = 392
  Caption = 'Etiqueta de Despacho Por Ambiente'
  Position = poMainFormCenter
  ExplicitWidth = 598
  ExplicitHeight = 392
  PixelsPerInch = 96
  TextHeight = 14
  inherited pgcDados: TPageControl [0]
    Height = 461
    Align = alNone
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 761
      ExplicitHeight = 429
    end
  end
  inherited pnlBotoes: TPanel [1]
    Top = 319
    Width = 592
    ExplicitTop = 319
    ExplicitWidth = 592
    inherited FlwBotoes: TFlowPanel
      Width = 588
      ExplicitWidth = 588
    end
  end
  inherited pnlStatus: TPanel [2]
    Top = 347
    Width = 592
    ExplicitTop = 347
    ExplicitWidth = 592
    inherited pnlNomeForm: TPanel
      Left = 421
      ExplicitLeft = 421
    end
    inherited pnlInfo: TPanel
      Width = 421
      ExplicitWidth = 421
    end
  end
  object dbgDespachoPorAmbiente: TDBGridCitel [3]
    Left = 0
    Top = 0
    Width = 592
    Height = 319
    Align = alClient
    DataSource = dtsDespachoAmbiente
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgTitleClick, dgTitleHotTrack]
    TabOrder = 3
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'AMBIENTE'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = 'Ambiente'
        Width = 391
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VOLUME'
        Title.Alignment = taCenter
        Title.Caption = 'Volume(s)'
        Width = 153
        Visible = True
      end>
  end
  object Panel1: TPanel [4]
    Left = 0
    Top = 319
    Width = 592
    Height = 28
    Align = alBottom
    BevelInner = bvLowered
    BevelOuter = bvLowered
    Color = clGray
    ParentBackground = False
    TabOrder = 4
    DesignSize = (
      592
      28)
    object BitBtnLocked1: TBitBtnLocked
      Left = 510
      Top = 3
      Width = 77
      Height = 22
      Anchors = [akRight, akBottom]
      Cancel = True
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
    object btnConfirma: TBitBtnLocked
      Left = 6
      Top = 3
      Width = 85
      Height = 22
      Caption = '[ F10 ] Confirma'
      TabOrder = 0
      OnClick = btnConfirmaClick
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 48
    Top = 480
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 48
    Top = 448
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 48
    Top = 416
  end
  object cdsDespachoAmbiente: TUniClientDataSet
    Aggregates = <>
    AggregatesActive = True
    Params = <>
    BeforeInsert = cdsDespachoAmbienteBeforeInsert
    Left = 368
    Top = 248
    object cdsDespachoAmbienteAMBIENTE: TStringField
      FieldName = 'AMBIENTE'
      Size = 256
    end
    object cdsDespachoAmbienteVOLUME: TIntegerField
      FieldName = 'VOLUME'
      OnValidate = cdsDespachoAmbienteVOLUMEValidate
    end
    object TOTVOL: TAggregateField
      FieldName = 'TOTVOL'
      Active = True
      DisplayName = ''
      Expression = 'SUM(VOLUME)'
    end
  end
  object dtsDespachoAmbiente: TDataSource
    DataSet = cdsDespachoAmbiente
    Left = 484
    Top = 244
  end
end
