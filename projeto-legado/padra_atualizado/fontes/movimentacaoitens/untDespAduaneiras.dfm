inherited frmDespAduaneiras: TfrmDespAduaneiras
  Width = 277
  Height = 320
  Caption = 'Despesas Aduaneiras'
  ExplicitWidth = 277
  ExplicitHeight = 320
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 249
    Width = 271
    ExplicitTop = 249
    ExplicitWidth = 271
    inherited FlwBotoes: TFlowPanel
      Width = 267
      ExplicitWidth = 267
      inherited btnConfirma: TBitBtnLocked
        ModalResult = 0
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 191
      ExplicitLeft = 191
    end
  end
  inherited pnlStatus: TPanel
    Top = 275
    Width = 271
    ExplicitTop = 275
    ExplicitWidth = 271
    inherited pnlNomeForm: TPanel
      Left = 100
      ExplicitLeft = 100
    end
    inherited pnlInfo: TPanel
      Width = 100
      ExplicitWidth = 100
    end
  end
  object pnlDespesas: TPanel [3]
    Left = 0
    Top = 0
    Width = 271
    Height = 215
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    ExplicitHeight = 212
    object lblDemurrage: TLabel
      Left = 10
      Top = 8
      Width = 56
      Height = 14
      Caption = 'Demurrage:'
    end
    object lblTaxa: TLabel
      Left = 10
      Top = 33
      Width = 98
      Height = 14
      Caption = 'Taxa Armazenagem:'
    end
    object lblDespachante: TLabel
      Left = 10
      Top = 59
      Width = 67
      Height = 14
      Caption = 'Despachante:'
    end
    object lblFrete: TLabel
      Left = 10
      Top = 85
      Width = 28
      Height = 14
      Caption = 'Frete:'
    end
    object lblOutrasDesp: TLabel
      Left = 10
      Top = 110
      Width = 88
      Height = 14
      Caption = 'Outras Despesas:'
    end
    object lblMulta: TLabel
      Left = 10
      Top = 136
      Width = 109
      Height = 14
      Caption = 'Multa Setor Aduaneiro:'
    end
    object lblFreteInterno: TLabel
      Left = 10
      Top = 162
      Width = 64
      Height = 14
      Caption = 'Frete Interno:'
    end
    object lblF500: TLabel
      Left = 10
      Top = 188
      Width = 27
      Height = 14
      Caption = 'F500:'
    end
    object edtDemurrage: TEditFocus
      Tag = 99
      Left = 128
      Top = 5
      Width = 121
      Height = 22
      Alignment = taRightJustify
      TabOrder = 0
      OnExit = edtDemurrageExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtTaxa: TEditFocus
      Tag = 99
      Left = 128
      Top = 30
      Width = 121
      Height = 22
      Alignment = taRightJustify
      TabOrder = 1
      OnExit = edtDemurrageExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtDespachante: TEditFocus
      Tag = 99
      Left = 128
      Top = 56
      Width = 121
      Height = 22
      Alignment = taRightJustify
      TabOrder = 2
      OnExit = edtDemurrageExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtFrete: TEditFocus
      Tag = 99
      Left = 128
      Top = 82
      Width = 121
      Height = 22
      Alignment = taRightJustify
      TabOrder = 3
      OnExit = edtDemurrageExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtOutrasDesp: TEditFocus
      Tag = 99
      Left = 128
      Top = 107
      Width = 121
      Height = 22
      Alignment = taRightJustify
      TabOrder = 4
      OnExit = edtDemurrageExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtMulta: TEditFocus
      Tag = 99
      Left = 128
      Top = 133
      Width = 121
      Height = 22
      Alignment = taRightJustify
      TabOrder = 5
      OnExit = edtDemurrageExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtFreteInterno: TEditFocus
      Tag = 99
      Left = 128
      Top = 159
      Width = 121
      Height = 22
      Alignment = taRightJustify
      TabOrder = 6
      OnExit = edtDemurrageExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtF500: TEditFocus
      Tag = 99
      Left = 128
      Top = 185
      Width = 121
      Height = 22
      Alignment = taRightJustify
      TabOrder = 7
      OnExit = edtDemurrageExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
  end
  object pnlTotal: TPanel [4]
    Left = 0
    Top = 215
    Width = 271
    Height = 34
    Align = alBottom
    Color = 16770261
    ParentBackground = False
    TabOrder = 4
    ExplicitTop = 214
    object lblDespAduaneiras: TLabel
      Left = 10
      Top = 9
      Width = 110
      Height = 14
      Caption = 'Despesas Aduaneiras:'
    end
    object lblTotal: TLabel
      Left = 128
      Top = 9
      Width = 40
      Height = 14
      Caption = 'R$: 0,00'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 696
    Top = 152
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 696
    Top = 56
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 696
    Top = 104
  end
end
