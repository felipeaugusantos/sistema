inherited frmConsultaPreco: TfrmConsultaPreco
  Left = 589
  Top = 309
  Width = 599
  Height = 400
  BorderIcons = []
  Caption = 'Consulta de Pre'#231'o'
  Color = 13750737
  Position = poScreenCenter
  StyleElements = [seBorder]
  ExplicitWidth = 599
  ExplicitHeight = 400
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 145
    Width = 593
    Height = 0
    Color = 13750737
    Visible = False
    ExplicitTop = 145
    ExplicitWidth = 593
    ExplicitHeight = 0
    inherited FlwBotoes: TFlowPanel
      Width = 589
    end
    inherited btnSair: TBitBtnLocked
      Left = 510
      Top = -25
      ExplicitLeft = 510
      ExplicitTop = -25
    end
  end
  object Panel1: TPanel [2]
    Left = 139
    Top = 7
    Width = 318
    Height = 130
    BevelOuter = bvNone
    BorderWidth = 7
    Color = 13750737
    ParentBackground = False
    TabOrder = 2
    StyleElements = []
    object Shape3: TShape
      Left = 7
      Top = 7
      Width = 304
      Height = 116
      Align = alClient
      Brush.Color = 13750737
      Shape = stRoundRect
    end
    object StaticText6: TStaticText
      Left = 76
      Top = 0
      Width = 162
      Height = 16
      Alignment = taCenter
      AutoSize = False
      Caption = 'C'#211'DIGO DE BARRA'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      Transparent = False
      StyleElements = []
    end
    object edtCodBarra: TEditFocus
      Tag = 98
      Left = 42
      Top = 47
      Width = 238
      Height = 35
      Alignment = taLeftJustify
      AutoSize = False
      Color = 16316664
      Ctl3D = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -27
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 15
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 1
      OnKeyPress = edtCodBarraKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object Panel2: TPanel [3]
    Left = 0
    Top = 145
    Width = 593
    Height = 210
    Align = alBottom
    BevelOuter = bvNone
    BorderWidth = 5
    Color = 13750737
    ParentBackground = False
    TabOrder = 3
    StyleElements = []
    object Shape4: TShape
      Left = 5
      Top = 5
      Width = 583
      Height = 200
      Align = alClient
      Brush.Color = 13750737
      Shape = stRoundRect
      ExplicitWidth = 581
    end
    object Shape5: TShape
      Left = 21
      Top = 18
      Width = 549
      Height = 85
      Brush.Color = clMedGray
      Pen.Color = clGray
      Shape = stRoundRect
    end
    object Shape6: TShape
      Left = 320
      Top = 127
      Width = 251
      Height = 65
      Brush.Color = clMedGray
      Pen.Color = clGray
      Shape = stRoundRect
    end
    object shpEmbagemFechada: TShape
      Left = 22
      Top = 127
      Width = 292
      Height = 65
      Brush.Color = clMedGray
      Pen.Color = clGray
      Shape = stRoundRect
    end
    object pnlNomeProduto: TPanel
      Left = 30
      Top = 41
      Width = 531
      Height = 41
      BevelOuter = bvNone
      Caption = '...'
      Color = clMedGray
      Ctl3D = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -20
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentBackground = False
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 0
      StyleElements = []
    end
    object pnlValorProduto: TPanel
      Left = 330
      Top = 139
      Width = 230
      Height = 41
      BevelOuter = bvNone
      Caption = '...'
      Color = clMedGray
      Ctl3D = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -24
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentBackground = False
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 1
      StyleElements = []
    end
    object StaticText2: TStaticText
      Left = 330
      Top = 109
      Width = 70
      Height = 16
      AutoSize = False
      Caption = ' PRE'#199'O '
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      StyleElements = []
    end
    object lbEmbagemFechada: TStaticText
      Left = 32
      Top = 109
      Width = 256
      Height = 16
      AutoSize = False
      Caption = ' TOTAL EMBALAGEM FECHADA '
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      StyleElements = []
    end
    object pnlEmbagemFechada: TPanel
      Left = 32
      Top = 139
      Width = 271
      Height = 41
      BevelOuter = bvNone
      Caption = '...'
      Color = clMedGray
      Ctl3D = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -24
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentBackground = False
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 4
      StyleElements = []
    end
  end
  object StaticText1: TStaticText [4]
    Left = 36
    Top = 140
    Width = 87
    Height = 15
    Alignment = taCenter
    AutoSize = False
    Caption = 'PRODUTO'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    Transparent = False
    StyleElements = []
  end
  inherited pnlStatus: TPanel
    Top = 355
    Width = 593
    StyleElements = []
    ExplicitTop = 355
    ExplicitWidth = 593
    inherited pnlNomeForm: TPanel
      Left = 422
      Color = 13750737
      StyleElements = []
      ExplicitLeft = 422
    end
    inherited pnlInfo: TPanel
      Width = 422
      Color = 13750737
      StyleElements = []
      ExplicitWidth = 422
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 24
    Top = 8
  end
end
