inherited frmFiltroInconsistenciasMkt: TfrmFiltroInconsistenciasMkt
  Width = 448
  Height = 319
  BorderIcons = []
  Caption = 'Listar as seguintes inconsist'#234'ncias'
  Position = poScreenCenter
  ExplicitWidth = 448
  ExplicitHeight = 319
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 246
    Width = 442
    TabOrder = 1
    ExplicitTop = 246
    ExplicitWidth = 442
    inherited FlwBotoes: TFlowPanel
      Width = 438
      ExplicitWidth = 438
      object btnImprimir: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 77
        Height = 24
        Align = alLeft
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
    inherited btnSair: TBitBtnLocked
      Left = 359
      ExplicitLeft = 359
    end
  end
  inherited pnlStatus: TPanel
    Top = 274
    Width = 442
    TabOrder = 2
    ExplicitTop = 274
    ExplicitWidth = 442
    inherited pnlNomeForm: TPanel
      Left = 271
      ExplicitLeft = 271
    end
    inherited pnlInfo: TPanel
      Width = 271
      ExplicitWidth = 271
    end
  end
  object pnlOpcoes: TPanel [2]
    Left = 0
    Top = 0
    Width = 442
    Height = 246
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object chkNaoEncontrados: TCheckBox
      Left = 21
      Top = 13
      Width = 404
      Height = 17
      Caption = 'Registro do arquivo n'#227'o encontrado nos lan'#231'amentos do sistema.'
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
    object chkBaixados: TCheckBox
      Left = 21
      Top = 36
      Width = 404
      Height = 17
      Caption = 'Pedido j'#225' foi baixado.'
      Checked = True
      State = cbChecked
      TabOrder = 1
    end
    object chkConciliadosZerado: TCheckBox
      Left = 21
      Top = 84
      Width = 404
      Height = 17
      Caption = 'Pedidos cancelados (conciliados).'
      Checked = True
      State = cbChecked
      TabOrder = 3
    end
    object chkTaxasFreteInconsistentes: TCheckBox
      Left = 21
      Top = 111
      Width = 404
      Height = 17
      Caption = 'Pedidos conciliados com valor de taxas ou frete divergentes.'
      Checked = True
      State = cbChecked
      TabOrder = 4
    end
    object chkListaArquivos: TCheckBox
      Left = 21
      Top = 166
      Width = 404
      Height = 17
      Caption = 'Exibir lista de arquivos conciliados.'
      Checked = True
      State = cbChecked
      TabOrder = 6
    end
    object chkValorBrutoDivergente: TCheckBox
      Left = 21
      Top = 60
      Width = 404
      Height = 17
      Caption = 'Pedidos com valor bruto divergente.'
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
    object chkCupomInconsistente: TCheckBox
      Left = 21
      Top = 138
      Width = 404
      Height = 17
      Caption = 'Pedidos conciliados com valor de cupom divergente.'
      Checked = True
      State = cbChecked
      TabOrder = 5
    end
    object rdgOrdenar: TRadioGroup
      Left = 21
      Top = 189
      Width = 308
      Height = 45
      Caption = 'Ordenar por:'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Data de Vencimento'
        'External Ref')
      TabOrder = 7
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 416
    Top = 120
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 416
    Top = 88
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 416
    Top = 168
  end
end
