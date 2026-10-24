inherited frmAjuda: TfrmAjuda
  Left = 284
  Top = 35
  Width = 400
  Height = 460
  BorderStyle = bsNone
  Caption = 'Ajuda'
  Color = clBlack
  TransparentColor = True
  Position = poMainFormCenter
  StyleElements = []
  ExplicitWidth = 400
  ExplicitHeight = 460
  PixelsPerInch = 96
  TextHeight = 14
  object Shape1: TShape [0]
    Left = 0
    Top = 0
    Width = 400
    Height = 443
    Align = alClient
    Brush.Color = clMedGray
    Pen.Color = clWhite
    Shape = stRoundRect
    ExplicitTop = 8
    ExplicitHeight = 399
  end
  inherited pnlBotoes: TPanel
    Top = 443
    Width = 400
    Height = 1
    Visible = False
    ExplicitTop = 443
    ExplicitWidth = 400
    ExplicitHeight = 1
    inherited FlwBotoes: TFlowPanel
      Width = 396
      ExplicitWidth = 396
    end
    inherited btnSair: TBitBtnLocked
      Left = 311
      Top = -24
      ExplicitLeft = 311
      ExplicitTop = -24
    end
  end
  object Panel8: TPanel [3]
    Left = 54
    Top = 13
    Width = 281
    Height = 49
    Alignment = taLeftJustify
    BevelInner = bvLowered
    Caption = '               Op'#231#245'es de Venda'
    Color = clMedGray
    Ctl3D = True
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentBackground = False
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 2
    StyleElements = []
  end
  inherited pnlStatus: TPanel
    Top = 444
    Width = 400
    Visible = False
    ExplicitTop = 444
    ExplicitWidth = 400
    inherited pnlNomeForm: TPanel
      Left = 229
      Visible = False
      ExplicitLeft = 229
    end
    inherited pnlInfo: TPanel
      Width = 229
      Visible = False
      ExplicitWidth = 229
    end
  end
  object Panel11: TPanel [5]
    Left = 54
    Top = 68
    Width = 281
    Height = 369
    Alignment = taLeftJustify
    BevelOuter = bvNone
    Color = clMedGray
    Ctl3D = True
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentBackground = False
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 4
    StyleElements = []
    object Panel1: TPanel
      Left = 0
      Top = 0
      Width = 281
      Height = 35
      Align = alTop
      Alignment = taLeftJustify
      BevelInner = bvLowered
      Caption = '               F1 - Ajuda'
      Color = clMedGray
      Ctl3D = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentBackground = False
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 0
      StyleElements = []
    end
    object Panel10: TPanel
      Left = 0
      Top = 35
      Width = 281
      Height = 35
      Align = alTop
      Alignment = taLeftJustify
      BevelInner = bvLowered
      Caption = '               F2 - Consulta Pre'#231'os'
      Color = clMedGray
      Ctl3D = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentBackground = False
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 1
      StyleElements = []
    end
    object Panel3: TPanel
      Left = 0
      Top = 70
      Width = 281
      Height = 35
      Align = alTop
      Alignment = taLeftJustify
      BevelInner = bvLowered
      Caption = '               F3 - Muda Quantidade'
      Color = clMedGray
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 2
      StyleElements = []
    end
    object Panel4: TPanel
      Left = 0
      Top = 105
      Width = 281
      Height = 35
      Align = alTop
      Alignment = taLeftJustify
      BevelInner = bvLowered
      Caption = '               F4 - Cancela Cupom'
      Color = clMedGray
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 3
      StyleElements = []
    end
    object Panel5: TPanel
      Left = 0
      Top = 140
      Width = 281
      Height = 35
      Align = alTop
      Alignment = taLeftJustify
      BevelInner = bvLowered
      Caption = '               F5 - Cancela Item'
      Color = clMedGray
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 4
      StyleElements = []
    end
    object Panel6: TPanel
      Left = 0
      Top = 175
      Width = 281
      Height = 35
      Align = alTop
      Alignment = taLeftJustify
      BevelInner = bvLowered
      Caption = '               F7 - Fechar com desconto'
      Color = clMedGray
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 5
      StyleElements = []
    end
    object Panel2: TPanel
      Left = 0
      Top = 210
      Width = 281
      Height = 35
      Align = alTop
      Alignment = taLeftJustify
      BevelInner = bvLowered
      Caption = '               F10 - Fechar Venda'
      Color = clMedGray
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 6
      StyleElements = []
    end
    object pnlRetificarPreco: TPanel
      Left = 0
      Top = 245
      Width = 281
      Height = 35
      Align = alTop
      Alignment = taLeftJustify
      BevelInner = bvLowered
      Caption = '               F11 - Retificar Pre'#231'o '
      Color = clMedGray
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 7
      StyleElements = []
    end
    object Panel9: TPanel
      Left = 0
      Top = 280
      Width = 281
      Height = 35
      Align = alTop
      Alignment = taLeftJustify
      BevelInner = bvLowered
      Caption = '               F12 - Abrir gaveta'
      Color = clMedGray
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 8
      StyleElements = []
    end
    object Panel7: TPanel
      Left = 0
      Top = 315
      Width = 281
      Height = 35
      Align = alTop
      Alignment = taLeftJustify
      BevelInner = bvLowered
      Caption = '               ESC - Sair'
      Color = clMedGray
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 9
      StyleElements = []
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 352
    Top = 184
  end
end
