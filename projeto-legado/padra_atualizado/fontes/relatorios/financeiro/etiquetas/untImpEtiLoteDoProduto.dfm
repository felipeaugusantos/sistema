inherited frmImpEtiLoteDoProduto: TfrmImpEtiLoteDoProduto
  Width = 1024
  Height = 768
  Caption = 'Etiquetas - Lote de Produto'
  Position = poDesigned
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  ExplicitWidth = 1024
  ExplicitHeight = 768
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 668
    Width = 1018
    ExplicitTop = 668
    ExplicitWidth = 1018
    inherited FlwBotoes: TFlowPanel
      Width = 1014
      ExplicitWidth = 1014
    end
  end
  inherited pnlStatus: TPanel
    Top = 723
    Width = 1018
    ExplicitTop = 723
    ExplicitWidth = 1018
    inherited pnlNomeForm: TPanel
      Left = 847
      ExplicitLeft = 847
    end
    inherited pnlInfo: TPanel
      Width = 847
      ExplicitWidth = 847
    end
  end
  inherited pgcDados: TPageControl
    Top = 409
    Width = 1018
    Height = 259
    ExplicitTop = 409
    ExplicitWidth = 1018
    ExplicitHeight = 259
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 1010
      ExplicitHeight = 227
    end
  end
  object pnlContFiltros: TPanel [3]
    Left = 0
    Top = 0
    Width = 1018
    Height = 409
    Align = alTop
    TabOrder = 3
    object pnlFiltros: TPanel
      Left = 1
      Top = 1
      Width = 1016
      Height = 374
      Align = alClient
      TabOrder = 0
      object pnlWms: TPanel
        Left = 1
        Top = 302
        Width = 1014
        Height = 71
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 2
        object Label12: TLabel
          Left = 84
          Top = 27
          Width = 22
          Height = 14
          Alignment = taRightJustify
          Caption = 'Rua:'
        end
        object Label13: TLabel
          Left = 271
          Top = 26
          Width = 33
          Height = 14
          Alignment = taRightJustify
          Caption = 'Pr'#233'dio:'
        end
        object Label14: TLabel
          Left = 73
          Top = 50
          Width = 33
          Height = 14
          Alignment = taRightJustify
          Caption = 'Andar:'
        end
        object Label15: TLabel
          Left = 239
          Top = 50
          Width = 65
          Height = 14
          Alignment = taRightJustify
          Caption = 'Apartamento:'
        end
        object Label16: TLabel
          Left = 26
          Top = 4
          Width = 80
          Height = 14
          Alignment = taRightJustify
          Caption = 'Loc. Separa'#231#227'o:'
        end
        object Label18: TLabel
          Left = 160
          Top = 52
          Width = 15
          Height = 14
          Caption = 'at'#233
        end
        object Label19: TLabel
          Left = 358
          Top = 52
          Width = 15
          Height = 14
          Caption = 'at'#233
        end
        object Label20: TLabel
          Left = 160
          Top = 27
          Width = 15
          Height = 14
          Caption = 'at'#233
        end
        object Label21: TLabel
          Left = 358
          Top = 27
          Width = 15
          Height = 14
          Caption = 'at'#233
        end
        object edtRuaIni: TEditFocus
          Tag = 99
          Left = 108
          Top = 24
          Width = 47
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtPredioIni: TEditFocus
          Tag = 99
          Left = 305
          Top = 24
          Width = 47
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtAndarIni: TEditFocus
          Tag = 99
          Left = 108
          Top = 47
          Width = 47
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          TabOrder = 5
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtApartamentoIni: TEditFocus
          Tag = 99
          Left = 305
          Top = 47
          Width = 47
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          TabOrder = 7
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtCodLse: TEditFocus
          Tag = 99
          Left = 108
          Top = 1
          Width = 46
          Height = 22
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          TabOrder = 0
          OnExit = edtCodLseExit
          OnKeyPress = edtCodLseKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 3
          TipoTexto = ttAlfanumerico
        end
        object edtDesLse: TEditFocus
          Left = 154
          Top = 1
          Width = 368
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 9
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtRuaFin: TEditFocus
          Tag = 99
          Left = 181
          Top = 24
          Width = 47
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtPredioFin: TEditFocus
          Tag = 99
          Left = 379
          Top = 24
          Width = 47
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtAndarFin: TEditFocus
          Tag = 99
          Left = 181
          Top = 47
          Width = 47
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          TabOrder = 6
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtApartamentoFin: TEditFocus
          Tag = 99
          Left = 379
          Top = 47
          Width = 47
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          TabOrder = 8
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
      object rdgSaldo: TRadioGroup
        Left = 529
        Top = 4
        Width = 96
        Height = 71
        Caption = 'Saldo'
        ItemIndex = 0
        Items.Strings = (
          'Todos'
          'Positivos'
          'Negativos')
        TabOrder = 3
      end
      object pnlDatas: TPanel
        Left = 1
        Top = 1
        Width = 1014
        Height = 120
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object gpb1: TGroupBox
          Left = 7
          Top = 0
          Width = 528
          Height = 114
          Caption = 'Per'#237'odo de Altera'#231#227'o de Pre'#231'o'
          TabOrder = 0
          object lbl1: TLabel
            Left = 267
            Top = 18
            Width = 50
            Height = 14
            Alignment = taRightJustify
            Caption = 'Data Final:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object Label1: TLabel
            Left = 10
            Top = 18
            Width = 54
            Height = 14
            Alignment = taRightJustify
            Caption = 'Data Inicial:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object lblEmpresa: TLabel
            Left = 10
            Top = 32
            Width = 42
            Height = 14
            Caption = 'Empresa'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object Label22: TLabel
            Left = 158
            Top = 17
            Width = 26
            Height = 14
            Caption = 'Hora:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object Label23: TLabel
            Left = 412
            Top = 17
            Width = 26
            Height = 14
            Caption = 'Hora:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object lblTabPre: TLabel
            Left = 301
            Top = 49
            Width = 34
            Height = 14
            Alignment = taRightJustify
            Caption = 'Tabela:'
          end
          object mskDtaIni: TMaskEditFocus
            Tag = 99
            Left = 68
            Top = 14
            Width = 85
            Height = 22
            EditMask = '99/99/9999;1;_'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 10
            ParentFont = False
            TabOrder = 0
            Text = '  /  /    '
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            ValidaData = True
          end
          object mskDtaFin: TMaskEditFocus
            Tag = 99
            Left = 321
            Top = 14
            Width = 85
            Height = 22
            Enabled = False
            EditMask = '99/99/9999;1;_'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 10
            ParentFont = False
            TabOrder = 2
            Text = '  /  /    '
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            ValidaData = True
          end
          object edtCodEmpresa: TEditFocus
            Tag = 99
            Left = 10
            Top = 45
            Width = 57
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 3
            ParentFont = False
            TabOrder = 4
            OnExit = edtCodEmpresaExit
            OnKeyPress = edtCodEmpresaKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 3
            TipoTexto = ttNumerico
          end
          object edtDesEmpresa: TEditFocus
            Left = 67
            Top = 45
            Width = 230
            Height = 22
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 5
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object mskHraIni: TMaskEditFocus
            Tag = 99
            Left = 187
            Top = 14
            Width = 64
            Height = 22
            EditMask = '!99:99;1;_'
            MaxLength = 5
            TabOrder = 1
            Text = '  :  '
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            ValidaData = False
          end
          object mskHraFin: TMaskEditFocus
            Tag = 99
            Left = 441
            Top = 14
            Width = 64
            Height = 22
            EditMask = '!99:99;1;_'
            MaxLength = 5
            TabOrder = 3
            Text = '  :  '
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            ValidaData = False
          end
          object clbPreTab: TCheckListBox
            Tag = 99
            Left = 336
            Top = 48
            Width = 190
            Height = 17
            BorderStyle = bsNone
            Color = 16770261
            Columns = 7
            Ctl3D = True
            ItemHeight = 14
            Items.Strings = (
              '1'
              '2'
              '3'
              '4'
              '5'
              '6'
              '7')
            ParentCtl3D = False
            TabOrder = 6
            StyleElements = [seFont, seBorder]
          end
          object rdgPreAlt: TRadioGroup
            Left = 4
            Top = 67
            Width = 519
            Height = 35
            Caption = 'Pre'#231'o Alterado'
            Columns = 3
            Ctl3D = True
            ItemIndex = 1
            Items.Strings = (
              'Pre'#231'o de Custo'
              'Pre'#231'o de Venda'
              'Todos os pre'#231'os')
            ParentCtl3D = False
            TabOrder = 7
          end
        end
      end
      object pnlCampos: TPanel
        Left = 1
        Top = 121
        Width = 1014
        Height = 182
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object Label2: TLabel
          Left = 14
          Top = 31
          Width = 93
          Height = 14
          Alignment = taRightJustify
          Caption = 'Linha / Grupo Final:'
        end
        object Label3: TLabel
          Left = 279
          Top = 97
          Width = 81
          Height = 14
          Alignment = taRightJustify
          Caption = 'Refer'#234'ncia Final:'
        end
        object lbl2: TLabel
          Left = 48
          Top = 119
          Width = 59
          Height = 14
          Alignment = taRightJustify
          Caption = 'Fornecedor:'
        end
        object lbl3: TLabel
          Left = 10
          Top = 9
          Width = 97
          Height = 14
          Alignment = taRightJustify
          Caption = 'Linha / Grupo Inicial:'
        end
        object lbl4: TLabel
          Left = 70
          Top = 54
          Width = 37
          Height = 14
          Alignment = taRightJustify
          Caption = 'Produto'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lbl5: TLabel
          Left = 74
          Top = 76
          Width = 33
          Height = 14
          Alignment = taRightJustify
          Caption = 'Marca:'
        end
        object lbl6: TLabel
          Left = 22
          Top = 97
          Width = 85
          Height = 14
          Alignment = taRightJustify
          Caption = 'Refer'#234'ncia Inicial:'
        end
        object lbl9: TLabel
          Left = 83
          Top = 167
          Width = 24
          Height = 14
          Alignment = taRightJustify
          Caption = 'Lote:'
        end
        object lblLocFin: TLabel
          Left = 279
          Top = 145
          Width = 80
          Height = 14
          Alignment = taRightJustify
          Caption = 'Loc. Fisica Final:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblLocFis: TLabel
          Left = 23
          Top = 145
          Width = 84
          Height = 14
          Alignment = taRightJustify
          Caption = 'Loc. Fisica Inicial:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object edtCodFor: TEditFocus
          Tag = 99
          Left = 108
          Top = 115
          Width = 56
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 8
          TabOrder = 0
          OnExit = edtCodForExit
          OnKeyPress = edtCodForKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 8
          TipoTexto = ttNumerico
        end
        object edtCodIte: TEditFocus
          Left = 108
          Top = 49
          Width = 56
          Height = 22
          Alignment = taLeftJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnExit = edtCodIteExit
          OnKeyPress = edtCodIteKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttAlfanumerico
        end
        object edtCodMar: TEditFocus
          Tag = 99
          Left = 108
          Top = 71
          Width = 56
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 6
          TabOrder = 2
          OnExit = edtCodMarExit
          OnKeyPress = edtCodMarKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 6
          TipoTexto = ttNumerico
        end
        object edtDesGru: TEditFocus
          Left = 164
          Top = 5
          Width = 359
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
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
        object edtDesIte: TEditFocus
          Left = 164
          Top = 49
          Width = 359
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          TabOrder = 4
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtDesMar: TEditFocus
          Left = 164
          Top = 71
          Width = 359
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
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
        object edtLinGruFin: TEditFocus
          Left = 164
          Top = 27
          Width = 359
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
        object edtLocFis: TEditFocus
          Tag = 99
          Left = 108
          Top = 137
          Width = 162
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 7
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtLocFisFin: TEditFocus
          Tag = 99
          Left = 361
          Top = 137
          Width = 162
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
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
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtNomFor: TEditFocus
          Left = 164
          Top = 115
          Width = 359
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 9
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtNumLot: TEditFocus
          Tag = 99
          Left = 108
          Top = 159
          Width = 93
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 10
          OnKeyPress = edtNumLotKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtRefere: TEditFocus
          Tag = 99
          Left = 108
          Top = 93
          Width = 162
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 11
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtRefFin: TEditFocus
          Tag = 99
          Left = 361
          Top = 93
          Width = 162
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 12
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object mskLinGru: TMaskEditFocus
          Tag = 99
          Left = 108
          Top = 5
          Width = 56
          Height = 22
          CharCase = ecUpperCase
          EditMask = '999.999;0;_'
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 7
          TabOrder = 13
          Text = ''
          OnExit = mskLinGruExit
          OnKeyPress = mskLinGruKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
        end
        object mskLinGruFin: TMaskEditFocus
          Tag = 99
          Left = 108
          Top = 27
          Width = 56
          Height = 22
          CharCase = ecUpperCase
          EditMask = '999.999;0;_'
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 7
          TabOrder = 14
          Text = ''
          OnExit = mskLinGruFinExit
          OnKeyPress = mskLinGruFinKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
        end
      end
    end
    object pnlQtdEti: TPanel
      Left = 1
      Top = 375
      Width = 1016
      Height = 33
      Align = alBottom
      TabOrder = 1
      ExplicitLeft = 2
      ExplicitTop = 378
      object lblQtdEtq: TLabel
        Left = 110
        Top = 11
        Width = 120
        Height = 14
        Alignment = taRightJustify
        Caption = 'Quantidade de Etiquetas:'
      end
      object lblOrdenandoPor: TLabel
        AlignWithMargins = True
        Left = 921
        Top = 16
        Width = 91
        Height = 16
        Margins.Top = 15
        Align = alRight
        Alignment = taRightJustify
        ExplicitLeft = 846
        ExplicitTop = 11
        ExplicitHeight = 14
      end
      object edtQtdEtq: TEditFocus
        Tag = 99
        Left = 231
        Top = 5
        Width = 39
        Height = 22
        Alignment = taLeftJustify
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        NumbersOnly = True
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '##0'
      end
      object btnConfirmaFiltro: TBitBtnLocked
        Left = 429
        Top = 5
        Width = 98
        Height = 24
        Caption = '[ F5 ] Confirma'
        TabOrder = 1
        OnClick = btnConfirmaFiltroClick
      end
      object btnLimFil: TBitBtnLocked
        Left = 325
        Top = 5
        Width = 98
        Height = 24
        Caption = '[ F4 ] Limpa Filtro'
        TabOrder = 2
        OnClick = btnLimFilClick
      end
    end
  end
  object cxDados: TcxGrid [4]
    Left = 0
    Top = 409
    Width = 1018
    Height = 259
    Align = alClient
    TabOrder = 4
    LockedStateImageOptions.Text = 'Por favor aguarde...'
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxDadostv: TcxGridDBTableView
      OnKeyDown = cxDadostvKeyDown
      Navigator.Buttons.CustomButtons = <>
      FilterBox.Visible = fvNever
      OnCustomDrawCell = cxDadostvCustomDrawCell
      DataController.DataSource = dtsDados
      DataController.Filter.Options = [fcoCaseInsensitive, fcoSoftCompare]
      DataController.Filter.Active = True
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para filtrar.'
      FilterRow.Visible = True
      OptionsData.Deleting = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir.'
      OptionsView.GroupByBox = False
      object cxDadosQTDETI: TcxGridDBColumn
        Caption = 'Qtd. Etiq.'
        DataBinding.FieldName = 'QTDETI'
        Width = 51
      end
      object cxDadosNUMLOT: TcxGridDBColumn
        Caption = 'N'#250'mero do Lote'
        DataBinding.FieldName = 'NUMLOT'
        Options.Editing = False
        Width = 88
      end
      object cxDadosCODITE: TcxGridDBColumn
        Caption = 'Item'
        DataBinding.FieldName = 'CODITE'
        Options.Editing = False
      end
      object cxDadosDESITE: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'DESITE'
        Options.Editing = False
        Width = 211
      end
      object cxDadosLOCFIS: TcxGridDBColumn
        Caption = 'Localiza'#231#227'o Fisica'
        DataBinding.FieldName = 'LOCFIS'
        Options.Editing = False
        Width = 124
      end
      object cxDadosSALDOS: TcxGridDBColumn
        Caption = 'Saldo'
        DataBinding.FieldName = 'SALDOS'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 3
        Properties.DisplayFormat = '0.000;'
        Options.Editing = False
      end
      object cxDadostvR_U_A_: TcxGridDBColumn
        Caption = 'Rua'
        DataBinding.FieldName = 'R_U_A_'
        Options.Editing = False
      end
      object cxDadostvPREDIO: TcxGridDBColumn
        Caption = 'Pr'#233'dio'
        DataBinding.FieldName = 'PREDIO'
        Options.Editing = False
      end
      object cxDadostvANDAR_: TcxGridDBColumn
        Caption = 'Andar'
        DataBinding.FieldName = 'ANDAR_'
        Options.Editing = False
      end
      object cxDadostvAPARTA: TcxGridDBColumn
        Caption = 'Apartamento'
        DataBinding.FieldName = 'APARTA'
        Options.Editing = False
      end
    end
    object cxDadosLvl: TcxGridLevel
      GridView = cxDadostv
    end
  end
  object pnlBotoesImp: TPanel [5]
    Left = 0
    Top = 697
    Width = 1018
    Height = 26
    Align = alBottom
    BevelInner = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 5
    object btnConfirma: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 84
      Height = 22
      Align = alLeft
      Caption = '[ F10 ] Confirma'
      TabOrder = 0
      OnClick = btnConfirmaClick
    end
    object btnSairImp: TBitBtnLocked
      Left = 932
      Top = 2
      Width = 84
      Height = 22
      Align = alRight
      Caption = '[ Esc ] Sair'
      TabOrder = 1
      OnClick = btnSairImpClick
    end
  end
  object pnlLegenda: TPanel [6]
    Left = 0
    Top = 668
    Width = 1018
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 6
    object shpLegenda: TShape
      Left = 110
      Top = 5
      Width = 19
      Height = 18
      Brush.Color = clMoneyGreen
      Pen.Color = clGray
    end
    object Label4: TLabel
      Left = 135
      Top = 7
      Width = 219
      Height = 14
      Alignment = taRightJustify
      Caption = 'Produtos com quantidade de etiqueta definida'
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 752
    Top = 168
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 720
    Top = 168
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 744
    Top = 208
  end
  object dtsDados: TDataSource
    Left = 456
    Top = 328
  end
end
