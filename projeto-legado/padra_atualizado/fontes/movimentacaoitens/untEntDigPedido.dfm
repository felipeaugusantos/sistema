inherited frmEntDigPedido: TfrmEntDigPedido
  Left = 332
  Top = 337
  Width = 450
  Height = 201
  BorderIcons = [biSystemMenu]
  Caption = 'Entrada de Mercadorias'
  Position = poMainFormCenter
  ExplicitWidth = 450
  ExplicitHeight = 201
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 156
    Width = 444
    TabOrder = 3
    ExplicitTop = 156
    ExplicitWidth = 444
    DesignSize = (
      444
      0)
    inherited FlwBotoes: TFlowPanel
      Width = 440
      ExplicitWidth = 440
    end
    inherited btnSair: TBitBtnLocked
      Left = 209
      ExplicitLeft = 209
    end
  end
  inherited pnlStatus: TPanel
    Top = 156
    Width = 444
    TabOrder = 2
    ExplicitTop = 156
    ExplicitWidth = 444
    inherited pnlNomeForm: TPanel
      Left = 297
      Width = 147
      ExplicitLeft = 297
      ExplicitWidth = 147
    end
    inherited pnlInfo: TPanel
      Width = 297
      ExplicitWidth = 297
    end
  end
  inherited pgcDados: TPageControl
    Width = 444
    Height = 156
    TabOrder = 1
    Visible = False
    ExplicitWidth = 444
    ExplicitHeight = 156
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 436
      ExplicitHeight = 124
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 444
    Height = 156
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 0
    object lblTipoDoc: TLabel
      Left = 40
      Top = 130
      Width = 90
      Height = 14
      Alignment = taRightJustify
      Caption = 'Pedido de Compra:'
    end
    object lblEmpresa: TLabel
      Left = 85
      Top = 84
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblNotEle: TLabel
      Left = 55
      Top = 107
      Width = 75
      Height = 14
      Alignment = taRightJustify
      Caption = 'Nota Eletr'#244'nica:'
    end
    object edtNumPed: TEditFocus
      Tag = 99
      Left = 138
      Top = 126
      Width = 88
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 12
      TabOrder = 4
      OnKeyPress = edtNumPedKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttNumerico
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 138
      Top = 80
      Width = 41
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 3
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
      OnExit = edtCodEmpExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesEmpresa: TEditFocus
      Left = 180
      Top = 80
      Width = 252
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object rdgOpcoes: TRadioGroup
      Left = 8
      Top = 8
      Width = 424
      Height = 65
      Caption = 'Op'#231#245'es'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        '&Entrada'
        '&Devolu'#231#227'o')
      TabOrder = 0
      TabStop = True
      OnClick = rdgOpcoesClick
    end
    object edtNotEle: TEditFocus
      Left = 180
      Top = 103
      Width = 252
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 6
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object btnNotEle: TBitBtnLocked
      Left = 137
      Top = 103
      Width = 42
      Height = 22
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333FF33333333333330003FF3FFFFF3333777003000003333
        300077F777773F333777E00BFBFB033333337773333F7F33333FE0BFBF000333
        330077F3337773F33377E0FBFBFBF033330077F3333FF7FFF377E0BFBF000000
        333377F3337777773F3FE0FBFBFBFBFB039977F33FFFFFFF7377E0BF00000000
        339977FF777777773377000BFB03333333337773FF733333333F333000333333
        3300333777333333337733333333333333003333333333333377333333333333
        333333333333333333FF33333333333330003333333333333777333333333333
        3000333333333333377733333333333333333333333333333333}
      NumGlyphs = 2
      TabOrder = 2
      OnClick = btnNotEleClick
    end
    object cbbEsp: TComboBoxFocus
      Tag = 99
      Left = 139
      Top = 126
      Width = 39
      Height = 22
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 3
      Text = 'NF'
      Visible = False
      Items.Strings = (
        'NF'
        'IF')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 344
    Top = 32
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 312
    Top = 32
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 304
    Top = 104
  end
end
