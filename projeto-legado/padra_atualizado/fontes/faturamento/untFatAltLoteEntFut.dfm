inherited frmFatAltLoteEntFut: TfrmFatAltLoteEntFut
  Width = 641
  Height = 334
  Caption = 'Altera'#231#227'o do <DESLOT> da Entrega Futura'
  OnDestroy = FormDestroy
  ExplicitWidth = 641
  ExplicitHeight = 334
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 263
    Width = 635
    ExplicitTop = 263
    ExplicitWidth = 635
    inherited FlwBotoes: TFlowPanel
      Width = 554
      ExplicitWidth = 554
      inherited btnConfirma: TBitBtnLocked
        Align = alLeft
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 556
      Top = 2
      Align = alRight
      ExplicitLeft = 556
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 289
    Width = 635
    ExplicitTop = 289
    ExplicitWidth = 635
    inherited pnlNomeForm: TPanel
      Left = 464
      ExplicitLeft = 464
    end
    inherited pnlInfo: TPanel
      Width = 464
      ExplicitWidth = 464
    end
  end
  object pnlMotivo: TPanel [2]
    Left = 0
    Top = 0
    Width = 635
    Height = 263
    Align = alClient
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 2
    object lbl1: TLabel
      Left = 20
      Top = 3
      Width = 37
      Height = 14
      Caption = 'Produto'
    end
    object Label1: TLabel
      Left = 20
      Top = 41
      Width = 53
      Height = 14
      Caption = 'Refer'#234'ncia'
    end
    object Label2: TLabel
      Left = 564
      Top = 41
      Width = 39
      Height = 14
      Caption = 'Unidade'
    end
    object lbl2: TLabel
      Left = 20
      Top = 97
      Width = 55
      Height = 14
      Caption = 'Quantidade'
    end
    object lbl3: TLabel
      Left = 20
      Top = 135
      Width = 42
      Height = 14
      Caption = 'Situa'#231#227'o'
    end
    object lbl4: TLabel
      Left = 484
      Top = 135
      Width = 82
      Height = 14
      Caption = 'Data de Previs'#227'o'
    end
    object bvl1: TBevel
      Left = 20
      Top = 80
      Width = 597
      Height = 12
      Shape = bsBottomLine
    end
    object bvl2: TBevel
      Left = 20
      Top = 172
      Width = 597
      Height = 12
      Shape = bsBottomLine
    end
    object lblAtual: TLabel
      Left = 20
      Top = 191
      Width = 48
      Height = 14
      Caption = 'Lote Atual'
    end
    object lblNovo: TLabel
      Left = 326
      Top = 190
      Width = 49
      Height = 14
      Caption = 'Novo Lote'
    end
    object bvl3: TBevel
      Left = 20
      Top = 229
      Width = 597
      Height = 12
      Shape = bsBottomLine
    end
    object edtProduto: TEditFocus
      Left = 20
      Top = 17
      Width = 597
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 0
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtRefere: TEditFocus
      Left = 20
      Top = 56
      Width = 538
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object edtUnidad: TEditFocus
      Left = 564
      Top = 56
      Width = 53
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 2
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtQuanti: TEditFocus
      Left = 20
      Top = 111
      Width = 125
      Height = 22
      Alignment = taRightJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtSituac: TEditFocus
      Left = 20
      Top = 150
      Width = 444
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDtaPrev: TEditFocus
      Left = 484
      Top = 150
      Width = 133
      Height = 22
      Alignment = taRightJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtLotAtu: TEditFocus
      Left = 20
      Top = 205
      Width = 291
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 6
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtLotNov: TEditFocus
      Tag = 99
      Left = 326
      Top = 205
      Width = 291
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 7
      OnKeyPress = edtLotNovKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 640
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 592
    Top = 8
  end
end
