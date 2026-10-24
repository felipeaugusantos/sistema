inherited frmDigObservacoes: TfrmDigObservacoes
  Left = 274
  Top = 139
  Width = 423
  Height = 478
  ActiveControl = nil
  BorderIcons = [biSystemMenu]
  Caption = 'Op'#231#245'es'
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 435
    Width = 415
    TabOrder = 6
    inherited btnSair: TBitBtn
      Left = 291
    end
  end
  inherited pnlStatus: TPanel
    Top = 435
    Width = 415
    TabOrder = 5
    inherited pnlNomeForm: TPanel
      Left = 253
      Width = 162
    end
    inherited pnlInfo: TPanel
      Width = 253
    end
  end
  inherited pgcDados: TPageControl
    Top = 386
    Width = 415
    Height = 49
    TabOrder = 4
    Visible = False
  end
  object gpbTransportador: TGroupBox [3]
    Left = 0
    Top = 0
    Width = 415
    Height = 151
    Align = alTop
    Caption = ' TRANSPORTADOR '
    TabOrder = 0
    object Panel1: TPanel
      Left = 2
      Top = 16
      Width = 411
      Height = 133
      Align = alClient
      BevelOuter = bvNone
      Color = 16770261
      TabOrder = 0
      object Label1: TLabel
        Left = 38
        Top = 15
        Width = 36
        Height = 14
        Alignment = taRightJustify
        Caption = 'C'#243'digo:'
      end
      object Label3: TLabel
        Left = 44
        Top = 38
        Width = 30
        Height = 14
        Alignment = taRightJustify
        Caption = 'Nome:'
      end
      object Label4: TLabel
        Left = 25
        Top = 61
        Width = 49
        Height = 14
        Alignment = taRightJustify
        Caption = 'Endere'#231'o:'
      end
      object Label5: TLabel
        Left = 38
        Top = 84
        Width = 36
        Height = 14
        Alignment = taRightJustify
        Caption = 'Cidade:'
      end
      object Label6: TLabel
        Left = 8
        Top = 106
        Width = 66
        Height = 14
        Alignment = taRightJustify
        Caption = 'Tipo de Frete:'
      end
      object ColorLabel1: TColorLabel
        Left = 112
        Top = 104
        Width = 73
        Height = 14
        Caption = '(1) CIF (2) FOB'
        CorDestaque = clRed
      end
      object edtCodTra: TEditFocus
        Tag = 99
        Left = 77
        Top = 8
        Width = 49
        Height = 22
        CharCase = ecUpperCase
        MaxLength = 5
        TabOrder = 0
        OnKeyPress = edtCodTraKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
        Alignment = taLeftJustify
      end
      object edtNomTra: TEditFocus
        Tag = 99
        Left = 77
        Top = 31
        Width = 319
        Height = 22
        CharCase = ecUpperCase
        MaxLength = 50
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
        Alignment = taLeftJustify
      end
      object edtEndere: TEditFocus
        Tag = 99
        Left = 77
        Top = 54
        Width = 319
        Height = 22
        CharCase = ecUpperCase
        MaxLength = 50
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
        Alignment = taLeftJustify
      end
      object edtCidade: TEditFocus
        Tag = 99
        Left = 77
        Top = 77
        Width = 319
        Height = 22
        CharCase = ecUpperCase
        MaxLength = 50
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
        Alignment = taLeftJustify
      end
      object edtTipFre: TEditFocus
        Tag = 99
        Left = 77
        Top = 99
        Width = 28
        Height = 22
        CharCase = ecUpperCase
        MaxLength = 1
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 1
        TipoTexto = ttNumerico
        Alignment = taLeftJustify
      end
    end
  end
  object gpbAtencao: TGroupBox [4]
    Left = 0
    Top = 322
    Width = 415
    Height = 64
    Align = alTop
    Caption = ' ATEN'#199#195'O DE '
    TabOrder = 2
    object pnlFundo: TPanel
      Left = 2
      Top = 16
      Width = 411
      Height = 46
      Align = alClient
      BevelOuter = bvNone
      Color = 16770261
      TabOrder = 0
      object edtAtenca: TEditFocus
        Tag = 99
        Left = 15
        Top = 9
        Width = 380
        Height = 22
        CharCase = ecUpperCase
        MaxLength = 40
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
        Alignment = taLeftJustify
      end
    end
  end
  object gpbObservacao: TGroupBox [5]
    Left = 0
    Top = 151
    Width = 415
    Height = 171
    Align = alTop
    Caption = ' OBSERVA'#199#213'ES '
    TabOrder = 1
    object pnlPedidoVenda: TPanel
      Left = 2
      Top = 16
      Width = 411
      Height = 28
      Align = alTop
      BevelOuter = bvNone
      Color = 16770261
      TabOrder = 0
      object Label2: TLabel
        Left = 100
        Top = 6
        Width = 85
        Height = 14
        Caption = 'Pedido de Venda:'
      end
      object edtPedVen: TEditFocus
        Left = 188
        Top = 1
        Width = 81
        Height = 22
        CharCase = ecUpperCase
        MaxLength = 6
        TabOrder = 0
        OnKeyPress = edtPedVenKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 6
        TipoTexto = ttNumerico
        Alignment = taLeftJustify
      end
    end
    object pnlDados: TPanel
      Left = 2
      Top = 44
      Width = 411
      Height = 125
      Align = alClient
      BevelOuter = bvNone
      Color = 16770261
      TabOrder = 1
      object edtObserv1: TEditFocus
        Tag = 99
        Left = 15
        Top = 7
        Width = 380
        Height = 22
        CharCase = ecUpperCase
        MaxLength = 50
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
        Alignment = taLeftJustify
      end
      object edtObserv2: TEditFocus
        Tag = 99
        Left = 15
        Top = 29
        Width = 380
        Height = 22
        CharCase = ecUpperCase
        MaxLength = 50
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
        Alignment = taLeftJustify
      end
      object edtObserv3: TEditFocus
        Tag = 99
        Left = 15
        Top = 51
        Width = 380
        Height = 22
        CharCase = ecUpperCase
        MaxLength = 50
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
        Alignment = taLeftJustify
      end
      object edtObserv4: TEditFocus
        Tag = 99
        Left = 15
        Top = 73
        Width = 380
        Height = 22
        CharCase = ecUpperCase
        MaxLength = 50
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
        Alignment = taLeftJustify
      end
      object edtObserv5: TEditFocus
        Tag = 99
        Left = 15
        Top = 95
        Width = 380
        Height = 22
        CharCase = ecUpperCase
        MaxLength = 50
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
        Alignment = taLeftJustify
      end
    end
  end
  object gpbFinalPed: TGroupBox [6]
    Left = 0
    Top = 386
    Width = 415
    Height = 49
    Align = alClient
    Caption = ' FINALIZA'#199#195'O DO PEDIDO '
    TabOrder = 3
    object Label7: TLabel
      Left = 11
      Top = 21
      Width = 234
      Height = 14
      Caption = 'Finalizar o pedido e gerar pedidos para as lojas?'
    end
    object ColorLabel2: TColorLabel
      Left = 276
      Top = 20
      Width = 58
      Height = 14
      Caption = '(S)im  (N)'#227'o'
      CorDestaque = clRed
    end
    object edtFinaliza: TEditFocus
      Tag = 99
      Left = 252
      Top = 15
      Width = 21
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 1
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 1
      TipoTexto = ttAlfanumerico
      Alignment = taLeftJustify
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 336
    Top = 0
  end
end
