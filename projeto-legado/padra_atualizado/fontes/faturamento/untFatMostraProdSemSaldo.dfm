inherited frmFatMostraProdSemSaldo: TfrmFatMostraProdSemSaldo
  Left = 170
  Top = 196
  Width = 885
  Height = 460
  BorderIcons = [biSystemMenu]
  Caption = 'Os produtos abaixo n'#227'o possuem saldo suficiente'
  Position = poMainFormCenter
  ExplicitWidth = 885
  ExplicitHeight = 460
  PixelsPerInch = 96
  TextHeight = 14
  object splMensagemItem: TSplitter [0]
    Left = 0
    Top = 243
    Width = 879
    Height = 8
    Cursor = crVSplit
    Align = alBottom
    AutoSnap = False
    Beveled = True
    Color = 16770261
    ParentColor = False
    ResizeStyle = rsUpdate
    OnCanResize = splMensagemItemCanResize
    ExplicitTop = 399
    ExplicitWidth = 792
  end
  inherited pnlBotoes: TPanel
    Top = 251
    Width = 879
    TabOrder = 4
    ExplicitTop = 251
    ExplicitWidth = 794
    inherited FlwBotoes: TFlowPanel
      Width = 875
      ExplicitWidth = 790
    end
    inherited btnSair: TBitBtnLocked
      Left = 430
      ExplicitLeft = 430
    end
  end
  inherited pnlStatus: TPanel
    Top = 415
    Width = 879
    TabOrder = 3
    ExplicitTop = 415
    ExplicitWidth = 794
    inherited pnlNomeForm: TPanel
      Left = 690
      Width = 189
      ExplicitLeft = 605
      ExplicitWidth = 189
    end
    inherited pnlInfo: TPanel
      Width = 690
      ExplicitWidth = 605
    end
  end
  inherited pgcDados: TPageControl
    Width = 879
    Height = 243
    TabOrder = 2
    Visible = False
    ExplicitWidth = 794
    ExplicitHeight = 243
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 786
      ExplicitHeight = 211
    end
  end
  object dbgItens: TDBGridCitel [4]
    Left = 0
    Top = 0
    Width = 879
    Height = 243
    Align = alClient
    DataSource = dtsItens
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnKeyDown = dbgItensKeyDown
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'ITE_CODITE'
        Title.Caption = 'C'#243'digo'
        Width = 70
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_DESITE'
        Title.Caption = 'Descri'#231#227'o'
        Width = 345
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_QTDITE'
        Title.Alignment = taRightJustify
        Title.Caption = 'Quantidade'
        Width = 85
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_NUMLOT'
        Title.Caption = 'Lote'
        Width = 89
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_SALDOS'
        Title.Alignment = taRightJustify
        Title.Caption = 'Saldo F'#237'sico'
        Width = 95
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_SALDIS'
        Title.Alignment = taRightJustify
        Title.Caption = 'Saldo Dispon'#237'vel'
        Width = 95
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_CODEMP'
        Title.Caption = 'Emp.'
        Width = 40
        Visible = True
      end>
  end
  object pnlBotoesMostra: TPanel [5]
    Left = 0
    Top = 386
    Width = 879
    Height = 29
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 1
    ExplicitWidth = 794
    DesignSize = (
      879
      29)
    object btnFechar: TBitBtnLocked
      Left = 793
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
      ExplicitLeft = 708
    end
    object btnEstLojas: TBitBtnLocked
      Left = 4
      Top = 4
      Width = 133
      Height = 21
      Caption = '(F6) Consulta Estoque'
      TabOrder = 1
      OnClick = btnEstLojasClick
    end
  end
  object pnlMensagemItem: TPanel [6]
    Left = 0
    Top = 251
    Width = 879
    Height = 135
    Align = alBottom
    BevelOuter = bvNone
    ParentBackground = False
    ParentColor = True
    TabOrder = 5
    ExplicitWidth = 794
    object dbmMensag: TDBMemoFocus
      Left = 0
      Top = 0
      Width = 879
      Height = 135
      Align = alClient
      Color = clWhite
      Ctl3D = True
      DataField = 'ITE_MENSAG'
      DataSource = dtsItens
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
      WordWrap = False
      NormalColor = clWindow
      FocusColor = clWhite
      RequeridoColor = clRed
      Requerido = False
      StringQuebra = '<<csq>>'
      ExplicitWidth = 794
    end
  end
  object cdsItens: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 168
    Top = 72
    object cdsItensITE_CODITE: TStringField
      FieldName = 'ITE_CODITE'
    end
    object cdsItensITE_DESITE: TStringField
      FieldName = 'ITE_DESITE'
      Size = 50
    end
    object cdsItensITE_QTDITE: TFloatField
      FieldName = 'ITE_QTDITE'
      DisplayFormat = '#,##0.00'
    end
    object cdsItensITE_SALDOS: TFloatField
      FieldName = 'ITE_SALDOS'
      DisplayFormat = '#,##0.000'
    end
    object cdsItensITE_SALDIS: TFloatField
      FieldName = 'ITE_SALDIS'
      DisplayFormat = '#,##0.000'
    end
    object cdsItensITE_NUMLOT: TStringField
      FieldName = 'ITE_NUMLOT'
    end
    object cdsItensITE_DESSIM: TStringField
      FieldName = 'ITE_DESSIM'
      Size = 70
    end
    object cdsItensDET_INCREM: TStringField
      FieldName = 'DET_INCREM'
    end
    object cdsItensITE_MENSAG: TMemoField
      FieldName = 'ITE_MENSAG'
      BlobType = ftMemo
    end
    object cdsItensITE_CODEMP: TStringField
      FieldName = 'ITE_CODEMP'
      Size = 3
    end
  end
  object dtsItens: TDataSource
    DataSet = cdsItens
    Left = 208
    Top = 72
  end
end
