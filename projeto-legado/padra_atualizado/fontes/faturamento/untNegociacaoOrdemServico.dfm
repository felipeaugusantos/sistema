inherited frmNegociacaoOrdemServico: TfrmNegociacaoOrdemServico
  Left = 0
  Top = 77
  Width = 1183
  Height = 704
  Caption = 'Negocia'#231#227'o Global de Ordem de Servi'#231'o'
  Position = poDesigned
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  ExplicitWidth = 1183
  ExplicitHeight = 704
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 659
    Width = 1177
    ExplicitTop = 659
    ExplicitWidth = 1177
    inherited FlwBotoes: TFlowPanel
      Width = 1173
      Height = 16
      ExplicitWidth = 1173
      ExplicitHeight = 16
    end
  end
  inherited pnlStatus: TPanel
    Top = 659
    Width = 1177
    ExplicitTop = 659
    ExplicitWidth = 1177
    inherited pnlNomeForm: TPanel
      Left = 1006
      ExplicitLeft = 1006
    end
    inherited pnlInfo: TPanel
      Width = 1006
      ExplicitWidth = 1006
    end
  end
  inherited pgcDados: TPageControl
    Width = 1177
    Height = 659
    Visible = False
    ExplicitWidth = 1177
    ExplicitHeight = 659
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 1169
      ExplicitHeight = 627
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 1177
    Height = 659
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object pnlTopo: TPanel
      Left = 0
      Top = 0
      Width = 1177
      Height = 89
      Align = alTop
      TabOrder = 0
      object lblNumNeg: TLabel
        Left = 10
        Top = 14
        Width = 115
        Height = 14
        Alignment = taRightJustify
        Caption = 'N'#250'mero da Negocia'#231#227'o:'
      end
      object lblStaNeg: TLabel
        Left = 550
        Top = 14
        Width = 109
        Height = 14
        Alignment = taRightJustify
        Caption = 'Status da Negocia'#231#227'o:'
      end
      object lblCliente: TLabel
        Left = 90
        Top = 37
        Width = 35
        Height = 14
        Alignment = taRightJustify
        Caption = 'Cliente:'
      end
      object lblOrdSer: TLabel
        Left = 35
        Top = 62
        Width = 90
        Height = 14
        Alignment = taRightJustify
        Caption = 'Ordem de Servi'#231'o:'
      end
      object lblNegEmp: TLabel
        Left = 263
        Top = 14
        Width = 45
        Height = 14
        Alignment = taRightJustify
        Caption = 'Empresa:'
        Visible = False
      end
      object lblOSEmp: TLabel
        Left = 226
        Top = 62
        Width = 45
        Height = 14
        Alignment = taRightJustify
        Caption = 'Empresa:'
      end
      object edtNegSta: TEditFocus
        Left = 665
        Top = 9
        Width = 136
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        CharCase = ecUpperCase
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
      object edtCodCli: TEditFocus
        Tag = 99
        Left = 131
        Top = 34
        Width = 65
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 8
        TabOrder = 4
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
        Left = 197
        Top = 34
        Width = 604
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        CharCase = ecUpperCase
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
      object edtNegNum: TEditFocus
        Tag = 99
        Left = 131
        Top = 9
        Width = 125
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 12
        TabOrder = 0
        OnChange = edtNegNumChange
        OnExit = edtNegNumExit
        OnKeyPress = edtNegNumKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 12
        TipoTexto = ttNumerico
      end
      object btnIncluir: TBitBtnLocked
        Left = 706
        Top = 61
        Width = 95
        Height = 22
        Caption = '&Incluir'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          96675E9F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F
          609F6F609F6F60FF00FFFF00FFFF00FF99695FF6E0BFF4DDB8F3DAB4F3D7ADF2
          D5A7F0D3A3F0D09EEECC99EECA93EDC990EDC68C9F6F60FF00FFFF00FFFF00FF
          9D6C60F6E3C6F6E1C1F4DDBBF3DCB4008100F2D5AAF0D3A4F0CF9FEFCC99EFCB
          95EEC9909F6F60FF00FFFF00FFFF00FFA16E60F7E6CEF6E5C7F4E1C100810000
          8100008100F3D5ABF0D3A5EFD19FEFCE9AEFCB969F6F60FF00FFFF00FFFF00FF
          A67262F8EAD4F7E7CE008100307A2A5F924B00810050883CF2D5ABF0D3A5F0D0
          A0EFCF9C9F6F60FF00FFFF00FFFF00FFAB7663FAEEDAFAEBD5008100EFE2C2F6
          E2C2A7B883008100008100EDD4A9F0D4A6F0D1A19F6F60FF00FFFF00FFFF00FF
          B07864FAF0E2FAEEDCF8EBD5F8E9D0F7E6CAF6E3C5E6D8B4008100008100F2D7
          ADF2D4A79F6F60FF00FFFF00FFFF00FFB57D64FCF3E7FBF0E3FAEFDDFAEDD8F7
          E9D1F8E6CBF6E3C5F6E1C0F4DEBAF4DAB5F3D7AD9F6F60FF00FFFF00FFFF00FF
          BB8065FCF7EDD58127D58127D58127D58127D58127D58127D58127D58127D581
          27F3DAB69F6F60FF00FFFF00FFFF00FFC08366FCF8F3FCF7EFFCF4EAFBF2E5FB
          EFDEF8EDD9F8EBD4F8E7CEF7E3C7F6E1C2F4DEBB9F6F60FF00FFFF00FFFF00FF
          C48767FEFBF8FEFAF3FEF7EFFCF4EAFBF2E6FAEFE0F8EDDAF8EAD4F7E9CFF7E5
          C9F6E2C49F6F60FF00FFFF00FFFF00FFC98967FEFCFBD58127D58127D58127D5
          8127D58127D58127D58127D58127D58127F7E5CA9F6F60FF00FFFF00FFFF00FF
          CC8B68FFFFFFFFFEFCFEFCFAFEFBF4FEF8F0FCF6EDFCF4E7FAF2E2FAEFDCF8ED
          D7F8EAD19F6F60FF00FFFF00FFFF00FFCF8E68FFFFFFFFFFFFFFFFFCFFFCFAFE
          FBF6FEF8F0FCF7EEFBF4E9FBF2E3FBEFDDF8EDD89F6F60FF00FFFF00FFFF00FF
          CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E
          68CF8E68CF8E68FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 9
        OnClick = btnIncluirClick
      end
      object edtNumOse: TEditFocus
        Tag = 99
        Left = 131
        Top = 59
        Width = 65
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 6
        ParentFont = False
        TabOrder = 6
        OnChange = edtNumOseChange
        OnKeyPress = edtNumOseKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 6
        TipoTexto = ttInteiro
      end
      object edtCodEmpNeg: TEditFocus
        Tag = 99
        Left = 309
        Top = 9
        Width = 31
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        ParentFont = False
        TabOrder = 1
        Visible = False
        OnKeyPress = edtCodEmpNegKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttInteiro
      end
      object edtDesEmpNeg: TEditFocus
        Left = 341
        Top = 9
        Width = 200
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 2
        Visible = False
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodEmpOS: TEditFocus
        Tag = 99
        Left = 277
        Top = 59
        Width = 31
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        ParentFont = False
        TabOrder = 7
        OnKeyPress = edtCodEmpOSKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttInteiro
      end
      object edtDesEmpOS: TEditFocus
        Left = 309
        Top = 59
        Width = 232
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 8
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
    object dbgGridOrdSer: TDBGridCitel
      Left = 0
      Top = 119
      Width = 1177
      Height = 273
      Align = alClient
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 1
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = 14
      TitleFont.Name = 'Arial'
      TitleFont.Pitch = fpVariable
      TitleFont.Style = []
      OnKeyDown = dbgGridOrdSerKeyDown
      CorZebra = cl3DLight
      Zebra = True
      DestacarMouse = False
      Columns = <
        item
          Expanded = False
          FieldName = 'NUMOSE'
          Title.Caption = 'O.S.'
          Width = 58
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CODEMP'
          Title.Caption = 'Emp.'
          Width = 29
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DTAORC'
          Title.Caption = 'Dt. Or'#231'amento'
          Width = 90
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DTACON'
          Title.Caption = 'Dt. Conclus'#227'o'
          Width = 90
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'TOTPRO'
          Title.Alignment = taRightJustify
          Title.Caption = 'Total Produtos'
          Width = 100
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'TOTSER'
          Title.Alignment = taRightJustify
          Title.Caption = 'Total Servi'#231'os'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TOTRET'
          Title.Alignment = taRightJustify
          Title.Caption = 'Total ST'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TOTIPI'
          Title.Alignment = taRightJustify
          Title.Caption = 'Total IPI'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TOTGER'
          Title.Alignment = taRightJustify
          Title.Caption = 'Total Geral'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PORDES'
          Title.Alignment = taRightJustify
          Title.Caption = '% Desc.'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VLRDES'
          Title.Alignment = taRightJustify
          Title.Caption = 'Desc. R$'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TOTDES'
          Title.Alignment = taRightJustify
          Title.Caption = 'Total c/ Desc.'
          Width = 100
          Visible = True
        end>
    end
    object pnlCndHis: TPanel
      Left = 0
      Top = 503
      Width = 1177
      Height = 127
      Align = alBottom
      TabOrder = 5
      object grbCndPag: TGroupBox
        Left = 1
        Top = 1
        Width = 653
        Height = 125
        Align = alLeft
        Caption = 'Dados Gerais'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object pnlCndPag: TPanel
          Left = 2
          Top = 16
          Width = 649
          Height = 107
          Align = alClient
          BevelOuter = bvNone
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentColor = True
          ParentFont = False
          TabOrder = 0
          object lblCndPag: TLabel
            Left = 6
            Top = 10
            Width = 61
            Height = 14
            Alignment = taRightJustify
            Caption = 'Cond. Pagto:'
          end
          object lblForPag: TLabel
            Left = 7
            Top = 58
            Width = 60
            Height = 14
            Alignment = taRightJustify
            Caption = 'Form. Pagto:'
          end
          object edtCodCnd: TEditFocus
            Tag = 99
            Left = 68
            Top = 7
            Width = 45
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 3
            TabOrder = 0
            OnEnter = edtCodCndEnter
            OnExit = edtCodCndExit
            OnKeyPress = edtCodCndKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 3
            TipoTexto = ttNumerico
          end
          object mskCndPag: TMaskEditFocus
            Tag = 99
            Left = 114
            Top = 7
            Width = 528
            Height = 22
            CharCase = ecUpperCase
            EditMask = 
              '99.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.9' +
              '99.999.999.999.999.999.999.999.999;0;_'
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 98
            TabOrder = 1
            Text = ''
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            ValidaData = False
          end
          object edtDesCndPag: TEditFocus
            Left = 68
            Top = 31
            Width = 574
            Height = 22
            TabStop = False
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
          object edtForPag: TEditFocus
            Tag = 99
            Left = 68
            Top = 55
            Width = 65
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 3
            TabOrder = 3
            OnKeyPress = edtForPagKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 3
            TipoTexto = ttNumerico
          end
          object edtDesForPag: TEditFocus
            Left = 134
            Top = 55
            Width = 508
            Height = 22
            TabStop = False
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
        end
      end
      object grbHistorico: TGroupBox
        Left = 654
        Top = 1
        Width = 522
        Height = 125
        Align = alClient
        Caption = 'Hist'#243'rico de Descontos'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        object dbgGridHisDes: TDBGridCitel
          Left = 2
          Top = 16
          Width = 518
          Height = 107
          Align = alClient
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clBlack
          TitleFont.Height = -11
          TitleFont.Name = 'Arial'
          TitleFont.Pitch = fpVariable
          TitleFont.Style = [fsBold]
          OnKeyDown = dbgGridHisDesKeyDown
          CorZebra = cl3DLight
          Zebra = True
          DestacarMouse = False
          Columns = <
            item
              Expanded = False
              FieldName = 'DESCRI'
              Title.Caption = 'Desc. Aplicado em'
              Title.Font.Charset = ANSI_CHARSET
              Title.Font.Color = clBlack
              Title.Font.Height = -11
              Title.Font.Name = 'Arial'
              Title.Font.Pitch = fpVariable
              Title.Font.Style = []
              Width = 168
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DESCRT'
              Title.Caption = 'Tipo Desc.'
              Title.Font.Charset = ANSI_CHARSET
              Title.Font.Color = clBlack
              Title.Font.Height = -11
              Title.Font.Name = 'Arial'
              Title.Font.Pitch = fpVariable
              Title.Font.Style = []
              Width = 55
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PERPRD'
              Title.Caption = 'Perc. Prod. (%)'
              Title.Font.Charset = ANSI_CHARSET
              Title.Font.Color = clBlack
              Title.Font.Height = -11
              Title.Font.Name = 'Arial'
              Title.Font.Pitch = fpVariable
              Title.Font.Style = []
              Width = 79
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PERSER'
              Title.Caption = 'Perc. Serv. (%)'
              Title.Font.Charset = ANSI_CHARSET
              Title.Font.Color = clBlack
              Title.Font.Height = -11
              Title.Font.Name = 'Arial'
              Title.Font.Pitch = fpVariable
              Title.Font.Style = []
              Width = 79
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'TOTDES'
              Title.Alignment = taRightJustify
              Title.Caption = 'Valor Desconto'
              Title.Font.Charset = ANSI_CHARSET
              Title.Font.Color = clBlack
              Title.Font.Height = -11
              Title.Font.Name = 'Arial'
              Title.Font.Pitch = fpVariable
              Title.Font.Style = []
              Width = 84
              Visible = True
            end>
        end
      end
    end
    object pnlTotais: TPanel
      Left = 0
      Top = 392
      Width = 1177
      Height = 65
      Align = alBottom
      TabOrder = 3
      object lblST: TLabel
        Left = 869
        Top = 11
        Width = 45
        Height = 14
        Alignment = taRightJustify
        Caption = 'Total ST:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblIPI: TLabel
        Left = 1043
        Top = 11
        Width = 45
        Height = 14
        Alignment = taRightJustify
        Caption = 'Total IPI:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblTotaST: TLabel
        Left = 957
        Top = 6
        Width = 38
        Height = 22
        Alignment = taRightJustify
        Caption = '0,00'
        Font.Charset = ANSI_CHARSET
        Font.Color = clMaroon
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblTotIPI: TLabel
        Left = 1129
        Top = 6
        Width = 38
        Height = 22
        Alignment = taRightJustify
        Caption = '0,00'
        Font.Charset = ANSI_CHARSET
        Font.Color = clMaroon
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label4: TLabel
        Left = 1014
        Top = 37
        Width = 74
        Height = 14
        Alignment = taRightJustify
        Caption = 'Total c/ Desc.:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label10: TLabel
        Left = 830
        Top = 37
        Width = 84
        Height = 14
        Alignment = taRightJustify
        Caption = 'Total Desconto:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label32: TLabel
        Left = 668
        Top = 37
        Width = 61
        Height = 14
        Alignment = taRightJustify
        Caption = 'Total Geral:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblVlrDes: TLabel
        Left = 957
        Top = 32
        Width = 38
        Height = 22
        Alignment = taRightJustify
        Caption = '0,00'
        Font.Charset = ANSI_CHARSET
        Font.Color = clMaroon
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblTotDes: TLabel
        Left = 1129
        Top = 32
        Width = 38
        Height = 22
        Alignment = taRightJustify
        Caption = '0,00'
        Font.Charset = ANSI_CHARSET
        Font.Color = clMaroon
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblTotGer: TLabel
        Left = 778
        Top = 32
        Width = 38
        Height = 22
        Alignment = taRightJustify
        Caption = '0,00'
        Font.Charset = ANSI_CHARSET
        Font.Color = clMaroon
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object pnlMsgDel: TPanel
      Left = 0
      Top = 457
      Width = 1177
      Height = 17
      Align = alBottom
      Caption = 'Pressione DELETE para excluir uma Ordem de Servi'#231'o do grid'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
    end
    object pnlDesconto: TPanel
      Left = 0
      Top = 474
      Width = 1177
      Height = 29
      Align = alBottom
      TabOrder = 2
      object lblAplDes: TLabel
        Left = 9
        Top = 6
        Width = 72
        Height = 14
        Alignment = taRightJustify
        Caption = 'Tipo Desconto:'
      end
      object rbSemDes: TRadioButton
        Left = 83
        Top = 6
        Width = 130
        Height = 17
        Caption = 'Sem Desconto'
        Checked = True
        TabOrder = 0
        TabStop = True
      end
      object rbDesPrd: TRadioButton
        Left = 208
        Top = 6
        Width = 130
        Height = 17
        Caption = 'Produtos'
        TabOrder = 1
      end
      object rbDesSer: TRadioButton
        Left = 333
        Top = 6
        Width = 130
        Height = 17
        Caption = 'Servi'#231'os'
        TabOrder = 2
      end
      object rbPrdSer: TRadioButton
        Left = 458
        Top = 6
        Width = 130
        Height = 17
        Caption = 'Produtos e Servi'#231'os'
        TabOrder = 3
      end
      object rbVlrNeg: TRadioButton
        Left = 583
        Top = 6
        Width = 130
        Height = 17
        Caption = 'Valor Negociado Final'
        TabOrder = 4
      end
      object btnAplicar: TBitBtnLocked
        Left = 1090
        Top = 2
        Width = 83
        Height = 24
        Caption = '&Aplicar'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000006D6D
          6D6FBBBBBBC1B8B8B8C1BBBBBBC1515151520000000000000000070707077474
          7476AAAAAAB1A7A7A7B2A7A7A7B2AAAAAAB17474747607070707000000006D6D
          6D707B6C66E651382DFF887D78DEB8B8B8BF343434350000000072727274B3B2
          B2C472645CE9543E33FA533D33FA71635CE9B2B1B1C472727274000000006E6E
          6E6FB8B7B7C3725F56F0573E32FE978F8DD3B0B0B0B51D1D1D1DABABABB17566
          60E8563B30FF928985D8928986D7553A2FFF73655EE8ABABABB1000000000202
          02028A8A8A8CAEADACC46A5248F65B4237FC9C9896C3A2A2A2A5B0B0B0B95E46
          3BFA5B4134FFB2B1B0C5B2B1B0C55A3F33FF5B4338FAB0B0B0B9000000000000
          00000B0B0B0BA0A0A0A3A09C9AC2634A3FFB604B42F6ABAAA9C3AFAFAFB95F46
          3BFC5D4236FFB2B0B0C4B2B0B0C55B4135FF5D4338FCB0B0B0B9000000000000
          0000000000001B1B1B1BAFAFAFB39C9491D061483BFE6C5951F0B2B2B2C47E6D
          66E85E4337FF8F8783D88F8782D85D4236FF7C6C64E8B2B2B2B7070707077575
          7576ACACACB0AAAAAAB1AAAAAAB1B4B4B4BD918681DC5F4538FF7B6C65E7B2B1
          B0C5806F68E7604A3EFA60493EFA81716AE7B5B4B4C37575757673737374B7B6
          B5C37E6E67E8634940FA624A3FFA7D6D66E8B2B1B0C485756DE65E4437FF8C81
          7CDCB6B6B6BFA8A8A8AFA9A9A9AFAAAAAAAE7070707107070707ADADADB08170
          69E765493DFF9B938FD69C9490D562483BFF7F6F67E7B8B7B7C37A665DEF5F45
          39FE9B9491D1B2B2B2B51D1D1D1D000000000000000000000000B2B2B2B76D54
          49FA6B5042FFB5B4B4C3B5B4B4C3694D41FF6A5146FAB2B2B2B8B2B1B0C3735B
          50F6634A3EFBA19D9AC2A3A3A3A50D0D0D0D0000000000000000B3B3B3B77055
          49FC6D5144FFB7B6B5C3B7B6B5C36C4F42FF6D5246FCB2B2B2B7A1A1A1A3A3A0
          9DC16C5447FB695248F6AFADACC28D8D8D8E0404040400000000B4B4B4B78B7A
          72E7705346FF9B928ED79B918ED76D5144FF89786FE7B4B4B4B71B1B1B1BB1B1
          B1B3A19996CE6B5044FE736057EFB8B7B7C2707070710000000075757576B9B8
          B7C28D7C74E66F574BF96F564BF98D7C75E5B9B8B7C275757576000000003131
          3131B9B9B9BC998E89DB684C41FF83746EE56F6F6F7100000000070707077373
          7374ACACACAEABABABAEABABABAEACACACAE7070707107070707000000000000
          00004F4F4F4FBEBEBEC0BDBDBDC0BEBEBEC07070707100000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        TabOrder = 7
        OnClick = btnAplicarClick
      end
      object pnlDesProSer: TPanel
        Left = 730
        Top = 1
        Width = 350
        Height = 27
        BevelOuter = bvNone
        TabOrder = 6
        Visible = False
        object pnlDesSer: TPanel
          Left = 175
          Top = 0
          Width = 175
          Height = 29
          BevelOuter = bvNone
          TabOrder = 1
          Visible = False
          object Label1: TLabel
            Left = 7
            Top = 5
            Width = 90
            Height = 14
            Alignment = taRightJustify
            Caption = '% Desc. Servi'#231'os:'
          end
          object edtDesSer: TEditFocus
            Tag = 99
            Left = 99
            Top = 2
            Width = 70
            Height = 22
            Alignment = taRightJustify
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
        end
        object pnlDesPro: TPanel
          Left = 0
          Top = 0
          Width = 175
          Height = 29
          BevelOuter = bvNone
          TabOrder = 0
          Visible = False
          object lblPorDes: TLabel
            Left = 7
            Top = 5
            Width = 90
            Height = 14
            Alignment = taRightJustify
            Caption = '% Desc. Produtos:'
          end
          object edtDesPrd: TEditFocus
            Tag = 99
            Left = 99
            Top = 2
            Width = 70
            Height = 22
            Alignment = taRightJustify
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
        end
      end
      object pnlValNeg: TPanel
        Left = 856
        Top = 1
        Width = 228
        Height = 27
        BevelOuter = bvNone
        TabOrder = 5
        Visible = False
        object lblValNeg: TLabel
          Left = 17
          Top = 5
          Width = 133
          Height = 14
          Alignment = taRightJustify
          Caption = 'Valor Negociado Final (OS):'
        end
        object edtVlrNeg: TEditFocus
          Tag = 99
          Left = 154
          Top = 2
          Width = 70
          Height = 22
          Alignment = taRightJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
      end
    end
    object pnlButtons: TPanel
      Left = 0
      Top = 630
      Width = 1177
      Height = 29
      Align = alBottom
      Anchors = []
      BevelInner = bvLowered
      BevelOuter = bvLowered
      Color = clGray
      ParentBackground = False
      TabOrder = 6
      object FlwPnlButtons: TFlowPanel
        Left = 2
        Top = 2
        Width = 1074
        Height = 25
        Align = alClient
        BevelOuter = bvNone
        ShowCaption = False
        TabOrder = 0
        object btnGravar: TBitBtnLocked
          Left = 0
          Top = 0
          Width = 186
          Height = 22
          Caption = '[F2] Gravar Negocia'#231#227'o'
          TabOrder = 0
          OnClick = btnGravarClick
        end
        object btnFinalizar: TBitBtnLocked
          Left = 186
          Top = 0
          Width = 186
          Height = 22
          Caption = '[F10] Finalizar e Ativar Negocia'#231#227'o'
          Enabled = False
          TabOrder = 1
          OnClick = btnFinalizarClick
        end
        object btnExcluir: TBitBtnLocked
          Left = 372
          Top = 0
          Width = 186
          Height = 22
          Caption = '[F5] Excluir Negocia'#231#227'o'
          Enabled = False
          TabOrder = 2
          OnClick = btnExcluirClick
        end
      end
      object btnFechar: TBitBtnLocked
        AlignWithMargins = True
        Left = 1090
        Top = 3
        Width = 82
        Height = 21
        Margins.Left = 14
        Margins.Top = 1
        Align = alRight
        Caption = '&Sair'
        Glyph.Data = {
          36050000424D3605000000000000360400002800000010000000100000000100
          08000000000000010000120B0000120B0000000100000001000000520000006B
          0000006B0800106B0800008C080000940800007B100000731800087B180008A5
          1800089C21001094290010A529001084310010A5310018A5310010A539001884
          4200DE844200218C42002194420018AD420018B5420021B5420021944A00299C
          4A0029BD4A00DE8C52003194520018B5520031C6520031945A00299C5A0031AD
          5A00BD5A6300AD73630029AD630039D66300DEA5840042B59400FFD69C0073A5
          AD00DEBDAD006BA5B5009CBDB500B5C6B500DED6B500FFDEB500D6C6BD00FFE7
          BD00088CC600DECEC60073D6C600E7D6C600EFD6C600F7E7C600FFE7C600088C
          CE000894CE00E7D6CE00109CD600189CD600219CD600299CD60018A5D60021A5
          D60029A5D60031A5D60042ADD600F7E7D600FFE7D600FFEFD60021A5DE0031AD
          DE00E7D6DE00FFEFE700FFF7E7004ACEEF005ADEEF0052CEF7005ADEF70094E7
          F700A5E7F7006BEFF7007BEFF70084F7F7008CF7F7009CF7F700FFFFF700FF00
          FF0063DEFF006BDEFF005AEFFF0073F7FF007BF7FF0084F7FF0094F7FF009CF7
          FF00A5F7FF0073FFFF007BFFFF0084FFFF008CFFFF0094FFFF009CFFFF00A5FF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00593232595959
          5959595959595959595932514E32323232325959595959595959325266655F5F
          5E5A32320203595959593A44685D5E27141819130604085959594144575D651F
          1A1A17150E0905015959424E4465651F1E251A17170E09040059425444696327
          21242432101D0A0D325942562B44606067665D5D0F0B1154415942552A444444
          44446153081F4F5F4D594255305846312E2C445134605B605F3D4255306A4B45
          372F2D444444444444434355336A584B45372F28295C3D5959593F57356A6A58
          4B452323233E3E595959593F366A6A6A6A3B23122259595959595959356A6A6A
          6A4A231B59595959595959592626262626262359595959595959}
        TabOrder = 1
        OnClick = btnSairClick
      end
    end
    object pnlCliente: TPanel
      Left = 0
      Top = 89
      Width = 1177
      Height = 30
      Align = alTop
      TabOrder = 7
      object lblCliNeg: TLabel
        Left = 30
        Top = 7
        Width = 95
        Height = 14
        Alignment = taRightJustify
        Caption = 'Cliente Negocia'#231#227'o:'
      end
      object dbeNomCli: TDBEditFocus
        Tag = 99
        Left = 197
        Top = 4
        Width = 604
        Height = 22
        CharCase = ecUpperCase
        Color = 16768952
        DataField = 'NOMCLI'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeCodCli: TDBEditFocus
        Tag = 99
        Left = 131
        Top = 4
        Width = 65
        Height = 22
        CharCase = ecUpperCase
        Color = 16768952
        DataField = 'CODCLI'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
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
        TipoTexto = ttAlfanumerico
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 936
    Top = 0
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 888
    Top = 0
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 840
    Top = 0
  end
  object dtsOrdSer: TDataSource
    Left = 80
    Top = 160
  end
  object dtsHisDes: TDataSource
    Left = 144
    Top = 160
  end
end
