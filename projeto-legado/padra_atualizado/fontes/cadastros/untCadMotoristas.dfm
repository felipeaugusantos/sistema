inherited frmCadMotoristas: TfrmCadMotoristas
  Left = 254
  Top = 235
  Width = 696
  Height = 372
  Caption = 'Cadastro de Motorista'
  ExplicitWidth = 696
  ExplicitHeight = 372
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 302
    Width = 690
    Height = 25
    ExplicitTop = 302
    ExplicitWidth = 690
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 616
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 616
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 73
        ExplicitWidth = 73
      end
      inherited btnGravar: TBitBtnLocked
        Left = 73
        Width = 73
        ExplicitLeft = 73
        ExplicitWidth = 73
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 146
        Width = 73
        ExplicitLeft = 146
        ExplicitWidth = 73
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 219
        Width = 73
        ExplicitLeft = 219
        ExplicitWidth = 73
      end
      inherited btnCancela: TBitBtnLocked
        Left = 292
        Width = 73
        ExplicitLeft = 292
        ExplicitWidth = 73
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 365
        Width = 73
        ExplicitLeft = 365
        ExplicitWidth = 73
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 618
      Width = 70
      Height = 21
      Align = alRight
      ExplicitLeft = 618
      ExplicitWidth = 70
      ExplicitHeight = 21
    end
  end
  inherited pnlStatus: TPanel
    Top = 327
    Width = 690
    TabOrder = 2
    ExplicitTop = 327
    ExplicitWidth = 690
    inherited pnlNomeForm: TPanel
      Left = 515
      Width = 175
      ExplicitLeft = 515
      ExplicitWidth = 175
    end
    inherited pnlInfo: TPanel
      Width = 515
      ExplicitWidth = 515
    end
  end
  inherited pgcDados: TPageControl
    Width = 690
    Height = 302
    TabOrder = 1
    ExplicitWidth = 690
    ExplicitHeight = 302
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 682
      ExplicitHeight = 270
      object gpbAppEntrega: TGroupBox
        Left = 0
        Top = 136
        Width = 682
        Height = 134
        Align = alBottom
        Caption = 'App Entrega'
        TabOrder = 2
        object pnlAppEntrega: TPanel
          Left = 2
          Top = 38
          Width = 678
          Height = 70
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 1
          object lblLogin: TLabel
            Left = 7
            Top = 5
            Width = 91
            Height = 14
            Caption = 'Login App entrega:'
            WordWrap = True
          end
          object lblLatLon: TLabel
            Left = 277
            Top = 4
            Width = 174
            Height = 14
            Caption = 'Lat, Long do endere'#231'o do motorista:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            WordWrap = True
          end
          object lblTipMot: TLabel
            Left = 28
            Top = 28
            Width = 70
            Height = 14
            Caption = 'Tipo Motorista:'
          end
          object lblMonMot: TLabel
            Left = 286
            Top = 27
            Width = 165
            Height = 14
            Caption = 'Monitorar motorista em tempo real:'
          end
          object ColorLabel1: TColorLabel
            Left = 496
            Top = 27
            Width = 55
            Height = 14
            Caption = '(S)im (N)'#227'o'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            CorDestaque = clRed
          end
          object Label6: TLabel
            Left = 252
            Top = 50
            Width = 199
            Height = 14
            Caption = 'Permite gerar romaneio pelo APP Entrega:'
          end
          object ColorLabel2: TColorLabel
            Left = 496
            Top = 50
            Width = 55
            Height = 14
            Caption = '(S)im (N)'#227'o'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            CorDestaque = clRed
          end
          object edtLogin: TEditFocus
            Tag = 99
            Left = 100
            Top = 1
            Width = 141
            Height = 22
            Alignment = taLeftJustify
            MaxLength = 15
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object dbeLatLon: TDBEditFocus
            Left = 455
            Top = 1
            Width = 141
            Height = 22
            CharCase = ecUpperCase
            DataField = 'MOT_LATLON'
            DataSource = dtsCadMot
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object cmbTipMot: TComboBoxFocus
            Left = 100
            Top = 24
            Width = 141
            Height = 22
            Style = csDropDownList
            ItemIndex = 0
            TabOrder = 2
            Text = 'MOTORISTA PR'#211'PRIO'
            Items.Strings = (
              'MOTORISTA PR'#211'PRIO'
              'MOTORISTA TERCEIRIZADO')
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
          object dbeMonMot: TDBEditFocus
            Tag = 99
            Left = 455
            Top = 24
            Width = 35
            Height = 22
            CharCase = ecUpperCase
            DataField = 'MOT_MONMOT'
            DataSource = dtsCadMot
            TabOrder = 3
            OnEnter = dbeMonMotEnter
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeGerRom: TDBEditFocus
            Tag = 99
            Left = 455
            Top = 47
            Width = 35
            Height = 22
            CharCase = ecUpperCase
            DataField = 'MOT_GERROM'
            DataSource = dtsCadMot
            TabOrder = 4
            OnEnter = dbeMonMotEnter
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
        end
        object pnlLicenca: TPanel
          Left = 2
          Top = 16
          Width = 678
          Height = 22
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object Label7: TLabel
            Left = 30
            Top = 8
            Width = 68
            Height = 14
            Caption = 'Utiliza licen'#231'a:'
          end
          object cmbLicenca: TComboBoxFocus
            Tag = 99
            Left = 100
            Top = 0
            Width = 141
            Height = 22
            Style = csDropDownList
            TabOrder = 0
            OnClick = cmbLicencaClick
            Items.Strings = (
              'Nenhum'
              'Carro'
              'Moto')
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
        end
      end
      object pnlCadPadrao: TPanel
        Left = 0
        Top = 0
        Width = 682
        Height = 114
        Align = alTop
        AutoSize = True
        BevelOuter = bvNone
        TabOrder = 0
        object Label2: TLabel
          Left = 45
          Top = 27
          Width = 52
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Nome:'
        end
        object Label1: TLabel
          Left = 61
          Top = 4
          Width = 36
          Height = 14
          Alignment = taRightJustify
          Caption = 'C'#243'digo:'
        end
        object lbl1: TLabel
          Left = 358
          Top = 4
          Width = 45
          Height = 14
          Alignment = taRightJustify
          Caption = 'Situa'#231#227'o:'
        end
        object Label3: TLabel
          Left = 45
          Top = 73
          Width = 52
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'CPF:'
        end
        object Label5: TLabel
          Left = 59
          Top = 51
          Width = 38
          Height = 14
          Alignment = taRightJustify
          Caption = 'Ve'#237'culo:'
        end
        object lblPerFre: TLabel
          Left = 3
          Top = 95
          Width = 94
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = '% Percentual Frete:'
        end
        object lbl2: TColorLabel
          Left = 449
          Top = 4
          Width = 75
          Height = 14
          Caption = '(A)tivo (I)nativo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          CorDestaque = clRed
        end
        object dbeNomMot: TDBEditFocus
          Tag = 99
          Left = 100
          Top = 23
          Width = 424
          Height = 22
          CharCase = ecUpperCase
          DataField = 'MOT_NOMMOT'
          DataSource = dtsCadMot
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeCodMot: TDBEditFocus
          Tag = 99
          Left = 100
          Top = 0
          Width = 64
          Height = 22
          CharCase = ecUpperCase
          DataField = 'MOT_CODMOT'
          DataSource = dtsCadMot
          MaxLength = 5
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttNumerico
        end
        object dbeStatus: TDBEditFocus
          Tag = 99
          Left = 409
          Top = 0
          Width = 35
          Height = 22
          CharCase = ecUpperCase
          DataField = 'MOT_STATUS'
          DataSource = dtsCadMot
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 1
          OnEnter = dbeStatusEnter
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeCpfMot: TDBEditFocus
          Tag = 99
          Left = 100
          Top = 69
          Width = 141
          Height = 22
          CharCase = ecUpperCase
          DataField = 'MOT_CPFMOT'
          DataSource = dtsCadMot
          TabOrder = 5
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object pnlCodBar: TPanel
          Left = 243
          Top = 69
          Width = 281
          Height = 23
          BevelOuter = bvNone
          Color = 16770261
          ParentBackground = False
          TabOrder = 6
          object Label4: TLabel
            Left = 40
            Top = 4
            Width = 95
            Height = 14
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'C'#243'digo de Barras:'
          end
          object dbeCodBar: TDBEditFocus
            Tag = 99
            Left = 140
            Top = 0
            Width = 141
            Height = 22
            CharCase = ecUpperCase
            DataField = 'MOT_CODBAR'
            DataSource = dtsCadMot
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
        end
        object dbePlaVei: TDBEditFocus
          Tag = 99
          Left = 100
          Top = 46
          Width = 64
          Height = 22
          CharCase = ecUpperCase
          DataField = 'MOT_PLAVEI'
          DataSource = dtsCadMot
          MaxLength = 8
          TabOrder = 3
          OnKeyPress = dbePlaVeiKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object edtDesVei: TEditFocus
          Left = 164
          Top = 46
          Width = 360
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Color = 16768952
          Enabled = False
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
        object dbePerFre: TDBEditFocus
          Left = 100
          Top = 92
          Width = 46
          Height = 22
          CharCase = ecUpperCase
          DataField = 'MOT_PERFRE'
          DataSource = dtsCadMot
          TabOrder = 7
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
        object imgFotMot: TcxImage
          Left = 560
          Top = 0
          TabOrder = 8
          Height = 84
          Width = 110
        end
      end
      object pnlSenha: TPanel
        Left = 0
        Top = 114
        Width = 682
        Height = 25
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object lblSenha: TLabel
          Left = 64
          Top = 4
          Width = 34
          Height = 14
          Alignment = taRightJustify
          Caption = 'Senha:'
        end
        object lblConSenha: TLabel
          Left = 316
          Top = 4
          Width = 64
          Height = 14
          Alignment = taRightJustify
          Caption = 'Confirma'#231#227'o:'
        end
        object edtSenha: TEditFocus
          Tag = 99
          Left = 100
          Top = 1
          Width = 141
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 10
          PasswordChar = '*'
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtConSenha: TEditFocus
          Tag = 99
          Left = 383
          Top = 1
          Width = 141
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 10
          PasswordChar = '*'
          TabOrder = 1
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
    object tbsAcessoEmp: TTabSheet
      Caption = '&2 - Acesso Empresas App Entrega'
      ImageIndex = 1
      object lblInfo: TLabel
        Left = 0
        Top = 96
        Width = 608
        Height = 14
        Alignment = taCenter
        AutoSize = False
        Caption = 'Apenas utilizado quando a CFG_MATDIS estiver ligada.'
        Font.Charset = ANSI_CHARSET
        Font.Color = clGray
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object gpbEmpresaAcesso: TGroupBox
        Left = 2
        Top = 6
        Width = 603
        Height = 170
        Caption = 'Empresas - Acesso:'
        TabOrder = 0
        object lblclbEmpresa: TLabel
          Left = 2
          Top = 154
          Width = 599
          Height = 14
          Cursor = crHandPoint
          Align = alBottom
          Caption = 'Op'#231#245'es de Sele'#231#227'o'
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsUnderline]
          ParentFont = False
          OnClick = lblclbEmpresaClick
          ExplicitWidth = 95
        end
        object clbEmpresa: TCheckListBox
          Tag = 99
          Left = 2
          Top = 16
          Width = 599
          Height = 138
          Align = alClient
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ItemHeight = 14
          TabOrder = 0
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 320
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 256
    Top = 8
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 224
    Top = 8
  end
  object dtsCadMot: TDataSource
    Left = 288
    Top = 8
  end
  object popOpSele: TPopupMenu
    Left = 453
    Top = 4
    object MarcarTodos1: TMenuItem
      Caption = 'Marcar Todos'
      OnClick = MarcarTodos1Click
    end
    object DesmarcarTodos1: TMenuItem
      Caption = 'Desmarcar Todos'
      OnClick = DesmarcarTodos1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object InverterSeleo1: TMenuItem
      Caption = 'Inverter Sele'#231#227'o'
      OnClick = InverterSeleo1Click
    end
  end
end
