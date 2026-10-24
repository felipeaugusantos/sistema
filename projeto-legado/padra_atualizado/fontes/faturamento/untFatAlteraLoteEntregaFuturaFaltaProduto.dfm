inherited frmFatAlteraLoteEntregaFuturaFaltaProduto: TfrmFatAlteraLoteEntregaFuturaFaltaProduto
  Width = 670
  Height = 171
  Caption = 'Altera'#231#227'o de Entrega Futura - Falta de Produto'
  OnDestroy = FormDestroy
  ExplicitWidth = 670
  ExplicitHeight = 171
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 100
    Width = 664
    TabOrder = 2
    ExplicitTop = 100
    ExplicitWidth = 664
    inherited FlwBotoes: TFlowPanel
      Width = 660
      ExplicitWidth = 660
      inherited btnConfirma: TBitBtnLocked
        ModalResult = 0
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 581
      ExplicitLeft = 581
    end
  end
  inherited pnlStatus: TPanel
    Top = 126
    Width = 664
    TabOrder = 3
    ExplicitTop = 126
    ExplicitWidth = 664
    inherited pnlNomeForm: TPanel
      Left = 493
      ExplicitLeft = 493
    end
    inherited pnlInfo: TPanel
      Width = 493
      ExplicitWidth = 493
    end
  end
  object pnlInformacao: TPanel [2]
    Left = 0
    Top = 0
    Width = 664
    Height = 49
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object lblProduto: TLabel
      Left = 6
      Top = 8
      Width = 40
      Height = 14
      Caption = 'Produto:'
    end
    object lblQuantidade: TLabel
      Left = 288
      Top = 29
      Width = 29
      Height = 14
      Caption = 'Qtde.:'
    end
    object lblRefere: TLabel
      Left = 68
      Top = 29
      Width = 130
      Height = 14
      AutoSize = False
      Caption = 'XXXXXXXXXXXXXXXX'
    end
    object lblReferencia: TLabel
      Left = 6
      Top = 29
      Width = 56
      Height = 14
      Caption = 'Refer'#234'ncia:'
    end
    object lblCodPro: TLabel
      Left = 52
      Top = 8
      Width = 35
      Height = 14
      AutoSize = False
      Caption = '12345'
    end
    object lblNomPro: TLabel
      Left = 93
      Top = 8
      Width = 98
      Height = 14
      Caption = 'XXXXXXXXXXXXXX'
    end
    object lblUnidade: TLabel
      Left = 207
      Top = 29
      Width = 17
      Height = 14
      Caption = 'UN:'
    end
    object lblQtdPen: TLabel
      Left = 325
      Top = 29
      Width = 33
      Height = 14
      Alignment = taRightJustify
      Caption = '0,0000'
    end
    object lblCodUni: TLabel
      Left = 229
      Top = 29
      Width = 28
      Height = 14
      AutoSize = False
      Caption = 'XXXX'
    end
  end
  object pnlAlteracao: TPanel [3]
    Left = 0
    Top = 49
    Width = 664
    Height = 51
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 1
    object lblNumLot: TLabel
      Left = 10
      Top = 16
      Width = 52
      Height = 14
      Caption = 'Novo Lote:'
    end
    object lblMotivo: TLabel
      Left = 328
      Top = 16
      Width = 34
      Height = 14
      Caption = 'Motivo:'
    end
    object lblPrevisao: TLabel
      Left = 533
      Top = 16
      Width = 45
      Height = 14
      Caption = 'Previs'#227'o:'
    end
    object edtNumLot: TEditFocus
      Tag = 99
      Left = 68
      Top = 13
      Width = 237
      Height = 22
      Alignment = taLeftJustify
      TabOrder = 0
      OnKeyPress = edtNumLotKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object cbbMotivo: TComboBox
      Left = 369
      Top = 13
      Width = 145
      Height = 22
      TabOrder = 1
      OnChange = cbbMotivoChange
      Items.Strings = (
        'Falta Produto'
        'Aguardando Cliente'
        'Previs'#227'o de Entrega')
    end
    object mskDtaPre: TMaskEditFocus
      Tag = 99
      Left = 581
      Top = 13
      Width = 61
      Height = 22
      CharCase = ecUpperCase
      EditMask = '99/99/9999'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 2
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 912
    Top = 184
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 960
    Top = 176
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 872
    Top = 176
  end
end
