inherited frmManECommerce: TfrmManECommerce
  Left = 214
  Top = 276
  Width = 800
  Height = 797
  BorderStyle = bsDialog
  Caption = 'Manuten'#231#227'o de E-COMMERCE'
  Position = poScreenCenter
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  ExplicitWidth = 800
  ExplicitHeight = 797
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 718
    Width = 794
    Height = 34
    BevelOuter = bvNone
    BorderWidth = 1
    Color = 16770261
    TabOrder = 2
    ExplicitTop = 521
    ExplicitWidth = 794
    ExplicitHeight = 34
    DesignSize = (
      794
      34)
    inherited FlwBotoes: TFlowPanel
      Width = 790
      Height = 30
      TabOrder = 2
      ExplicitWidth = 790
      ExplicitHeight = 30
    end
    inherited btnSair: TBitBtnLocked
      Left = 678
      Top = 5
      Width = 111
      Height = 25
      Caption = '(ESC) &Sair'
      Glyph.Data = {00000000}
      ExplicitLeft = 678
      ExplicitTop = 5
      ExplicitWidth = 111
      ExplicitHeight = 25
    end
    object btnConfirma: TBitBtnLocked
      Left = 4
      Top = 5
      Width = 111
      Height = 25
      Caption = '[ F10 ] Confirma'
      Enabled = False
      TabOrder = 0
      OnClick = btnConfirmaClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 752
    Width = 794
    TabOrder = 3
    ExplicitTop = 555
    ExplicitWidth = 794
    inherited pnlNomeForm: TPanel
      Left = 623
      ExplicitLeft = 623
    end
    inherited pnlInfo: TPanel
      Width = 623
      ExplicitWidth = 623
    end
  end
  object pnlCabecalho: TPanel [2]
    Left = 0
    Top = 0
    Width = 794
    Height = 41
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 0
    object Label1: TLabel
      Left = 21
      Top = 15
      Width = 86
      Height = 14
      Alignment = taRightJustify
      Caption = 'Digite o C'#243'digo:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtCodIte: TEditFocus
      Tag = 99
      Left = 110
      Top = 10
      Width = 76
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 15
      TabOrder = 0
      OnEnter = edtCodIteEnter
      OnExit = edtCodIteExit
      OnKeyPress = edtCodIteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtDesIte: TEditFocus
      Left = 186
      Top = 10
      Width = 567
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlDadosECommerce: TPanel [3]
    Left = 0
    Top = 41
    Width = 794
    Height = 677
    Align = alClient
    BevelOuter = bvNone
    Caption = 'RESERVADO PARA TfrmPanelDadosECommerce'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = 40
    Font.Name = 'Arial Black'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentColor = True
    ParentFont = False
    TabOrder = 1
    ExplicitLeft = -2
    ExplicitTop = 40
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 560
    Top = 40
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 528
    Top = 40
  end
end
