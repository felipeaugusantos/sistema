object fraClienteContaOrdemFrame: TfraClienteContaOrdemFrame
  Left = 0
  Top = 0
  Width = 562
  Height = 58
  TabOrder = 0
  object pnlFundo: TPanel
    Left = 0
    Top = 0
    Width = 562
    Height = 58
    Align = alClient
    TabOrder = 0
    object pnlClienteContaOrdem: TGroupBox
      AlignWithMargins = True
      Left = 3
      Top = 1
      Width = 556
      Height = 51
      Margins.Left = 2
      Margins.Top = 0
      Margins.Right = 2
      Margins.Bottom = 0
      Align = alTop
      Caption = 'Cliente Conta e Ordem:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object lblCliFor: TLabel
        Left = 27
        Top = 24
        Width = 37
        Height = 13
        Alignment = taRightJustify
        Caption = 'Cliente:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object edtCodCli: TEditFocus
        Tag = 99
        Left = 70
        Top = 21
        Width = 65
        Height = 21
        Hint = 'Pressione INSERT para inserir um novo cliente'
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 8
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnExit = edtCodCliExit
        OnKeyPress = edtCodCliKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 8
        TipoTexto = ttNumerico
      end
      object edtNomCli: TEditFocus
        Left = 136
        Top = 21
        Width = 356
        Height = 21
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
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
  end
end
