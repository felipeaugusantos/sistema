inherited frmAlterarPaginaRevista: TfrmAlterarPaginaRevista
  Width = 552
  Height = 284
  Caption = 'Alterar a P'#225'gina da Revista'
  Position = poScreenCenter
  ExplicitWidth = 552
  ExplicitHeight = 284
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 211
    Width = 546
    ExplicitTop = 211
    ExplicitWidth = 546
    DesignSize = (
      546
      28)
    inherited FlwBotoes: TFlowPanel
      Width = 542
      TabOrder = 2
      ExplicitWidth = 542
    end
    inherited btnSair: TBitBtnLocked
      Left = 463
      ExplicitLeft = 463
    end
    object btnConfirmar: TBitBtnLocked
      Left = 3
      Top = 3
      Width = 110
      Height = 22
      Caption = '[ F10 ] Confirmar'
      TabOrder = 0
      OnClick = btnConfirmarClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 239
    Width = 546
    ExplicitTop = 239
    ExplicitWidth = 546
    inherited pnlNomeForm: TPanel
      Left = 375
      ExplicitLeft = 375
    end
    inherited pnlInfo: TPanel
      Width = 375
      ExplicitWidth = 375
    end
  end
  object Panel1: TPanel [2]
    Left = 0
    Top = 0
    Width = 546
    Height = 211
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object grbProduto: TGroupBox
      Left = 1
      Top = 1
      Width = 544
      Height = 145
      Align = alTop
      Caption = 'Produto'
      TabOrder = 0
      object Label3: TLabel
        Left = 33
        Top = 56
        Width = 56
        Height = 14
        Alignment = taRightJustify
        Caption = 'Refer'#234'ncia:'
      end
      object Label4: TLabel
        Left = 449
        Top = 56
        Width = 42
        Height = 14
        Alignment = taRightJustify
        Caption = 'Unidade:'
      end
      object Label6: TLabel
        Left = 56
        Top = 79
        Width = 33
        Height = 14
        Alignment = taRightJustify
        Caption = 'Marca:'
      end
      object lblFornec: TLabel
        Left = 30
        Top = 102
        Width = 59
        Height = 14
        Alignment = taRightJustify
        Caption = 'Fornecedor:'
      end
      object Label2: TLabel
        Left = 49
        Top = 33
        Width = 40
        Height = 14
        Alignment = taRightJustify
        Caption = 'Produto:'
      end
      object edtRefere: TEditFocus
        Tag = 99
        Left = 91
        Top = 52
        Width = 351
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 1
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodUni: TEditFocus
        Tag = 99
        Left = 494
        Top = 52
        Width = 36
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 2
        TabOrder = 2
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodMar: TEditFocus
        Tag = 99
        Left = 91
        Top = 75
        Width = 32
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        TabOrder = 3
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtDesMar: TEditFocus
        Left = 124
        Top = 75
        Width = 145
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
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
      object edtCodFor: TEditFocus
        Tag = 99
        Left = 91
        Top = 98
        Width = 69
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 8
        TabOrder = 5
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 8
        TipoTexto = ttNumerico
      end
      object edtNomFor: TEditFocus
        Left = 161
        Top = 98
        Width = 369
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
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
      object edtDesIte: TEditFocus
        Tag = 99
        Left = 161
        Top = 29
        Width = 369
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 7
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodIte: TEditFocus
        Tag = 99
        Left = 91
        Top = 29
        Width = 69
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 5
        TabOrder = 0
        OnKeyPress = edtCodIteKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttAlfanumerico
      end
    end
    object grbRevista: TGroupBox
      Left = 1
      Top = 146
      Width = 544
      Height = 64
      Align = alClient
      Caption = 'Revista'
      TabOrder = 1
      object Label1: TLabel
        Left = 15
        Top = 31
        Width = 74
        Height = 14
        Caption = 'P'#225'gina Revista:'
      end
      object edtRevista: TEditFocus
        Tag = 99
        Left = 91
        Top = 26
        Width = 121
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 20
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 20
        TipoTexto = ttInteiro
      end
    end
  end
end
