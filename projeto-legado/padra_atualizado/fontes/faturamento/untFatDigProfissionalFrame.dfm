object fraFatDigProfissionalFrame: TfraFatDigProfissionalFrame
  Left = 0
  Top = 0
  Width = 557
  Height = 69
  VertScrollBar.Range = 45
  VertScrollBar.Visible = False
  Color = 16770261
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  ParentBackground = False
  ParentColor = False
  ParentFont = False
  TabOrder = 0
  object pnlFundo: TPanel
    Left = 0
    Top = 0
    Width = 557
    Height = 69
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    DesignSize = (
      557
      69)
    object lblNomPro: TLabel
      Left = 48
      Top = 10
      Width = 58
      Height = 13
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = 'Profissional:'
    end
    object lblCliDiv: TLabel
      Left = 0
      Top = 55
      Width = 557
      Height = 14
      Align = alBottom
      Alignment = taCenter
      Caption = 
        'N'#227'o h'#225' profissionais vinculados ao cliente. Cadastre-os para efe' +
        'tuar a venda.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clMaroon
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      Visible = False
      ExplicitWidth = 377
    end
    object lblComissao: TLabel
      Left = 57
      Top = 29
      Width = 49
      Height = 13
      Alignment = taRightJustify
      Caption = 'Comiss'#227'o:'
    end
    object edtCodPro: TEditFocus
      Tag = 99
      Left = 108
      Top = 4
      Width = 70
      Height = 21
      Alignment = taLeftJustify
      Anchors = [akTop, akRight]
      MaxLength = 8
      TabOrder = 0
      OnChange = edtCodProChange
      OnKeyPress = edtCodProKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtDesPro: TEditFocus
      Left = 179
      Top = 4
      Width = 305
      Height = 21
      TabStop = False
      Alignment = taLeftJustify
      Anchors = [akTop, akRight]
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
    object edtComissao: TEditFocus
      Tag = 99
      Left = 108
      Top = 26
      Width = 70
      Height = 22
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 2
      OnExit = edtComissaoExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
  end
end
