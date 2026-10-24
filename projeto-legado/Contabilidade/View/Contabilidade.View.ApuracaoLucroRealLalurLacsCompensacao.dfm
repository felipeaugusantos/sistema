inherited frmApuracaoLucroRealLalurLacsCompensacao: TfrmApuracaoLucroRealLalurLacsCompensacao
  Width = 553
  Height = 304
  Caption = 'Compensa'#231#227'o'
  OnDestroy = FormDestroy
  ExplicitWidth = 553
  ExplicitHeight = 304
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 233
    Width = 547
    TabOrder = 7
    ExplicitTop = 233
    ExplicitWidth = 547
    inherited FlwBotoes: TFlowPanel
      Width = 543
      ExplicitWidth = 543
      inherited btnConfirma: TBitBtnLocked
        ModalResult = 0
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 467
      ExplicitLeft = 467
    end
  end
  inherited pnlStatus: TPanel
    Top = 259
    Width = 547
    TabOrder = 8
    ExplicitTop = 259
    ExplicitWidth = 547
    inherited pnlNomeForm: TPanel
      Left = 376
      ExplicitLeft = 376
    end
    inherited pnlInfo: TPanel
      Width = 376
      ExplicitWidth = 376
    end
  end
  object cxLabel1: TcxLabel [2]
    Left = 244
    Top = 9
    Caption = 'Periodo:'
    Transparent = True
  end
  object edtDataInicio: TcxDateEdit [3]
    Left = 293
    Top = 8
    Enabled = False
    Properties.ReadOnly = True
    TabOrder = 0
    Width = 121
  end
  object edtDataFin: TcxDateEdit [4]
    Left = 416
    Top = 8
    Enabled = False
    Properties.ReadOnly = True
    TabOrder = 1
    Width = 121
  end
  object lbBCAntesCompesacao: TcxLabel [5]
    Left = 8
    Top = 39
    Caption = 'Base de C'#225'lculo antes da Compensa'#231#227'o da BC Negativa:'
    Properties.Alignment.Horz = taRightJustify
    AnchorX = 287
  end
  object edtBCAntesCompesacao: TCurrencyEditFocus [6]
    Left = 293
    Top = 38
    Properties.DisplayFormat = ' ,0.00;- ,0.00'
    Properties.ReadOnly = True
    StyleFocused.Color = clInfoBk
    TabOrder = 2
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    Width = 87
  end
  object cxLabel2: TcxLabel [7]
    Left = 103
    Top = 67
    Caption = 'Percentual M'#225'ximo de Compensa'#231#227'o:'
  end
  object edtPercentualMaximoCompensacao: TCurrencyEditFocus [8]
    Tag = 99
    Left = 293
    Top = 66
    EditValue = 30.000000000000000000
    Properties.DisplayFormat = ' ,0.00;- ,0.00'
    Properties.MaxValue = 100.000000000000000000
    Properties.ReadOnly = False
    StyleFocused.Color = clInfoBk
    TabOrder = 3
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    Width = 87
  end
  object cxLabel3: TcxLabel [9]
    Left = 383
    Top = 67
    Caption = '%'
  end
  object cxGroupBox1: TcxGroupBox [10]
    Left = 2
    Top = 91
    Caption = 'Preju'#237'zos Fiscais de Per'#237'odos de Apura'#231#245'es Anteriores'
    TabOrder = 4
    Height = 73
    Width = 537
    object lbOperacionalAnteriores: TcxLabel
      Left = 214
      Top = 17
      Caption = 'Operacionais:'
    end
    object lbNaoOperacionalAnteriores: TcxLabel
      Left = 192
      Top = 45
      Caption = 'N'#227'o Operacionais:'
    end
    object edtOperacionalAnteriores: TCurrencyEditFocus
      Left = 291
      Top = 16
      Properties.DisplayFormat = ' ,0.00;- ,0.00'
      Properties.ReadOnly = True
      StyleFocused.Color = clInfoBk
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      Width = 121
    end
    object edtNaoOperacionalAnteriores: TCurrencyEditFocus
      Left = 291
      Top = 44
      EditValue = 0.000000000000000000
      Properties.DisplayFormat = ' ,0.00;- ,0.00'
      Properties.ReadOnly = True
      StyleFocused.Color = clInfoBk
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      Width = 121
    end
  end
  object cxLabel6: TcxLabel [11]
    Left = 96
    Top = 173
    Caption = 'Resultado n'#227'o Operacional do Per'#237'odo:'
  end
  object edtOperacionalPeriodo: TCurrencyEditFocus [12]
    Left = 293
    Top = 171
    EditValue = 0.000000000000000000
    Enabled = False
    Properties.DisplayFormat = ' ,0.00;- ,0.00'
    StyleFocused.Color = clInfoBk
    TabOrder = 5
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    Width = 121
  end
  object chbGerarLancamentoParteB: TCheckBox [13]
    Left = 293
    Top = 206
    Width = 246
    Height = 17
    Caption = 'Gerar Lan'#231'amentos na Parte B'
    Checked = True
    State = cbChecked
    TabOrder = 6
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 480
    Top = 40
  end
end
