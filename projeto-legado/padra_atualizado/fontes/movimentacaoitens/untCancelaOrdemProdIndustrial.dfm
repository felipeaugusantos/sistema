inherited frmCancelaOrdemProdIndustrial: TfrmCancelaOrdemProdIndustrial
  Width = 504
  Height = 140
  Caption = 'Cancelamento de Ordem de Produ'#231#227'o Industrial'
  OnDestroy = FormDestroy
  ExplicitWidth = 504
  ExplicitHeight = 140
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 69
    Width = 498
    TabOrder = 1
    ExplicitTop = 69
    ExplicitWidth = 498
    inherited FlwBotoes: TFlowPanel
      Width = 417
      ExplicitTop = 2
      ExplicitWidth = 417
      inherited btnConfirma: TBitBtnLocked
        ModalResult = 0
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 419
      Top = 2
      Align = alRight
      ExplicitLeft = 419
      ExplicitTop = 2
    end
  end
  object pnl1: TPanel [2]
    Left = 0
    Top = 0
    Width = 498
    Height = 69
    Align = alClient
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    object lbl1: TLabel
      Left = 11
      Top = 18
      Width = 154
      Height = 14
      Alignment = taRightJustify
      Caption = 'N'#250'mero da Ordem de Produ'#231#227'o:'
    end
    object lbl5: TLabel
      Left = 125
      Top = 43
      Width = 40
      Height = 14
      Alignment = taRightJustify
      Caption = 'Produto:'
    end
    object mskDtaCad: TMaskEditFocus
      Tag = 99
      Left = 205
      Top = 11
      Width = 64
      Height = 22
      EditMask = '99/99/9999;1;_'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 1
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object edtNumOrd: TEditFocus
      Left = 168
      Top = 11
      Width = 36
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 3
      TabOrder = 0
      OnKeyPress = edtNumOrdKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object dbeCodIte: TDBEditFocus
      Left = 168
      Top = 36
      Width = 36
      Height = 22
      TabStop = False
      Color = 16768952
      DataField = 'CODITE'
      DataSource = dtsOrdPro
      Enabled = False
      ReadOnly = True
      TabOrder = 2
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDesIte: TDBEditFocus
      Left = 204
      Top = 36
      Width = 278
      Height = 22
      TabStop = False
      Color = 16768952
      DataField = 'DESITE'
      DataSource = dtsOrdPro
      Enabled = False
      ReadOnly = True
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  inherited pnlStatus: TPanel
    Top = 95
    Width = 498
    TabOrder = 2
    ExplicitTop = 95
    ExplicitWidth = 498
    inherited pnlNomeForm: TPanel
      Left = 327
      ExplicitLeft = 327
    end
    inherited pnlInfo: TPanel
      Width = 327
      ExplicitWidth = 327
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 560
  end
  object dtsOrdPro: TDataSource
    Left = 320
    Top = 8
  end
end
