inherited frmImpOrdProIndustrial: TfrmImpOrdProIndustrial
  Width = 385
  Height = 469
  Caption = 'Impress'#227'o de Ordem de Produ'#231#227'o Industrial'
  OnDestroy = FormDestroy
  ExplicitWidth = 385
  ExplicitHeight = 469
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 396
    Width = 379
    TabOrder = 5
    ExplicitTop = 396
    ExplicitWidth = 379
    inherited FlwBotoes: TFlowPanel
      Width = 375
      TabOrder = 2
      ExplicitWidth = 375
    end
    inherited btnSair: TBitBtnLocked
      Left = 296
      ExplicitLeft = 296
    end
    object btnImprimir: TBitBtnLocked
      Left = 11
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
    Top = 424
    Width = 379
    TabOrder = 4
    ExplicitTop = 424
    ExplicitWidth = 379
    inherited pnlNomeForm: TPanel
      Left = 208
      ExplicitLeft = 208
    end
    inherited pnlInfo: TPanel
      Width = 208
      ExplicitWidth = 208
    end
  end
  object pnlOPCompleta: TPanel [2]
    Left = 0
    Top = 0
    Width = 379
    Height = 35
    Align = alTop
    BevelOuter = bvLowered
    ParentColor = True
    TabOrder = 0
    object chkOpComp: TCheckBox
      Left = 16
      Top = 10
      Width = 209
      Height = 17
      Caption = 'Ordem de Produ'#231#227'o Completa'
      Checked = True
      State = cbChecked
      TabOrder = 0
      OnClick = chkOpCompClick
    end
  end
  object pnlOpcoes: TPanel [3]
    Left = 0
    Top = 35
    Width = 379
    Height = 124
    Align = alTop
    BevelOuter = bvLowered
    Enabled = False
    ParentColor = True
    TabOrder = 1
    object chkFormul: TCheckBox
      Left = 16
      Top = 8
      Width = 209
      Height = 17
      Caption = 'Formula'#231#227'o'
      Checked = True
      Enabled = False
      State = cbChecked
      TabOrder = 0
      OnClick = chkFormulClick
    end
    object chkConQua: TCheckBox
      Left = 16
      Top = 76
      Width = 209
      Height = 17
      Caption = 'Controle de Qualidade'
      Checked = True
      Enabled = False
      State = cbChecked
      TabOrder = 1
    end
    object chkTemPro: TCheckBox
      Left = 244
      Top = 8
      Width = 130
      Height = 17
      Caption = 'Tempos de Produ'#231#227'o'
      Checked = True
      Enabled = False
      State = cbChecked
      TabOrder = 2
    end
    object chkEnvase: TCheckBox
      Left = 244
      Top = 25
      Width = 130
      Height = 17
      Caption = 'Envase'
      Checked = True
      Enabled = False
      State = cbChecked
      TabOrder = 3
    end
    object chkCorrec: TCheckBox
      Left = 16
      Top = 59
      Width = 209
      Height = 17
      Caption = 'Corre'#231#245'es da OP'
      Checked = True
      Enabled = False
      State = cbChecked
      TabOrder = 4
    end
    object ChkExtrusao: TCheckBox
      Left = 244
      Top = 43
      Width = 90
      Height = 17
      Caption = 'Extrus'#227'o'
      Checked = True
      Enabled = False
      State = cbChecked
      TabOrder = 5
      Visible = False
    end
    object ChkAnaFor: TCheckBox
      Left = 244
      Top = 59
      Width = 133
      Height = 17
      Caption = 'An'#225'lise de Formula'#231#227'o'
      Checked = True
      Enabled = False
      State = cbChecked
      TabOrder = 6
      Visible = False
    end
    object ChkDadCli: TCheckBox
      Left = 244
      Top = 76
      Width = 133
      Height = 17
      Caption = 'Dados do Cliente'
      Checked = True
      Enabled = False
      State = cbChecked
      TabOrder = 7
      Visible = False
    end
    object chkVisCon: TCheckBox
      Left = 33
      Top = 42
      Width = 133
      Height = 17
      Caption = 'Visto do Conferente'
      Checked = True
      State = cbChecked
      TabOrder = 8
      Visible = False
    end
    object chkLocFis: TCheckBox
      Left = 33
      Top = 25
      Width = 133
      Height = 17
      Caption = 'Localiza'#231#227'o F'#237'sica'
      TabOrder = 9
      Visible = False
    end
    object chkObsAss: TCheckBox
      Left = 16
      Top = 93
      Width = 150
      Height = 17
      Caption = 'Observa'#231#245'es/Assinaturas'
      Enabled = False
      TabOrder = 10
      Visible = False
    end
  end
  object pnlFaseDisp: TPanel [4]
    Left = 0
    Top = 159
    Width = 379
    Height = 38
    Align = alTop
    BevelOuter = bvLowered
    ParentColor = True
    TabOrder = 2
    object Label1: TLabel
      Left = 208
      Top = 12
      Width = 106
      Height = 14
      Caption = 'Quantidade de Fases:'
    end
    object chkFasDis: TCheckBox
      Left = 16
      Top = 11
      Width = 162
      Height = 17
      Caption = 'Imprimir Fases de Dispers'#227'o'
      TabOrder = 0
      OnClick = chkFasDisClick
    end
    object edtQtdFas: TEditFocus
      Tag = 99
      Left = 318
      Top = 6
      Width = 43
      Height = 22
      Alignment = taLeftJustify
      Enabled = False
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttInteiro
    end
  end
  object pnlModelo5: TPanel [5]
    Left = 0
    Top = 197
    Width = 379
    Height = 199
    Align = alClient
    BevelOuter = bvLowered
    ParentColor = True
    TabOrder = 3
    TabStop = True
    object lblQuantidadePartida: TLabel
      Left = 16
      Top = 6
      Width = 112
      Height = 14
      Caption = 'Quantidade de Partidas'
    end
    object Label3: TLabel
      Left = 16
      Top = 51
      Width = 66
      Height = 14
      Caption = 'Observa'#231#245'es'
    end
    object edtQtdPar: TEditFocus
      Tag = 99
      Left = 16
      Top = 23
      Width = 44
      Height = 22
      Alignment = taRightJustify
      TabOrder = 0
      Text = '1'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttInteiro
    end
    object mmoObservacao: TMemoFocus
      Left = 16
      Top = 68
      Width = 345
      Height = 117
      CharCase = ecUpperCase
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      StringQuebra = '<<csq>>'
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 296
    Top = 192
  end
  inherited ApplicationEvents: TApplicationEvents
    Top = 192
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Top = 224
  end
end
