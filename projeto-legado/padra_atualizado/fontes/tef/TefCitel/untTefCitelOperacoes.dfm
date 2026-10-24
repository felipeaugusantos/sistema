inherited frmTefCitelOperacoes: TfrmTefCitelOperacoes
  Width = 665
  Height = 285
  BorderIcons = []
  Caption = 'Opera'#231#245'es CliSiTef'
  Color = clBtnFace
  Position = poScreenCenter
  OnDestroy = FormDestroy
  OnKeyPress = FormKeyPress
  ExplicitWidth = 665
  ExplicitHeight = 285
  PixelsPerInch = 96
  TextHeight = 14
  object pnQRCode: TPanel [0]
    Left = 0
    Top = 0
    Width = 659
    Height = 240
    Align = alClient
    TabOrder = 3
    object imgQRCode: TImage
      AlignWithMargins = True
      Left = 181
      Top = 11
      Width = 297
      Height = 218
      Margins.Left = 180
      Margins.Top = 10
      Margins.Right = 180
      Margins.Bottom = 10
      Align = alClient
      Stretch = True
      ExplicitLeft = 238
      ExplicitTop = 10
      ExplicitWidth = 179
      ExplicitHeight = 216
    end
    object lbTmrPix: TLabel
      Left = 592
      Top = 212
      Width = 58
      Height = 17
      Caption = 'lbTmrPix'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
  end
  inherited pnlBotoes: TPanel
    Top = 605
    Align = alNone
    Visible = False
    ExplicitTop = 605
  end
  inherited pnlStatus: TPanel
    Top = 240
    Width = 659
    ExplicitTop = 240
    ExplicitWidth = 659
    inherited pnlNomeForm: TPanel
      Left = 488
      Visible = False
      ExplicitLeft = 488
    end
    inherited pnlInfo: TPanel
      Width = 488
      Visible = False
      ExplicitWidth = 488
    end
  end
  object pnPrincipal: TPanel [3]
    Left = 0
    Top = 0
    Width = 659
    Height = 240
    Align = alClient
    TabOrder = 2
    object pnOperacao: TPanel
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 651
      Height = 41
      Align = alTop
      Caption = 'SELECIONE A FORMA DE PAGAMENTO'
      Font.Charset = ANSI_CHARSET
      Font.Color = 204
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object pnMenu: TPanel
      AlignWithMargins = True
      Left = 4
      Top = 51
      Width = 166
      Height = 150
      Align = alLeft
      BevelOuter = bvLowered
      TabOrder = 1
      object btnCredito: TBitBtnLocked
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 158
        Height = 30
        Cursor = crHandPoint
        Align = alTop
        Caption = '1 -  Cr'#233'dito         '
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        Spacing = 8
        TabOrder = 0
        OnClick = btnCreditoClick
      end
      object btnDebito: TBitBtnLocked
        AlignWithMargins = True
        Left = 4
        Top = 40
        Width = 158
        Height = 30
        Cursor = crHandPoint
        Align = alTop
        Caption = '2 -  D'#233'bito          '
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        Spacing = 8
        TabOrder = 1
        OnClick = btnDebitoClick
      end
      object btnEncerraMenu: TBitBtnLocked
        AlignWithMargins = True
        Left = 4
        Top = 112
        Width = 158
        Height = 30
        Align = alTop
        Caption = '9 - Encerra          '
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        Spacing = 8
        TabOrder = 3
        OnClick = btnEncerraMenuClick
      end
      object btnPix: TBitBtnLocked
        AlignWithMargins = True
        Left = 4
        Top = 76
        Width = 158
        Height = 30
        Cursor = crHandPoint
        Align = alTop
        Caption = '3 -  PIX             '
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        Spacing = 8
        TabOrder = 2
      end
    end
    object pnOpcoesCredito: TPanel
      AlignWithMargins = True
      Left = 176
      Top = 51
      Width = 166
      Height = 150
      Align = alLeft
      BevelOuter = bvLowered
      TabOrder = 2
      Visible = False
      object btnAVista: TBitBtnLocked
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 158
        Height = 30
        Cursor = crHandPoint
        Align = alTop
        Caption = '1 - '#192' Vista          '
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        Spacing = 8
        TabOrder = 0
        OnClick = btnAVistaClick
      end
      object btnParcEstab: TBitBtnLocked
        AlignWithMargins = True
        Left = 4
        Top = 76
        Width = 158
        Height = 30
        Cursor = crHandPoint
        Align = alTop
        Caption = '3 - Parcelado Estab  '
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        Spacing = 8
        TabOrder = 2
        OnClick = btnParcEstabClick
      end
      object btnEncerraOpcoesCredito: TBitBtnLocked
        AlignWithMargins = True
        Left = 4
        Top = 112
        Width = 158
        Height = 30
        Align = alTop
        Caption = '9 - Retorna          '
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        Spacing = 8
        TabOrder = 3
        OnClick = btnEncerraOpcoesCreditoClick
      end
      object btnParcAdm: TBitBtnLocked
        AlignWithMargins = True
        Left = 4
        Top = 40
        Width = 158
        Height = 30
        Cursor = crHandPoint
        Align = alTop
        Caption = '2 - Parcelado Adm    '
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        Spacing = 8
        TabOrder = 1
        OnClick = btnParcAdmClick
      end
    end
    object pnDados: TPanel
      AlignWithMargins = True
      Left = 520
      Top = 51
      Width = 135
      Height = 150
      Align = alClient
      BevelOuter = bvLowered
      TabOrder = 3
      Visible = False
      DesignSize = (
        135
        150)
      object Panel1: TPanel
        Left = -79
        Top = 13
        Width = 293
        Height = 124
        Anchors = []
        BevelOuter = bvLowered
        TabOrder = 0
        object Label2: TLabel
          Left = 13
          Top = 62
          Width = 100
          Height = 14
          Caption = 'N'#250'mero de Parcelas:'
        end
        object Label1: TLabel
          Left = 85
          Top = 26
          Width = 28
          Height = 14
          Caption = 'Valor:'
        end
        object btnConfirma: TBitBtnLocked
          AlignWithMargins = True
          Left = 8
          Top = 83
          Width = 136
          Height = 27
          Caption = '1 - Confirma'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          OnClick = btnConfirmaClick
        end
        object btnRetorna: TBitBtnLocked
          AlignWithMargins = True
          Left = 150
          Top = 83
          Width = 136
          Height = 27
          Caption = '9 - Retorna'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          OnClick = btnRetornaClick
        end
        object edtQtdPar: TEditFocus
          Tag = 99
          Left = 133
          Top = 55
          Width = 121
          Height = 22
          Alignment = taRightJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 2
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtValor: TCurrencyEditFocus
          Left = 133
          Top = 22
          EditValue = 0.000000000000000000
          Enabled = False
          Style.Color = clWhite
          StyleDisabled.TextStyle = [fsBold]
          StyleFocused.Color = clInfoBk
          TabOrder = 3
          NormalColor = clWhite
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          Width = 121
        end
      end
    end
    object pnMensTef: TPanel
      Left = 1
      Top = 204
      Width = 657
      Height = 35
      Align = alBottom
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
    end
    object pnCarDig: TPanel
      AlignWithMargins = True
      Left = 348
      Top = 51
      Width = 166
      Height = 150
      Align = alLeft
      BevelOuter = bvLowered
      TabOrder = 5
      Visible = False
      object btnCarDig001: TBitBtnLocked
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 158
        Height = 32
        Cursor = crHandPoint
        Align = alTop
        Caption = 'btnCarDig001'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        Spacing = 8
        TabOrder = 0
        Visible = False
      end
      object btnCarDig002: TBitBtnLocked
        AlignWithMargins = True
        Left = 4
        Top = 42
        Width = 158
        Height = 30
        Cursor = crHandPoint
        Align = alTop
        Caption = 'btnCarDig002'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        Spacing = 8
        TabOrder = 1
        Visible = False
      end
      object btnEncerraOpcoesCarDig: TBitBtnLocked
        AlignWithMargins = True
        Left = 4
        Top = 112
        Width = 158
        Height = 30
        Caption = '9 - Retorna        '
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        Spacing = 8
        TabOrder = 2
        OnClick = btnEncerraOpcoesCarDigClick
      end
      object btnCarDig003: TBitBtnLocked
        AlignWithMargins = True
        Left = 4
        Top = 76
        Width = 136
        Height = 30
        Caption = 'btnCarDig003'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        Spacing = 8
        TabOrder = 3
        Visible = False
      end
      object btnPopMenu: TBitBtnLocked
        AlignWithMargins = True
        Left = 140
        Top = 76
        Width = 22
        Height = 30
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Glyph.Data = {
          36060000424D3606000000000000360000002800000020000000100000000100
          18000000000000060000C40E0000C40E00000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000001E1E1E1E1E1E0000000000000000000000
          000000000000000000000000000000000000000000000000000000000000001E
          1E1E1E1E1E000000000000000000000000000000000000000000000000000000
          0000000000000000000000001E1E1E3C3C3C3C3C3C1E1E1E0000000000000000
          000000000000000000000000000000000000000000000000000000001E1E1E3C
          3C3C3C3C3C1E1E1E000000000000000000000000000000000000000000000000
          0000000000000000001E1E1E3C3C3C3C3C3C3C3C3C3C3C3C1E1E1E0000000000
          000000000000000000000000000000000000000000000000001E1E1E3C3C3C3C
          3C3C3C3C3C3C3C3C1E1E1E000000000000000000000000000000000000000000
          0000000000001E1E1E3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C1E1E1E0000
          000000000000000000000000000000000000000000001E1E1E3C3C3C3C3C3C3C
          3C3C3C3C3C3C3C3C3C3C3C1E1E1E000000000000000000000000000000000000
          0000001E1E1E3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C1E1E
          1E0000000000000000000000000000000000001E1E1E3C3C3C3C3C3C3C3C3C3C
          3C3C3C3C3C3C3C3C3C3C3C3C3C3C1E1E1E000000000000000000000000000000
          1E1E1E3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C
          3C1E1E1E0000000000000000000000001E1E1E3C3C3C3C3C3C3C3C3C3C3C3C3C
          3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C1E1E1E000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        Layout = blGlyphRight
        Margin = 0
        NumGlyphs = 2
        Spacing = 0
        TabOrder = 4
        Visible = False
        OnClick = btnPopMenuClick
      end
    end
  end
  object tmrAtualizaMsg: TTimer
    Enabled = False
    Interval = 100
    OnTimer = tmrAtualizaMsgTimer
    Left = 552
    Top = 32
  end
  object ApplicationEvents1: TApplicationEvents
    Left = 424
    Top = 64
  end
  object tmrHabilita: TTimer
    OnTimer = tmrHabilitaTimer
    Left = 344
    Top = 192
  end
  object tmrPix: TTimer
    OnTimer = tmrPixTimer
    Left = 528
    Top = 184
  end
  object mnuCarDigOutras: TPopupMenu
    Left = 164
    Top = 179
  end
end
