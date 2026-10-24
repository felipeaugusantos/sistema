inherited frmImpEtiDespachoSelecaoCaixas: TfrmImpEtiDespachoSelecaoCaixas
  Width = 528
  Height = 295
  BorderIcons = [biSystemMenu]
  Caption = 'Sele'#231#227'o das caixas para impress'#227'o'
  Position = poMainFormCenter
  ExplicitWidth = 528
  ExplicitHeight = 295
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 222
    Width = 522
    ExplicitTop = 222
    ExplicitWidth = 522
    inherited FlwBotoes: TFlowPanel
      Width = 518
      ExplicitWidth = 518
    end
  end
  inherited pnlStatus: TPanel
    Top = 250
    Width = 522
    ExplicitTop = 250
    ExplicitWidth = 522
    inherited pnlNomeForm: TPanel
      Left = 351
      ExplicitLeft = 351
    end
    inherited pnlInfo: TPanel
      Width = 351
      ExplicitWidth = 351
    end
  end
  inherited pgcDados: TPageControl
    Left = 88
    Top = 50
    Width = 50
    Height = 50
    Align = alNone
    ExplicitLeft = 88
    ExplicitTop = 50
    ExplicitWidth = 50
    ExplicitHeight = 50
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 42
      ExplicitHeight = 18
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 222
    Width = 522
    Height = 28
    Align = alBottom
    BevelInner = bvLowered
    BevelOuter = bvLowered
    Color = clGray
    ParentBackground = False
    TabOrder = 3
    DesignSize = (
      522
      28)
    object BitBtnLocked1: TBitBtnLocked
      Left = 440
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
      TabOrder = 2
      OnClick = btnSairClick
    end
    object btnConfirma: TBitBtnLocked
      Left = 118
      Top = 3
      Width = 85
      Height = 22
      Caption = '[ F10 ] Confirma'
      TabOrder = 0
      OnClick = btnConfirmaClick
    end
    object btnConfigurar: TBitBtnLocked
      Left = 4
      Top = 3
      Width = 115
      Height = 22
      Anchors = [akLeft, akBottom]
      Caption = '[F2] &Selecionar Todas'
      TabOrder = 1
      OnClick = btnConfigurarClick
    end
  end
  object Panel2: TPanel [4]
    Left = 0
    Top = 0
    Width = 522
    Height = 222
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 4
    object dbgSelecaoCaixas: TDBGridCitel
      Left = 1
      Top = 1
      Width = 520
      Height = 220
      Align = alClient
      DataSource = dtsSelecaoCaixas
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = 14
      TitleFont.Name = 'Arial'
      TitleFont.Pitch = fpVariable
      TitleFont.Style = []
      OnDrawColumnCell = dbgSelecaoCaixasDrawColumnCell
      OnDblClick = dbgSelecaoCaixasDblClick
      CorZebra = clMoneyGreen
      Zebra = False
      DestacarMouse = False
      Columns = <
        item
          Expanded = False
          FieldName = 'FGC_CAI_ID'
          Width = 110
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'FGO_NUMDOC'
          Width = 90
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'FGO_ESPDOC'
          Width = 40
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'FGO_CODEMP'
          Width = 45
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'FGC_NUMFAT'
          Width = 90
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'FGC_TIPFAT'
          Width = 40
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'FGC_EMPFAT'
          Width = 45
          Visible = True
        end>
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 64
    Top = 376
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 36
    Top = 376
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 8
    Top = 376
  end
  object dtsSelecaoCaixas: TDataSource
    DataSet = cdsSelecaoCaixas
    Left = 452
    Top = 156
  end
  object cdsSelecaoCaixas: TUniClientDataSet
    Aggregates = <>
    IndexFieldNames = 'FGC_CAI_ID'
    Params = <>
    Left = 357
    Top = 156
    object cdsSelecaoCaixasFGC_IMPRIM: TBooleanField
      FieldName = 'FGC_IMPRIM'
    end
    object cdsSelecaoCaixasFGC_CAI_ID: TStringField
      DisplayLabel = 'ID Caixa'
      FieldName = 'FGC_CAI_ID'
    end
    object cdsSelecaoCaixasFGO_DTAENT: TDateField
      FieldName = 'FGO_DTAENT'
    end
    object cdsSelecaoCaixasFGO_NUMDOC: TStringField
      DisplayLabel = 'N'#250'm.Docto'
      DisplayWidth = 30
      FieldName = 'FGO_NUMDOC'
    end
    object cdsSelecaoCaixasFGO_ESPDOC: TStringField
      DisplayLabel = 'Esp'
      DisplayWidth = 10
      FieldName = 'FGO_ESPDOC'
    end
    object cdsSelecaoCaixasFGO_CODEMP: TStringField
      DisplayLabel = 'Emp'
      DisplayWidth = 10
      FieldName = 'FGO_CODEMP'
    end
    object cdsSelecaoCaixasFGC_NUMFAT: TStringField
      DisplayLabel = 'N'#250'm.Fatur.'
      DisplayWidth = 30
      FieldName = 'FGC_NUMFAT'
    end
    object cdsSelecaoCaixasFGC_TIPFAT: TStringField
      DisplayLabel = 'Esp'
      DisplayWidth = 10
      FieldName = 'FGC_TIPFAT'
    end
    object cdsSelecaoCaixasFGC_EMPFAT: TStringField
      DisplayLabel = 'Emp'
      DisplayWidth = 10
      FieldName = 'FGC_EMPFAT'
    end
    object cdsSelecaoCaixasFDO_CODVEN: TStringField
      FieldName = 'FDO_CODVEN'
      Size = 3
    end
    object cdsSelecaoCaixasFDO_CODVE2: TStringField
      FieldName = 'FDO_CODVE2'
      Size = 3
    end
    object cdsSelecaoCaixasCLI_BAIRRO: TStringField
      FieldName = 'CLI_BAIRRO'
      Size = 60
    end
    object cdsSelecaoCaixasCLI_C_E_P_: TStringField
      FieldName = 'CLI_C_E_P_'
      Size = 9
    end
    object cdsSelecaoCaixasCLI_CODCLI: TStringField
      FieldName = 'CLI_CODCLI'
      Size = 8
    end
    object cdsSelecaoCaixasCLI_ENDERE: TStringField
      FieldName = 'CLI_ENDERE'
      Size = 60
    end
    object cdsSelecaoCaixasCLI_ENDNUM: TStringField
      FieldName = 'CLI_ENDNUM'
      Size = 10
    end
    object cdsSelecaoCaixasCLI_ENDCOM: TStringField
      FieldName = 'CLI_ENDCOM'
      Size = 60
    end
    object cdsSelecaoCaixasCLI_CODCID: TStringField
      FieldName = 'CLI_CODCID'
      Size = 5
    end
    object cdsSelecaoCaixasCLI_FANSOB: TStringField
      FieldName = 'CLI_FANSOB'
      Size = 60
    end
    object cdsSelecaoCaixasFDO_NUMCMP: TStringField
      FieldName = 'FDO_NUMCMP'
      Size = 15
    end
    object cdsSelecaoCaixasFGO_SEPEXP: TStringField
      FieldName = 'FGO_SEPEXP'
      Size = 3
    end
    object cdsSelecaoCaixasFGO_OPEEXP: TStringField
      FieldName = 'FGO_OPEEXP'
      Size = 3
    end
    object cdsSelecaoCaixasREG_DESREG: TStringField
      FieldName = 'REG_DESREG'
      Size = 40
    end
    object cdsSelecaoCaixasTRA_NOMTRA: TStringField
      FieldName = 'TRA_NOMTRA'
      Size = 40
    end
    object cdsSelecaoCaixasFGC_FDOINC: TStringField
      FieldName = 'FGC_FDOINC'
    end
    object cdsSelecaoCaixasFDO_TOTPES: TFloatField
      FieldName = 'FDO_TOTPES'
    end
    object cdsSelecaoCaixasFGO_PESBRU: TFloatField
      FieldName = 'FGO_PESBRU'
    end
    object cdsSelecaoCaixasFGO_CODROT: TStringField
      FieldName = 'FGO_CODROT'
      Size = 8
    end
    object cdsSelecaoCaixasFGC_DETINC: TStringField
      FieldName = 'FGC_DETINC'
    end
    object cdsSelecaoCaixasREG_CODREG: TStringField
      FieldName = 'REG_CODREG'
      Size = 8
    end
    object cdsSelecaoCaixasSEPAUT: TStringField
      FieldName = 'SEPAUT'
      Size = 256
    end
    object cdsSelecaoCaixasENDENT: TStringField
      FieldName = 'ENDENT'
      Size = 60
    end
    object cdsSelecaoCaixasCEPENT: TStringField
      FieldName = 'CEPENT'
      Size = 9
    end
    object cdsSelecaoCaixasCIDENT: TStringField
      FieldName = 'CIDENT'
      Size = 60
    end
    object cdsSelecaoCaixasESTENT: TStringField
      FieldName = 'ESTENT'
      Size = 2
    end
    object cdsSelecaoCaixasBAIENT: TStringField
      FieldName = 'BAIENT'
      Size = 60
    end
  end
end
