inherited frmMenuPedCom: TfrmMenuPedCom
  Left = 354
  Top = 328
  Width = 458
  Height = 203
  BorderIcons = [biSystemMenu]
  Caption = 'Menu - Pedido de Compras'
  Position = poScreenCenter
  ExplicitWidth = 458
  ExplicitHeight = 203
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 130
    Width = 452
    Height = 28
    Enabled = True
    TabOrder = 1
    Visible = True
    ExplicitTop = 130
    ExplicitWidth = 452
    ExplicitHeight = 28
    DesignSize = (
      452
      28)
    inherited FlwBotoes: TFlowPanel
      Width = 448
      TabStop = True
      ExplicitWidth = 448
      object btnHeranca: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 165
        Height = 22
        Caption = '[ F3 ] Modo Heran'#231'a (INATIVO)'
        TabOrder = 0
        OnClick = btnHerancaClick
      end
      object btnCarrTxtFornecedor: TBitBtnLocked
        Left = 165
        Top = 0
        Width = 165
        Height = 22
        Caption = '[ F5 ] Carrega TXT Fornecedor'
        TabOrder = 1
        OnClick = btnCarrTxtFornecedorClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 231
      TabOrder = 2
      TabStop = False
      ExplicitLeft = 231
    end
    object BitBtn1: TBitBtnLocked
      Left = 372
      Top = 2
      Width = 77
      Height = 22
      Anchors = [akRight, akBottom]
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
  inherited pnlStatus: TPanel
    Top = 158
    Width = 452
    TabOrder = 3
    ExplicitTop = 158
    ExplicitWidth = 452
    inherited pnlNomeForm: TPanel
      Left = 303
      Width = 149
      ExplicitLeft = 303
      ExplicitWidth = 149
    end
    inherited pnlInfo: TPanel
      Width = 303
      ExplicitWidth = 303
    end
  end
  inherited pgcDados: TPageControl
    Width = 452
    Height = 130
    TabOrder = 2
    TabStop = False
    ExplicitWidth = 452
    ExplicitHeight = 130
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 444
      ExplicitHeight = 98
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 452
    Height = 130
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object lblPedOrc: TLabel
      Left = 33
      Top = 98
      Width = 94
      Height = 14
      Alignment = taRightJustify
      Caption = 'Pedido para alterar:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblEmpresa: TLabel
      Left = 82
      Top = 74
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
    end
    object edtNumPed: TEditFocus
      Tag = 99
      Left = 130
      Top = 93
      Width = 87
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 12
      TabOrder = 2
      OnKeyPress = edtNumPedKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttNumerico
    end
    object rdgOpcoes: TRadioGroup
      Left = 9
      Top = 8
      Width = 431
      Height = 54
      Caption = 'Op'#231#245'es'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        '&Pedido'
        '&Or'#231'amento')
      TabOrder = 0
    end
    object edtCodEmpresa: TEditFocus
      Tag = 99
      Left = 130
      Top = 70
      Width = 54
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 6
      TabOrder = 1
      OnExit = edtCodEmpresaExit
      OnKeyPress = edtCodEmpresaKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesEmpresa: TEditFocus
      Left = 184
      Top = 70
      Width = 255
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 328
    Top = 24
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 360
    Top = 24
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 160
    Top = 0
  end
  object cdsEmpMlj: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 392
    Top = 24
    object cdsEmpMljCODEMP: TStringField
      FieldName = 'CODEMP'
      Size = 3
    end
    object cdsEmpMljDESCRI: TStringField
      FieldName = 'DESCRI'
      Size = 40
    end
    object cdsEmpMljMARDES: TStringField
      FieldName = 'MARDES'
      Size = 1
    end
    object cdsEmpMljEMPVIS: TStringField
      FieldName = 'EMPVIS'
      Size = 3
    end
  end
end
