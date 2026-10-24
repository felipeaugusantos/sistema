inherited frmOpcRelEstruturaIndustrial: TfrmOpcRelEstruturaIndustrial
  Width = 275
  Height = 295
  BorderIcons = [biSystemMenu]
  Caption = 'Op'#231#245'es do Relat'#243'rio'
  Position = poMainFormCenter
  ExplicitWidth = 275
  ExplicitHeight = 295
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 222
    Width = 269
    ExplicitTop = 222
    ExplicitWidth = 269
    DesignSize = (
      269
      28)
    inherited FlwBotoes: TFlowPanel
      Width = 265
      TabOrder = 2
      ExplicitWidth = 265
    end
    inherited btnSair: TBitBtnLocked
      Left = 188
      ExplicitLeft = 188
    end
    object btnImprimir: TBitBtnLocked
      Left = 9
      Top = 3
      Width = 77
      Height = 22
      Anchors = [akRight, akBottom]
      Caption = '&Imprimir'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF9F9D9EFF00FFFF00FFFF00FF8281818281818E8A
        8BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F9D9E9F9D9ED4D1D196
        93933B393A545253999797C5C2C4D7D5D5828181FF00FFFF00FFFF00FFFF00FF
        9F9D9E9F9D9EFAFAFAFFFFFFD7D4D59E9C9C4443451C1C1E1C1C1F3534356766
        678281818E8A8BFF00FF918E8F9F9D9EF0EEEFFFFFFFEEEBEBCAC9C99F9D9E8E
        8A8A9793958786866463633C3B3D1F2022201F21747273FF00FF9C9899E9E7E7
        E5E5E5BDBBBBA6A4A4B4B1B1C2C1C1A4A1A19692939290909793959A98988E8A
        8B6B6A6A828181FF00FF959192ADABACA4A1A1B0AFAFC9C9C9D1D3D3EDEDEBF0
        EEF0DCDADAC5C4C4ADABAB9A98999390909793958E8A8BFF00FF918E8FAFADAF
        C9C7C7CECECEC9C9C9E2E2E2D1CFCFA1ABA1BDBCBCCBCECFD5D5D5D3D3D3C6C5
        C5B6B6B6989797FF00FFFF00FF9C999AD0D1D1CFCFCFDCDCDCC9C6C6B5B0B4A5
        D1A7BAC4BCC5A7A1ADA4A3A9A6A7B4B1B2C2C1C1A9A6A7FF00FFFF00FFFF00FF
        9C999AC1BFBFAFADADB1B0B0E3E3E3F6F3F3EEEDEEEDE1DEDCD8D8CCCCCCB4B4
        B4939091FF00FFFF00FFFF00FFFF00FFFF00FF9C999AD8DADACACACB9D9FA0BB
        BFC1D3D5D7D4D9D9D5D5D5C6C5C6AFADADFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFBE5E1F8E0D4E9C9BDE3C7BDE2CCC7DED3CED0CECC959295FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCE9F9DFFDECEFFCFBDFF
        C4AFFFBAA3FFB199FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFCE9F9DFFDDCEFFCCBCFEC2B0FFBBA4F7A992FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCE9F9DFFDDCEFFCCBCFE
        C2B0FEB8A3FAB099FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFCE9F9DFAE0D5FFDACCFFCEBDFFC6B1FCB8A3F8AD99FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCE9F9DCE9F9DCE9F9DCE9F9DF3
        AD9DF3AD9DFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 0
      OnClick = btnImprimirClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 250
    Width = 269
    ExplicitTop = 250
    ExplicitWidth = 269
    inherited pnlNomeForm: TPanel
      Left = 98
      ExplicitLeft = 98
    end
    inherited pnlInfo: TPanel
      Width = 98
      ExplicitWidth = 98
    end
  end
  object Panel1: TPanel [2]
    Left = 0
    Top = 0
    Width = 269
    Height = 222
    Align = alClient
    ParentColor = True
    TabOrder = 2
    object lblTabPreco: TLabel
      Left = 9
      Top = 183
      Width = 57
      Height = 14
      Caption = 'Tab.Pre'#231'o:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object gpbPreco: TGroupBox
      Left = 9
      Top = 57
      Width = 250
      Height = 50
      Caption = 'Imprimir Pre'#231'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object rdbSemPreco: TRadioButton
        Left = 10
        Top = 22
        Width = 75
        Height = 17
        Caption = 'Sem'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = rdbSemPrecoClick
      end
      object rdbPrecoCus: TRadioButton
        Left = 87
        Top = 22
        Width = 75
        Height = 17
        Caption = 'Custo'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnClick = rdbSemPrecoClick
      end
      object rdbPrecoVen: TRadioButton
        Left = 164
        Top = 22
        Width = 75
        Height = 17
        Caption = 'Venda'
        Checked = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        TabStop = True
        OnClick = rdbSemPrecoClick
      end
    end
    object cbTabPreco: TComboBoxFocus
      Tag = 99
      Left = 69
      Top = 175
      Width = 38
      Height = 22
      Style = csDropDownList
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      Sorted = True
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object gpbImprimir: TGroupBox
      Left = 9
      Top = 3
      Width = 250
      Height = 50
      Caption = 'Imprimir'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object rdbDescricao: TRadioButton
        Left = 29
        Top = 22
        Width = 75
        Height = 17
        Caption = 'Descri'#231#227'o'
        Checked = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        TabStop = True
      end
      object rdbReferenc: TRadioButton
        Left = 145
        Top = 22
        Width = 75
        Height = 17
        Caption = 'Refer'#234'ncia'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
    end
    object chkExcel: TCheckBox
      Left = 177
      Top = 179
      Width = 82
      Height = 17
      Caption = 'Gerar Excel'
      TabOrder = 3
    end
    object GroupBox1: TGroupBox
      Left = 9
      Top = 113
      Width = 250
      Height = 50
      Caption = 'Imprimir Formulas do Sub Produtos'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      object rdbImprimiForSubSim: TRadioButton
        Left = 29
        Top = 22
        Width = 75
        Height = 17
        Caption = 'Sim'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = rdbImprimiForSubSimClick
      end
      object rdbImprimiForSubNao: TRadioButton
        Left = 145
        Top = 22
        Width = 75
        Height = 17
        Caption = 'N'#227'o'
        Checked = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        TabStop = True
        OnClick = rdbImprimiForSubNaoClick
      end
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 360
    Top = 80
  end
end
