object frameFutura: TframeFutura
  Left = 0
  Top = 0
  Width = 1030
  Height = 451
  Margins.Left = 0
  Margins.Top = 0
  Margins.Right = 0
  Margins.Bottom = 0
  Color = 16770261
  ParentBackground = False
  ParentColor = False
  TabOrder = 0
  object pnlConteudoFut: TPanel
    AlignWithMargins = True
    Left = 0
    Top = 0
    Width = 1030
    Height = 451
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    Align = alClient
    BevelOuter = bvNone
    ParentBackground = False
    ParentColor = True
    TabOrder = 0
    ExplicitLeft = 2
    ExplicitWidth = 1028
    object FlwPnlTabelasFut: TFlowPanel
      AlignWithMargins = True
      Left = 0
      Top = 266
      Width = 1030
      Height = 185
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alClient
      BevelOuter = bvNone
      ParentBackground = False
      ParentColor = True
      TabOrder = 1
      ExplicitWidth = 1028
      object pnlTitulosTabelasFut: TPanel
        Left = 0
        Top = 0
        Width = 145
        Height = 207
        BevelOuter = bvNone
        ParentBackground = False
        ParentColor = True
        TabOrder = 7
        object lblTitMarBr1Fut: TLabel
          Left = 94
          Top = 23
          Width = 49
          Height = 14
          Alignment = taRightJustify
          Caption = 'Margem:'
          Color = 16770261
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = 14
          Font.Name = 'charter'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object lblTitComTb1Fut: TLabel
          Left = 84
          Top = 44
          Width = 59
          Height = 14
          Alignment = taRightJustify
          Caption = 'Comiss'#227'o:'
          Color = 16770261
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = 14
          Font.Name = 'charter'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object lblTitPreVe1Fut: TLabel
          Left = 71
          Top = 66
          Width = 72
          Height = 14
          Alignment = taRightJustify
          Caption = 'Pre'#231'o Venda:'
          Color = 16770261
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = 14
          Font.Name = 'charter'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object lblCusVenFut: TLabel
          Left = 2
          Top = 88
          Width = 141
          Height = 14
          Alignment = taRightJustify
          Caption = 'Pre'#231'o de Custo da Venda:'
          Color = 16770261
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = 14
          Font.Name = 'charter'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object lblIBSFut: TLabel
          Left = -5
          Top = 133
          Width = 150
          Height = 15
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'IBS:'
          Color = 16770261
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = 14
          Font.Name = 'charter'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object lblISFut: TLabel
          Left = -5
          Top = 154
          Width = 150
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'IS:'
          Color = 16770261
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = 14
          Font.Name = 'charter'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object lblPreCliFut: TLabel
          Left = -4
          Top = 179
          Width = 150
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Pr. Venda com Impostos:'
          Color = 16770261
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = 14
          Font.Name = 'charter'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object lblCBSFut: TLabel
          Left = -5
          Top = 112
          Width = 150
          Height = 15
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'CBS:'
          Color = 16770261
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = 14
          Font.Name = 'charter'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
      end
      object gpbTabPre01Fut: TcxGroupBox
        AlignWithMargins = True
        Left = 148
        Top = 3
        Caption = 'Tabela 1:'
        ParentFont = False
        Style.BorderColor = clBlack
        Style.BorderStyle = ebsUltraFlat
        Style.Font.Charset = ANSI_CHARSET
        Style.Font.Color = clBlack
        Style.Font.Height = 14
        Style.Font.Name = 'Arial'
        Style.Font.Pitch = fpVariable
        Style.Font.Style = []
        Style.LookAndFeel.Kind = lfUltraFlat
        Style.LookAndFeel.NativeStyle = True
        Style.IsFontAssigned = True
        StyleDisabled.LookAndFeel.Kind = lfUltraFlat
        StyleDisabled.LookAndFeel.NativeStyle = True
        TabOrder = 0
        Visible = False
        Height = 197
        Width = 88
        object lblMarBr1: TLabel
          Left = 75
          Top = 20
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
          Transparent = True
          StyleElements = [seClient, seBorder]
        end
        object lblPerComTb1: TLabel
          Left = 75
          Top = 41
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
          Transparent = True
          StyleElements = [seClient, seBorder]
        end
        object lblCbsPer1: TLabel
          Left = 75
          Top = 110
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
          Transparent = True
          StyleElements = [seClient, seBorder]
        end
        object lblIBSPer1: TLabel
          Left = 75
          Top = 131
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
          Transparent = True
          StyleElements = [seClient, seBorder]
        end
        object lblISPer1: TLabel
          Left = 75
          Top = 153
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
          Transparent = True
          StyleElements = [seClient, seBorder]
        end
        object dbeComTb1Fut: TDBEditFocus
          Tag = 99
          Left = 4
          Top = 38
          Width = 70
          Height = 22
          CharCase = ecUpperCase
          Ctl3D = True
          DataField = 'ITE_COMTB1'
          DataSource = dtsCalculadora
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeMarBr1Fut: TDBEditFocus
          Tag = 99
          Left = 4
          Top = 16
          Width = 70
          Height = 22
          CharCase = ecUpperCase
          Ctl3D = True
          DataField = 'ITE_MARBR1'
          DataSource = dtsCalculadora
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbePreVe1Fut: TDBEditFocus
          Tag = 99
          Left = 4
          Top = 60
          Width = 70
          Height = 22
          CharCase = ecUpperCase
          Ctl3D = True
          DataField = 'ITE_PREVE1'
          DataSource = dtsCalculadora
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object edtCusVen1Fut: TEditFocus
          Tag = 50
          Left = 4
          Top = 82
          Width = 70
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          CharCase = ecUpperCase
          Ctl3D = True
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object dbeCBS1Fut: TDBEditFocus
          Tag = 99
          Left = 4
          Top = 104
          Width = 70
          Height = 22
          TabStop = False
          CharCase = ecUpperCase
          Ctl3D = True
          DataField = 'ITE_CBS'
          DataSource = dtsCalculadora
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeIS1Fut: TDBEditFocus
          Tag = 99
          Left = 4
          Top = 148
          Width = 70
          Height = 22
          TabStop = False
          CharCase = ecUpperCase
          Ctl3D = True
          DataField = 'ITE_IS'
          DataSource = dtsCalculadora
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 6
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeIBS1Fut: TDBEditFocus
          Tag = 99
          Left = 4
          Top = 126
          Width = 70
          Height = 22
          TabStop = False
          CharCase = ecUpperCase
          Ctl3D = True
          DataField = 'ITE_IBS'
          DataSource = dtsCalculadora
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 5
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbePreCl1Fut: TDBEditFocus
          Tag = 99
          Left = 4
          Top = 170
          Width = 70
          Height = 22
          CharCase = ecUpperCase
          Ctl3D = True
          DataField = 'ITE_PRECL1'
          DataSource = dtsCalculadora
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 7
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
      end
      object gpbTabPre02Fut: TcxGroupBox
        AlignWithMargins = True
        Left = 242
        Top = 3
        Caption = 'Tabela 2:'
        ParentFont = False
        Style.BorderColor = clBlack
        Style.BorderStyle = ebsUltraFlat
        Style.Font.Charset = ANSI_CHARSET
        Style.Font.Color = clBlack
        Style.Font.Height = 14
        Style.Font.Name = 'Arial'
        Style.Font.Pitch = fpVariable
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 1
        Visible = False
        Height = 197
        Width = 88
        object lblMarBr2: TLabel
          Left = 75
          Top = 20
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
          Transparent = True
          StyleElements = [seClient, seBorder]
        end
        object lblPerComTb2: TLabel
          Left = 75
          Top = 41
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
          Transparent = True
          StyleElements = [seClient, seBorder]
        end
        object lblCbsPer2: TLabel
          Left = 75
          Top = 110
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
          Transparent = True
          StyleElements = [seClient, seBorder]
        end
        object lblIBSPer2: TLabel
          Left = 75
          Top = 131
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
          Transparent = True
          StyleElements = [seClient, seBorder]
        end
        object lblISPer2: TLabel
          Left = 75
          Top = 153
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
          Transparent = True
          StyleElements = [seClient, seBorder]
        end
        object dbeComTb2Fut: TDBEditFocus
          Tag = 99
          Left = 4
          Top = 38
          Width = 70
          Height = 22
          CharCase = ecUpperCase
          Ctl3D = True
          DataField = 'ITE_COMTB2'
          DataSource = dtsCalculadora
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeMarBr2Fut: TDBEditFocus
          Tag = 99
          Left = 4
          Top = 16
          Width = 70
          Height = 22
          CharCase = ecUpperCase
          Ctl3D = True
          DataField = 'ITE_MARBR2'
          DataSource = dtsCalculadora
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbePreVe2Fut: TDBEditFocus
          Tag = 99
          Left = 4
          Top = 60
          Width = 70
          Height = 22
          CharCase = ecUpperCase
          Ctl3D = True
          DataField = 'ITE_PREVE2'
          DataSource = dtsCalculadora
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object edtCusVen2Fut: TEditFocus
          Tag = 50
          Left = 4
          Top = 82
          Width = 70
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          CharCase = ecUpperCase
          Ctl3D = True
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object dbeCBS2Fut: TDBEditFocus
          Tag = 99
          Left = 4
          Top = 104
          Width = 70
          Height = 22
          TabStop = False
          CharCase = ecUpperCase
          Ctl3D = True
          DataField = 'ITE_CBS'
          DataSource = dtsCalculadora
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeIS2Fut: TDBEditFocus
          Tag = 99
          Left = 4
          Top = 148
          Width = 70
          Height = 22
          TabStop = False
          CharCase = ecUpperCase
          Ctl3D = True
          DataField = 'ITE_IS'
          DataSource = dtsCalculadora
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 6
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeIBS2Fut: TDBEditFocus
          Tag = 99
          Left = 4
          Top = 126
          Width = 70
          Height = 22
          TabStop = False
          CharCase = ecUpperCase
          Ctl3D = True
          DataField = 'ITE_IBS'
          DataSource = dtsCalculadora
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 5
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbePreCl2Fut: TDBEditFocus
          Tag = 99
          Left = 4
          Top = 170
          Width = 70
          Height = 22
          CharCase = ecUpperCase
          Ctl3D = True
          DataField = 'ITE_PRECL2'
          DataSource = dtsCalculadora
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 7
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
      end
      object gpbTabPre03Fut: TcxGroupBox
        AlignWithMargins = True
        Left = 336
        Top = 3
        Align = alTop
        BiDiMode = bdLeftToRight
        Caption = 'Tabela 3:'
        ParentBiDiMode = False
        ParentFont = False
        Style.BorderColor = clBlack
        Style.BorderStyle = ebsUltraFlat
        Style.Font.Charset = ANSI_CHARSET
        Style.Font.Color = clBlack
        Style.Font.Height = 14
        Style.Font.Name = 'Arial'
        Style.Font.Pitch = fpVariable
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 2
        Visible = False
        Height = 197
        Width = 88
        object lblMarBr3: TLabel
          Left = 75
          Top = 20
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
          Transparent = True
          StyleElements = [seClient, seBorder]
        end
        object lblPerComTb3: TLabel
          Left = 75
          Top = 41
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
          Transparent = True
          StyleElements = [seClient, seBorder]
        end
        object lblCbsPer3: TLabel
          Left = 75
          Top = 110
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
          Transparent = True
          StyleElements = [seClient, seBorder]
        end
        object lblIBSPer3: TLabel
          Left = 75
          Top = 131
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
          Transparent = True
          StyleElements = [seClient, seBorder]
        end
        object lblISPer3: TLabel
          Left = 75
          Top = 153
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
          Transparent = True
          StyleElements = [seClient, seBorder]
        end
        object dbeComTb3Fut: TDBEditFocus
          Tag = 99
          Left = 4
          Top = 38
          Width = 70
          Height = 22
          CharCase = ecUpperCase
          Ctl3D = True
          DataField = 'ITE_COMTB3'
          DataSource = dtsCalculadora
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeMarBr3Fut: TDBEditFocus
          Tag = 99
          Left = 4
          Top = 16
          Width = 70
          Height = 22
          CharCase = ecUpperCase
          Ctl3D = True
          DataField = 'ITE_MARBR3'
          DataSource = dtsCalculadora
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbePreVe3Fut: TDBEditFocus
          Tag = 99
          Left = 4
          Top = 60
          Width = 70
          Height = 22
          CharCase = ecUpperCase
          Ctl3D = True
          DataField = 'ITE_PREVE3'
          DataSource = dtsCalculadora
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object edtCusVen3Fut: TEditFocus
          Tag = 50
          Left = 4
          Top = 82
          Width = 70
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          CharCase = ecUpperCase
          Ctl3D = True
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object dbeCBS3Fut: TDBEditFocus
          Tag = 99
          Left = 4
          Top = 104
          Width = 70
          Height = 22
          TabStop = False
          CharCase = ecUpperCase
          Ctl3D = True
          DataField = 'ITE_CBS'
          DataSource = dtsCalculadora
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeIS3Fut: TDBEditFocus
          Tag = 99
          Left = 4
          Top = 148
          Width = 70
          Height = 22
          TabStop = False
          CharCase = ecUpperCase
          Ctl3D = True
          DataField = 'ITE_IS'
          DataSource = dtsCalculadora
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 6
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeIBS3Fut: TDBEditFocus
          Tag = 99
          Left = 4
          Top = 126
          Width = 70
          Height = 22
          TabStop = False
          CharCase = ecUpperCase
          Ctl3D = True
          DataField = 'ITE_IBS'
          DataSource = dtsCalculadora
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 5
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbePreCl3Fut: TDBEditFocus
          Tag = 99
          Left = 4
          Top = 170
          Width = 70
          Height = 22
          CharCase = ecUpperCase
          Ctl3D = True
          DataField = 'ITE_PRECL3'
          DataSource = dtsCalculadora
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 7
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
      end
      object gpbTabPre04Fut: TcxGroupBox
        AlignWithMargins = True
        Left = 430
        Top = 3
        Align = alTop
        Caption = 'Tabela 4:'
        ParentFont = False
        Style.BorderColor = clBlack
        Style.BorderStyle = ebsUltraFlat
        Style.Font.Charset = ANSI_CHARSET
        Style.Font.Color = clBlack
        Style.Font.Height = 14
        Style.Font.Name = 'Arial'
        Style.Font.Pitch = fpVariable
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 3
        Visible = False
        Height = 197
        Width = 88
        object lblMarBr4: TLabel
          Left = 75
          Top = 20
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
          Transparent = True
          StyleElements = [seClient, seBorder]
        end
        object lblPerComTb4: TLabel
          Left = 75
          Top = 41
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
          Transparent = True
          StyleElements = [seClient, seBorder]
        end
        object lblCbsPer4: TLabel
          Left = 75
          Top = 110
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
          Transparent = True
          StyleElements = [seClient, seBorder]
        end
        object lblIBSPer4: TLabel
          Left = 75
          Top = 131
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
          Transparent = True
          StyleElements = [seClient, seBorder]
        end
        object lblISPer4: TLabel
          Left = 75
          Top = 153
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
          Transparent = True
          StyleElements = [seClient, seBorder]
        end
        object dbeComTb4Fut: TDBEditFocus
          Tag = 99
          Left = 4
          Top = 38
          Width = 70
          Height = 22
          CharCase = ecUpperCase
          Ctl3D = True
          DataField = 'ITE_COMTB4'
          DataSource = dtsCalculadora
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeMarBr4Fut: TDBEditFocus
          Tag = 99
          Left = 4
          Top = 16
          Width = 70
          Height = 22
          CharCase = ecUpperCase
          Ctl3D = True
          DataField = 'ITE_MARBR4'
          DataSource = dtsCalculadora
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbePreVe4Fut: TDBEditFocus
          Tag = 99
          Left = 4
          Top = 60
          Width = 70
          Height = 22
          CharCase = ecUpperCase
          Ctl3D = True
          DataField = 'ITE_PREVE4'
          DataSource = dtsCalculadora
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object edtCusVen4Fut: TEditFocus
          Tag = 50
          Left = 4
          Top = 82
          Width = 70
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          CharCase = ecUpperCase
          Ctl3D = True
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object dbeCBS4Fut: TDBEditFocus
          Tag = 99
          Left = 4
          Top = 104
          Width = 70
          Height = 22
          TabStop = False
          CharCase = ecUpperCase
          Ctl3D = True
          DataField = 'ITE_CBS'
          DataSource = dtsCalculadora
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeIS4Fut: TDBEditFocus
          Tag = 99
          Left = 4
          Top = 148
          Width = 70
          Height = 22
          TabStop = False
          CharCase = ecUpperCase
          Ctl3D = True
          DataField = 'ITE_IS'
          DataSource = dtsCalculadora
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 6
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeIBS4Fut: TDBEditFocus
          Tag = 99
          Left = 4
          Top = 126
          Width = 70
          Height = 22
          TabStop = False
          CharCase = ecUpperCase
          Ctl3D = True
          DataField = 'ITE_IBS'
          DataSource = dtsCalculadora
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 5
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbePreCl4Fut: TDBEditFocus
          Tag = 99
          Left = 4
          Top = 170
          Width = 70
          Height = 22
          CharCase = ecUpperCase
          Ctl3D = True
          DataField = 'ITE_PRECL4'
          DataSource = dtsCalculadora
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 7
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
      end
      object gpbTabPre05Fut: TcxGroupBox
        AlignWithMargins = True
        Left = 524
        Top = 3
        Align = alTop
        Caption = 'Tabela 5:'
        ParentFont = False
        Style.BorderColor = clBlack
        Style.BorderStyle = ebsUltraFlat
        Style.Font.Charset = ANSI_CHARSET
        Style.Font.Color = clBlack
        Style.Font.Height = 14
        Style.Font.Name = 'Arial'
        Style.Font.Pitch = fpVariable
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 4
        Visible = False
        Height = 197
        Width = 88
        object lblMarBr5: TLabel
          Left = 75
          Top = 20
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
          Transparent = True
          StyleElements = [seClient, seBorder]
        end
        object lblPerComTb5: TLabel
          Left = 75
          Top = 41
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
          Transparent = True
          StyleElements = [seClient, seBorder]
        end
        object lblCbsPer5: TLabel
          Left = 75
          Top = 110
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
          Transparent = True
          StyleElements = [seClient, seBorder]
        end
        object lblIBSPer5: TLabel
          Left = 75
          Top = 131
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
          Transparent = True
          StyleElements = [seClient, seBorder]
        end
        object lblISPer5: TLabel
          Left = 75
          Top = 153
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
          Transparent = True
          StyleElements = [seClient, seBorder]
        end
        object dbeComTb5Fut: TDBEditFocus
          Tag = 99
          Left = 4
          Top = 38
          Width = 70
          Height = 22
          CharCase = ecUpperCase
          Ctl3D = True
          DataField = 'ITE_COMTB5'
          DataSource = dtsCalculadora
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeMarBr5Fut: TDBEditFocus
          Tag = 99
          Left = 4
          Top = 16
          Width = 70
          Height = 22
          CharCase = ecUpperCase
          Ctl3D = True
          DataField = 'ITE_MARBR5'
          DataSource = dtsCalculadora
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbePreVe5Fut: TDBEditFocus
          Tag = 99
          Left = 4
          Top = 60
          Width = 70
          Height = 22
          CharCase = ecUpperCase
          Ctl3D = True
          DataField = 'ITE_PREVE5'
          DataSource = dtsCalculadora
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object edtCusVen5Fut: TEditFocus
          Tag = 50
          Left = 4
          Top = 82
          Width = 70
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          CharCase = ecUpperCase
          Ctl3D = True
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object dbeCBS5Fut: TDBEditFocus
          Tag = 99
          Left = 4
          Top = 104
          Width = 70
          Height = 22
          TabStop = False
          CharCase = ecUpperCase
          Ctl3D = True
          DataField = 'ITE_CBS'
          DataSource = dtsCalculadora
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeIS5Fut: TDBEditFocus
          Tag = 99
          Left = 4
          Top = 148
          Width = 70
          Height = 22
          TabStop = False
          CharCase = ecUpperCase
          Ctl3D = True
          DataField = 'ITE_IS'
          DataSource = dtsCalculadora
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 6
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeIBS5Fut: TDBEditFocus
          Tag = 99
          Left = 4
          Top = 126
          Width = 70
          Height = 22
          TabStop = False
          CharCase = ecUpperCase
          Ctl3D = True
          DataField = 'ITE_IBS'
          DataSource = dtsCalculadora
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 5
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbePreCl5Fut: TDBEditFocus
          Tag = 99
          Left = 4
          Top = 170
          Width = 70
          Height = 22
          CharCase = ecUpperCase
          Ctl3D = True
          DataField = 'ITE_PRECL5'
          DataSource = dtsCalculadora
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 7
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
      end
      object gpbTabPre06Fut: TcxGroupBox
        AlignWithMargins = True
        Left = 618
        Top = 3
        Align = alTop
        Caption = 'Tabela 6:'
        ParentFont = False
        Style.BorderColor = clBlack
        Style.BorderStyle = ebsUltraFlat
        Style.Font.Charset = ANSI_CHARSET
        Style.Font.Color = clBlack
        Style.Font.Height = 14
        Style.Font.Name = 'Arial'
        Style.Font.Pitch = fpVariable
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 5
        Visible = False
        Height = 197
        Width = 88
        object lblMarBr6: TLabel
          Left = 75
          Top = 20
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
          Transparent = True
          StyleElements = [seClient, seBorder]
        end
        object lblPerComTb6: TLabel
          Left = 75
          Top = 41
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
          Transparent = True
          StyleElements = [seClient, seBorder]
        end
        object lblCbsPer6: TLabel
          Left = 75
          Top = 110
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
          Transparent = True
          StyleElements = [seClient, seBorder]
        end
        object lblIBSPer6: TLabel
          Left = 75
          Top = 131
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
          Transparent = True
          StyleElements = [seClient, seBorder]
        end
        object lblISPer6: TLabel
          Left = 75
          Top = 153
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
          Transparent = True
          StyleElements = [seClient, seBorder]
        end
        object dbeComTb6Fut: TDBEditFocus
          Tag = 99
          Left = 4
          Top = 38
          Width = 70
          Height = 22
          CharCase = ecUpperCase
          Ctl3D = True
          DataField = 'ITE_COMTB6'
          DataSource = dtsCalculadora
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeMarBr6Fut: TDBEditFocus
          Tag = 99
          Left = 4
          Top = 16
          Width = 70
          Height = 22
          CharCase = ecUpperCase
          Ctl3D = True
          DataField = 'ITE_MARBR6'
          DataSource = dtsCalculadora
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbePreVe6Fut: TDBEditFocus
          Tag = 99
          Left = 4
          Top = 60
          Width = 70
          Height = 22
          CharCase = ecUpperCase
          Ctl3D = True
          DataField = 'ITE_PREVE6'
          DataSource = dtsCalculadora
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object edtCusVen6Fut: TEditFocus
          Tag = 50
          Left = 4
          Top = 82
          Width = 70
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          CharCase = ecUpperCase
          Ctl3D = True
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object dbeCBS6Fut: TDBEditFocus
          Tag = 99
          Left = 4
          Top = 104
          Width = 70
          Height = 22
          TabStop = False
          CharCase = ecUpperCase
          Ctl3D = True
          DataField = 'ITE_CBS'
          DataSource = dtsCalculadora
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeIS6Fut: TDBEditFocus
          Tag = 99
          Left = 4
          Top = 148
          Width = 70
          Height = 22
          TabStop = False
          CharCase = ecUpperCase
          Ctl3D = True
          DataField = 'ITE_IS'
          DataSource = dtsCalculadora
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 6
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeIBS6Fut: TDBEditFocus
          Tag = 99
          Left = 4
          Top = 126
          Width = 70
          Height = 22
          TabStop = False
          CharCase = ecUpperCase
          Ctl3D = True
          DataField = 'ITE_IBS'
          DataSource = dtsCalculadora
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 5
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbePreCl6Fut: TDBEditFocus
          Tag = 99
          Left = 4
          Top = 170
          Width = 70
          Height = 22
          CharCase = ecUpperCase
          Ctl3D = True
          DataField = 'ITE_PRECL6'
          DataSource = dtsCalculadora
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 7
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
      end
      object gpbTabPre07Fut: TcxGroupBox
        AlignWithMargins = True
        Left = 712
        Top = 3
        Align = alTop
        Caption = 'Tabela 7:'
        ParentFont = False
        Style.BorderColor = clBlack
        Style.BorderStyle = ebsUltraFlat
        Style.Font.Charset = ANSI_CHARSET
        Style.Font.Color = clBlack
        Style.Font.Height = 14
        Style.Font.Name = 'Arial'
        Style.Font.Pitch = fpVariable
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 6
        Visible = False
        Height = 197
        Width = 88
        object lblMarBr7: TLabel
          Left = 75
          Top = 20
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
          Transparent = True
          StyleElements = [seClient, seBorder]
        end
        object lblPerComTb7: TLabel
          Left = 75
          Top = 41
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
          Transparent = True
          StyleElements = [seClient, seBorder]
        end
        object lblCbsPer7: TLabel
          Left = 75
          Top = 110
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
          Transparent = True
          StyleElements = [seClient, seBorder]
        end
        object lblIBSPer7: TLabel
          Left = 75
          Top = 131
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
          Transparent = True
          StyleElements = [seClient, seBorder]
        end
        object lblISPer7: TLabel
          Left = 75
          Top = 153
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
          Transparent = True
          StyleElements = [seClient, seBorder]
        end
        object dbeComTb7Fut: TDBEditFocus
          Tag = 99
          Left = 4
          Top = 38
          Width = 70
          Height = 22
          CharCase = ecUpperCase
          Ctl3D = True
          DataField = 'ITE_COMTB7'
          DataSource = dtsCalculadora
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeMarBr7Fut: TDBEditFocus
          Tag = 99
          Left = 4
          Top = 16
          Width = 70
          Height = 22
          CharCase = ecUpperCase
          Ctl3D = True
          DataField = 'ITE_MARBR7'
          DataSource = dtsCalculadora
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbePreVe7Fut: TDBEditFocus
          Tag = 99
          Left = 4
          Top = 60
          Width = 70
          Height = 22
          CharCase = ecUpperCase
          Ctl3D = True
          DataField = 'ITE_PREVE7'
          DataSource = dtsCalculadora
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object edtCusVen7Fut: TEditFocus
          Tag = 50
          Left = 4
          Top = 82
          Width = 70
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          CharCase = ecUpperCase
          Ctl3D = True
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object dbeCBS7Fut: TDBEditFocus
          Tag = 99
          Left = 4
          Top = 104
          Width = 70
          Height = 22
          TabStop = False
          CharCase = ecUpperCase
          Ctl3D = True
          DataField = 'ITE_CBS'
          DataSource = dtsCalculadora
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeIS7Fut: TDBEditFocus
          Tag = 99
          Left = 4
          Top = 148
          Width = 70
          Height = 22
          TabStop = False
          CharCase = ecUpperCase
          Ctl3D = True
          DataField = 'ITE_IS'
          DataSource = dtsCalculadora
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 6
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeIBS7Fut: TDBEditFocus
          Tag = 99
          Left = 4
          Top = 126
          Width = 70
          Height = 22
          TabStop = False
          CharCase = ecUpperCase
          Ctl3D = True
          DataField = 'ITE_IBS'
          DataSource = dtsCalculadora
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 5
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbePreCl7Fut: TDBEditFocus
          Tag = 99
          Left = 4
          Top = 170
          Width = 70
          Height = 22
          CharCase = ecUpperCase
          Ctl3D = True
          DataField = 'ITE_PRECL7'
          DataSource = dtsCalculadora
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 7
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
      end
      object pnlEspacadorTabelasFut: TPanel
        Left = 803
        Top = 0
        Width = 185
        Height = 41
        BevelOuter = bvNone
        ParentBackground = False
        ParentColor = True
        TabOrder = 8
      end
    end
    object pnlPrecosContainerFut: TPanel
      Left = 0
      Top = 0
      Width = 1030
      Height = 266
      Align = alTop
      BevelOuter = bvNone
      ParentBackground = False
      ParentColor = True
      TabOrder = 0
      ExplicitWidth = 1028
      object lblPreComFut: TLabel
        Left = 36
        Top = 6
        Width = 82
        Height = 14
        Alignment = taRightJustify
        Caption = 'Pre'#231'o Compra:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = 14
        Font.Name = 'charter'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblDesF01Fut: TLabel
        Left = 39
        Top = 28
        Width = 79
        Height = 13
        Alignment = taRightJustify
        Caption = 'Desconto 01 (-):'
      end
      object lblDesF01PerFut: TLabel
        Left = 212
        Top = 28
        Width = 11
        Height = 13
        Alignment = taRightJustify
        Caption = '%'
      end
      object lblDesF02Fut: TLabel
        Left = 87
        Top = 50
        Width = 31
        Height = 13
        Alignment = taRightJustify
        Caption = '02 (-):'
      end
      object lblDesF02PerFut: TLabel
        Left = 212
        Top = 50
        Width = 11
        Height = 13
        Alignment = taRightJustify
        Caption = '%'
      end
      object lblDesF03Fut: TLabel
        Left = 87
        Top = 72
        Width = 31
        Height = 13
        Alignment = taRightJustify
        Caption = '03 (-):'
      end
      object lblDesF03PerFut: TLabel
        Left = 212
        Top = 72
        Width = 11
        Height = 13
        Alignment = taRightJustify
        Caption = '%'
      end
      object lblDesF04Fut: TLabel
        Left = 87
        Top = 94
        Width = 31
        Height = 13
        Alignment = taRightJustify
        Caption = '04 (-):'
      end
      object lblDesF04PerFut: TLabel
        Left = 212
        Top = 94
        Width = 11
        Height = 13
        Alignment = taRightJustify
        Caption = '%'
      end
      object lblDesF05Fut: TLabel
        Left = 87
        Top = 116
        Width = 31
        Height = 13
        Alignment = taRightJustify
        Caption = '05 (-):'
      end
      object lblDesF05PerFut: TLabel
        Left = 212
        Top = 116
        Width = 11
        Height = 13
        Alignment = taRightJustify
        Caption = '%'
      end
      object lblDesF06Fut: TLabel
        Left = 87
        Top = 138
        Width = 31
        Height = 13
        Alignment = taRightJustify
        Caption = '06 (-):'
      end
      object lblIcmEntFut: TLabel
        Left = 309
        Top = 6
        Width = 85
        Height = 13
        Alignment = taRightJustify
        Caption = 'ICMS Entrada (-):'
      end
      object lblIcmEntPerFut: TLabel
        Left = 490
        Top = 6
        Width = 11
        Height = 13
        Alignment = taRightJustify
        Caption = '%'
      end
      object lblIpiEntFut: TLabel
        Left = 316
        Top = 50
        Width = 78
        Height = 13
        Alignment = taRightJustify
        Caption = 'IPI Entrada (+):'
      end
      object lblIpiEntPerFut: TLabel
        Left = 490
        Top = 50
        Width = 11
        Height = 13
        Alignment = taRightJustify
        Caption = '%'
      end
      object lblFreEntFut: TLabel
        Left = 345
        Top = 72
        Width = 49
        Height = 13
        Alignment = taRightJustify
        Caption = 'Frete (+):'
      end
      object lblFreEntPerFut: TLabel
        Left = 490
        Top = 72
        Width = 11
        Height = 13
        Alignment = taRightJustify
        Caption = '%'
      end
      object lblAcrFinFut: TLabel
        Left = 290
        Top = 116
        Width = 104
        Height = 13
        Alignment = taRightJustify
        Caption = 'Acr'#233'scimo Finan. (+):'
      end
      object lblAcrFinPerFut: TLabel
        Left = 490
        Top = 116
        Width = 11
        Height = 13
        Alignment = taRightJustify
        Caption = '%'
      end
      object lblSubstiFut: TLabel
        Left = 300
        Top = 138
        Width = 94
        Height = 13
        Alignment = taRightJustify
        Caption = 'Sub. Tribut'#225'ria (+):'
      end
      object lblSubstiPerFut: TLabel
        Left = 490
        Top = 138
        Width = 11
        Height = 13
        Alignment = taRightJustify
        Caption = '%'
      end
      object lblPreCusFut: TLabel
        Left = 306
        Top = 182
        Width = 88
        Height = 14
        Alignment = taRightJustify
        Caption = 'Pre'#231'o de Custo:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = 14
        Font.Name = 'charter'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblValFreFut: TLabel
        Left = 318
        Top = 94
        Width = 76
        Height = 13
        Alignment = taRightJustify
        Caption = 'Valor Frete (+):'
      end
      object lblDesAdiFut: TLabel
        Left = 226
        Top = 160
        Width = 168
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Descontos Adicionais (Boleto) (-):'
      end
      object lblDesAdiPerFut: TLabel
        Left = 490
        Top = 160
        Width = 11
        Height = 13
        Alignment = taRightJustify
        Caption = '%'
      end
      object lblDesF06PerFut: TLabel
        Left = 212
        Top = 138
        Width = 11
        Height = 13
        Alignment = taRightJustify
        Caption = '%'
      end
      object lblComLiqFut: TLabel
        Left = 6
        Top = 160
        Width = 112
        Height = 14
        Alignment = taRightJustify
        Caption = 'Pre'#231'o Compra L'#237'qu.:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblTabPreFut: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 251
        Width = 1024
        Height = 15
        Align = alBottom
        AutoSize = False
        Caption = 'TABELAS DE PRE'#199'O'
        Color = 16770261
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = True
        ExplicitLeft = 79
        ExplicitTop = 232
        ExplicitWidth = 996
      end
      object dbePreComFut: TDBEditFocus
        Tag = 99
        Left = 120
        Top = 2
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_PRECOM'
        DataSource = dtsCalculadora
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeDesF01Fut: TDBEditFocus
        Tag = 99
        Left = 120
        Top = 24
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_DESF01'
        DataSource = dtsCalculadora
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeDesF02Fut: TDBEditFocus
        Tag = 99
        Left = 120
        Top = 46
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_DESF02'
        DataSource = dtsCalculadora
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeDesF03Fut: TDBEditFocus
        Tag = 99
        Left = 120
        Top = 68
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_DESF03'
        DataSource = dtsCalculadora
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeDesF04Fut: TDBEditFocus
        Tag = 99
        Left = 120
        Top = 90
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_DESF04'
        DataSource = dtsCalculadora
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeDesF05Fut: TDBEditFocus
        Tag = 99
        Left = 120
        Top = 112
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_DESF05'
        DataSource = dtsCalculadora
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 5
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeDesF06Fut: TDBEditFocus
        Tag = 99
        Left = 120
        Top = 134
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_DESF06'
        DataSource = dtsCalculadora
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 6
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeIcmEntFut: TDBEditFocus
        Tag = 99
        Left = 396
        Top = 2
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_ICMENT'
        DataSource = dtsCalculadora
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 19
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeIpiEntFut: TDBEditFocus
        Tag = 99
        Left = 396
        Top = 46
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_IPIENT'
        DataSource = dtsCalculadora
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 8
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeFreEntFut: TDBEditFocus
        Tag = 99
        Left = 396
        Top = 68
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_FREENT'
        DataSource = dtsCalculadora
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 9
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeAcrFinFut: TDBEditFocus
        Tag = 99
        Left = 396
        Top = 112
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_ACRFIN'
        DataSource = dtsCalculadora
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 11
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeSubstiFut: TDBEditFocus
        Tag = 99
        Left = 396
        Top = 134
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_SUBSTI'
        DataSource = dtsCalculadora
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 12
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbePreCusFut: TDBEditFocus
        Tag = 99
        Left = 396
        Top = 178
        Width = 92
        Height = 21
        TabStop = False
        CharCase = ecUpperCase
        DataField = 'ITE_PRECUS'
        DataSource = dtsCalculadora
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 14
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeValFreFut: TDBEditFocus
        Tag = 99
        Left = 396
        Top = 90
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_VALFRE'
        DataSource = dtsCalculadora
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 10
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeDesAdbFut: TDBEditFocus
        Tag = 99
        Left = 396
        Top = 156
        Width = 92
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_DESADB'
        DataSource = dtsCalculadora
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 13
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object edtComLiqFut: TEditFocus
        Left = 120
        Top = 156
        Width = 92
        Height = 21
        TabStop = False
        Alignment = taRightJustify
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 15
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object chkPreDolFut: TDBCheckBox
        Left = 215
        Top = 5
        Width = 70
        Height = 17
        TabStop = False
        Caption = 'Em d'#243'lar'
        Ctl3D = True
        DataField = 'ITE_PREDOL'
        DataSource = dtsCalculadora
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 16
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object pnlCamposSuframaFut: TPanel
        Left = 509
        Top = 2
        Width = 240
        Height = 114
        BevelOuter = bvNone
        ParentBackground = False
        ParentColor = True
        TabOrder = 17
        Visible = False
        object lblTCIFFut: TLabel
          Left = 80
          Top = 4
          Width = 46
          Height = 13
          Alignment = taRightJustify
          Caption = 'TCIF (+):'
        end
        object lblTSFut: TLabel
          Left = 91
          Top = 26
          Width = 35
          Height = 13
          Alignment = taRightJustify
          Caption = 'TS (+):'
        end
        object lblDePiCoFut: TLabel
          Left = 1
          Top = 48
          Width = 125
          Height = 13
          Alignment = taRightJustify
          Caption = 'Desconto PIS/COFINS (-):'
        end
        object lblDeICMSFut: TLabel
          Left = 34
          Top = 70
          Width = 92
          Height = 13
          Alignment = taRightJustify
          Caption = 'Desconto ICMS (-):'
        end
        object lblFatRegFut: TLabel
          Left = 33
          Top = 92
          Width = 93
          Height = 13
          Alignment = taRightJustify
          Caption = 'Fator Regional (+):'
        end
        object lblTCIFPerFut: TLabel
          Left = 227
          Top = 4
          Width = 11
          Height = 13
          Alignment = taRightJustify
          Caption = '%'
        end
        object lblTSPerFut: TLabel
          Left = 227
          Top = 26
          Width = 11
          Height = 13
          Alignment = taRightJustify
          Caption = '%'
        end
        object lblDePiCoPerFut: TLabel
          Left = 227
          Top = 48
          Width = 11
          Height = 13
          Alignment = taRightJustify
          Caption = '%'
        end
        object lblDeICMSPerFut: TLabel
          Left = 227
          Top = 72
          Width = 11
          Height = 13
          Alignment = taRightJustify
          Caption = '%'
        end
        object lblFatRegPerFut: TLabel
          Left = 227
          Top = 94
          Width = 11
          Height = 13
          Alignment = taRightJustify
          Caption = '%'
        end
        object dbeTCIFFut: TDBEditFocus
          Tag = 99
          Left = 132
          Top = 0
          Width = 92
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_TCIFCU'
          DataSource = dtsCalculadora
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
        object dbeTSFut: TDBEditFocus
          Tag = 99
          Left = 132
          Top = 22
          Width = 92
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_TSCUST'
          DataSource = dtsCalculadora
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
        object dbeDePiCoFut: TDBEditFocus
          Tag = 99
          Left = 132
          Top = 44
          Width = 92
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_DEPICO'
          DataSource = dtsCalculadora
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
        object dbeDeICMSFut: TDBEditFocus
          Tag = 99
          Left = 132
          Top = 66
          Width = 92
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_DEICMS'
          DataSource = dtsCalculadora
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
        object dbeFatRegFut: TDBEditFocus
          Tag = 99
          Left = 132
          Top = 88
          Width = 92
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_FATREG'
          DataSource = dtsCalculadora
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
      end
      object pnlCusRealFut: TPanel
        Left = 764
        Top = 2
        Width = 245
        Height = 115
        BevelOuter = bvNone
        ParentBackground = False
        ParentColor = True
        TabOrder = 18
        object lblOutValFut: TLabel
          Left = 33
          Top = 3
          Width = 94
          Height = 13
          Alignment = taRightJustify
          Caption = 'Outros Valores (+):'
        end
        object lblIcmSaiFut: TLabel
          Left = 50
          Top = 25
          Width = 77
          Height = 13
          Alignment = taRightJustify
          Caption = 'ICMS Sa'#237'da (+):'
        end
        object lblDesOpeFut: TLabel
          Left = 11
          Top = 69
          Width = 116
          Height = 13
          Alignment = taRightJustify
          Caption = 'Desp. Operacionais (+):'
        end
        object lblCusReaTitFut: TLabel
          Left = 13
          Top = 91
          Width = 114
          Height = 14
          Alignment = taRightJustify
          Caption = 'Pre'#231'o de Custo Real:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblIcmSaiPerFut: TLabel
          Left = 222
          Top = 26
          Width = 11
          Height = 13
          Alignment = taRightJustify
          Caption = '%'
        end
        object lblDesOpePerFut: TLabel
          Left = 222
          Top = 70
          Width = 11
          Height = 13
          Alignment = taRightJustify
          Caption = '%'
        end
        object dbeOutValFut: TDBEditFocus
          Tag = 99
          Left = 129
          Top = 0
          Width = 92
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_OUTVAL'
          DataSource = dtsCalculadora
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeIcmSaiFut: TDBEditFocus
          Tag = 99
          Left = 129
          Top = 22
          Width = 92
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_ICMSAI'
          DataSource = dtsCalculadora
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeDesOpeFut: TDBEditFocus
          Tag = 99
          Left = 129
          Top = 66
          Width = 92
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_DESOPE'
          DataSource = dtsCalculadora
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object edtCusReaFut: TEditFocus
          Left = 129
          Top = 88
          Width = 92
          Height = 21
          TabStop = False
          Alignment = taRightJustify
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 4
          NormalColor = clWindow
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
  object dtsCalculadora: TDataSource
    Left = 8
    Top = 8
  end
end
