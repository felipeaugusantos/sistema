inherited frmLancamentosPeriodicos: TfrmLancamentosPeriodicos
  Width = 1137
  Height = 760
  Caption = 'Lan'#231'amentos Peri'#243'dicos'
  OnDestroy = FormDestroy
  ExplicitWidth = 1137
  ExplicitHeight = 760
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 687
    Width = 1131
    ExplicitTop = 687
    ExplicitWidth = 1131
    inherited FlwBotoes: TFlowPanel
      Width = 1127
      ExplicitWidth = 1127
    end
    inherited btnSair: TBitBtnLocked
      Left = 1050
      ExplicitLeft = 1050
    end
  end
  inherited pnlStatus: TPanel
    Top = 715
    Width = 1131
    ExplicitTop = 715
    ExplicitWidth = 1131
    inherited pnlNomeForm: TPanel
      Left = 784
      ExplicitLeft = 784
    end
    inherited pnlInfo: TPanel
      Width = 784
      ExplicitWidth = 784
    end
  end
  inherited pgcDados: TPageControl
    Width = 1131
    Height = 687
    ExplicitWidth = 1131
    ExplicitHeight = 687
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 1123
      ExplicitHeight = 655
      object pnlCapa: TPanel
        Left = 0
        Top = 0
        Width = 1123
        Height = 147
        Align = alTop
        TabOrder = 0
        object Label1: TLabel
          Left = 48
          Top = 7
          Width = 36
          Height = 14
          Alignment = taRightJustify
          Caption = 'C'#243'digo:'
        end
        object Label2: TLabel
          Left = 32
          Top = 34
          Width = 52
          Height = 14
          Alignment = taRightJustify
          Caption = 'Descri'#231#227'o:'
        end
        object Label3: TLabel
          Left = 35
          Top = 63
          Width = 49
          Height = 14
          Alignment = taRightJustify
          Caption = 'Operador:'
        end
        object Label4: TLabel
          Left = 10
          Top = 91
          Width = 74
          Height = 14
          Alignment = taRightJustify
          Caption = 'Data Altera'#231#227'o:'
        end
        object Label5: TLabel
          Left = 9
          Top = 119
          Width = 75
          Height = 14
          Alignment = taRightJustify
          Caption = 'Hora Altera'#231#227'o:'
        end
        object dbeCodigo: TDBEditFocus
          Tag = 99
          Left = 90
          Top = 4
          Width = 207
          Height = 22
          TabStop = False
          CharCase = ecUpperCase
          Color = 16768952
          DataField = 'AUTOINCREM'
          DataSource = dtsPerGer
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 0
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
        object dbeDescri: TDBEditFocus
          Tag = 99
          Left = 90
          Top = 32
          Width = 439
          Height = 22
          CharCase = ecUpperCase
          DataField = 'GER_DESCRI'
          DataSource = dtsPerGer
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeCodOpe: TDBEditFocus
          Left = 90
          Top = 60
          Width = 207
          Height = 22
          TabStop = False
          CharCase = ecUpperCase
          Color = 16768952
          DataField = 'GER_CODOPE'
          DataSource = dtsPerGer
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 2
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfabetico
        end
        object dbeDtaAlt: TDBEditFocus
          Left = 90
          Top = 88
          Width = 207
          Height = 22
          TabStop = False
          CharCase = ecUpperCase
          Color = 16768952
          DataField = 'GER_DTAALT'
          DataSource = dtsPerGer
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 3
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfabetico
        end
        object dbeHraAlt: TDBEditFocus
          Left = 90
          Top = 116
          Width = 207
          Height = 22
          TabStop = False
          CharCase = ecUpperCase
          Color = 16768952
          DataField = 'GER_HRAALT'
          DataSource = dtsPerGer
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 4
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfabetico
        end
      end
      object pnlDetalhe: TPanel
        Left = 0
        Top = 147
        Width = 1123
        Height = 508
        Align = alClient
        TabOrder = 1
        object pnlItemPeriodico: TPanel
          Left = 1
          Top = 1
          Width = 1121
          Height = 352
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object Label12: TLabel
            Left = 38
            Top = 39
            Width = 46
            Height = 14
            Alignment = taRightJustify
            Caption = 'C. D'#233'bito:'
          end
          object lbCCustoDebito: TLabel
            Left = 18
            Top = 93
            Width = 66
            Height = 14
            Alignment = taRightJustify
            Caption = 'C.Custo D'#233'b.:'
          end
          object lbContaCredito: TLabel
            Left = 34
            Top = 119
            Width = 50
            Height = 14
            Alignment = taRightJustify
            Caption = 'C. Cr'#233'dito:'
          end
          object lbCCustoCredito: TLabel
            Left = 20
            Top = 172
            Width = 64
            Height = 14
            Alignment = taRightJustify
            Caption = 'C.Custo Cre.:'
          end
          object lbHisPad: TLabel
            Left = 4
            Top = 225
            Width = 82
            Height = 14
            Alignment = taRightJustify
            Caption = 'Hist'#243'rico Padr'#227'o:'
          end
          object lbHistor: TLabel
            Left = 17
            Top = 249
            Width = 67
            Height = 14
            Alignment = taRightJustify
            Caption = 'Complemento:'
          end
          object lbTipLan: TLabel
            Left = 12
            Top = 328
            Width = 74
            Height = 14
            Alignment = taRightJustify
            Caption = 'Tipo de Lancto:'
          end
          object Label15: TLabel
            Left = 38
            Top = 9
            Width = 45
            Height = 14
            Alignment = taRightJustify
            Caption = 'Empresa:'
          end
          object lbSubcontaDebito: TLabel
            Left = 16
            Top = 64
            Width = 68
            Height = 14
            Alignment = taRightJustify
            Caption = 'Subconta C/F:'
          end
          object lbSubcontaCredito: TLabel
            Left = 16
            Top = 147
            Width = 68
            Height = 14
            Alignment = taRightJustify
            Caption = 'Subconta C/F:'
          end
          object lbValor: TLabel
            Left = 56
            Top = 199
            Width = 28
            Height = 14
            Alignment = taRightJustify
            Caption = 'Valor:'
          end
          object mskContaDebito: TMaskEditFocus
            Tag = 99
            Left = 89
            Top = 34
            Width = 126
            Height = 22
            TabOrder = 1
            Text = ''
            OnClick = mskContaDebitoClick
            OnKeyPress = mskContaDebitoKeyPress
            OnKeyUp = mskContaDebitoKeyUp
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            ValidaData = False
          end
          object edtConDebRed: TEditFocus
            Tag = 99
            Left = 217
            Top = 34
            Width = 113
            Height = 22
            Alignment = taLeftJustify
            Color = clWhite
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 2
            OnClick = edtConDebRedClick
            OnKeyUp = edtConDebRedKeyUp
            NormalColor = clWhite
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtDesContaDebito: TEditFocus
            Left = 332
            Top = 34
            Width = 465
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 17
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtCCustoDebito: TEditFocus
            Tag = 99
            Left = 89
            Top = 88
            Width = 83
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 5
            TabOrder = 5
            OnEnter = edtCCustoDebitoEnter
            OnKeyPress = edtCCustoDebitoKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesCCustoDebito: TEditFocus
            Left = 174
            Top = 88
            Width = 623
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ReadOnly = True
            TabOrder = 18
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object mskContaCredito: TMaskEditFocus
            Tag = 99
            Left = 89
            Top = 115
            Width = 126
            Height = 22
            TabOrder = 6
            Text = ''
            OnClick = mskContaCreditoClick
            OnKeyPress = mskContaCreditoKeyPress
            OnKeyUp = mskContaCreditoKeyUp
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            ValidaData = False
          end
          object edtConCreRed: TEditFocus
            Tag = 99
            Left = 217
            Top = 115
            Width = 113
            Height = 22
            Alignment = taLeftJustify
            Color = clWhite
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 7
            OnClick = edtConCreRedClick
            OnKeyUp = edtConCreRedKeyUp
            NormalColor = clWhite
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtDesContaCRedito: TEditFocus
            Left = 332
            Top = 115
            Width = 465
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 19
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtCCustoCredito: TEditFocus
            Tag = 99
            Left = 89
            Top = 169
            Width = 83
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 5
            TabOrder = 10
            OnEnter = edtCCustoCreditoEnter
            OnKeyPress = edtCCustoCreditoKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesCCustoCredito: TEditFocus
            Left = 175
            Top = 169
            Width = 622
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ReadOnly = True
            TabOrder = 20
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtHisPad: TEditFocus
            Tag = 99
            Left = 89
            Top = 222
            Width = 57
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 9
            TabOrder = 12
            OnKeyPress = edtHisPadKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 9
            TipoTexto = ttNumerico
          end
          object edtDesHistPadrao: TEditFocus
            Left = 149
            Top = 222
            Width = 649
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ReadOnly = True
            TabOrder = 21
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtHistor: TMemoFocus
            Left = 89
            Top = 248
            Width = 709
            Height = 72
            TabOrder = 13
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            StringQuebra = '<<csq>>'
          end
          object edtTipLan: TComboBoxFocus
            Tag = 99
            Left = 89
            Top = 325
            Width = 543
            Height = 22
            Style = csDropDownList
            TabOrder = 14
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
          object edtEmpLan: TEditFocus
            Tag = 99
            Left = 89
            Top = 6
            Width = 57
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 3
            TabOrder = 0
            OnExit = edtEmpLanExit
            OnKeyPress = edtEmpLanKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 3
            TipoTexto = ttNumerico
          end
          object edtNomEmp: TEditFocus
            Left = 148
            Top = 6
            Width = 522
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ReadOnly = True
            TabOrder = 22
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object btnAdicionar: TBitBtnLocked
            Left = 634
            Top = 325
            Width = 82
            Height = 22
            Caption = '&Confirma'
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
            TabOrder = 15
            OnClick = btnAdicionarClick
          end
          object btnCancelaItem: TBitBtnLocked
            Left = 717
            Top = 325
            Width = 82
            Height = 22
            Caption = 'C&ancelar'
            Glyph.Data = {
              36030000424D3603000000000000360000002800000010000000100000000100
              18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603
              015603015603FF00FF0000820000820000820000820000820000820000820000
              820000820000820000820156032DC6511DB236015603FF00FF000082011EF305
              27FB1337FB3052FC5F7DFEA1B4FFF2F6FFFFFFFFFFFFFF0000820156033FD96D
              30C956015603FF00FF0000820120FB0528FC1438FC3154FE607FFFA5B7FFF6FA
              FFFFFFFFFFFFFF000082015603015603015603015603FF00FF00008200008200
              0082000082000082000082000082000082000082000082000082FF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603FF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              01560341E07428AC47015603015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FF035A05015603FF00FFFF00FFFF00FF0156032DC45035CE5D188F2C015603FF
              00FFFF00FFFF00FFFF00FFFF00FF045F09188E2B015603FF00FFFF00FF015603
              0E8F1C19AB3122B53E035E07FF00FFFF00FFFF00FFFF00FFFF00FF05630A2DB7
              50015603FF00FFFF00FFFF00FF01560301560303650711A32216A42904600702
              5804015704045F080E78192FBC55015603FF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FF0156030263050A98150FA01F0D891A108E1F1CA6342ABD4A015603FF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF01560301560305840C08
              8E110D971A0D971A015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FF015603015603015603015603FF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
            TabOrder = 16
            OnClick = btnCancelaItemClick
          end
          object edtOpcSubcontaDebito: TEditFocus
            Tag = 99
            Left = 89
            Top = 61
            Width = 19
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            Color = clWhite
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 1
            TabOrder = 3
            OnKeyPress = edtOpcSubcontaDebitoKeyPress
            NormalColor = clWhite
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 1
            TipoTexto = ttAlfanumerico
          end
          object edtCodCliForSubcontaDebito: TEditFocus
            Tag = 99
            Left = 110
            Top = 61
            Width = 83
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 8
            TabOrder = 4
            OnKeyPress = edtCodCliForSubcontaDebitoKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 8
            TipoTexto = ttNumerico
          end
          object edtOpcSubcontaCredito: TEditFocus
            Tag = 99
            Left = 89
            Top = 142
            Width = 19
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            Color = clWhite
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 1
            TabOrder = 8
            OnKeyPress = edtOpcSubcontaCreditoKeyPress
            NormalColor = clWhite
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 1
            TipoTexto = ttAlfanumerico
          end
          object edtCodCliForSubcontaCredito: TEditFocus
            Tag = 99
            Left = 110
            Top = 142
            Width = 83
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 8
            TabOrder = 9
            OnKeyPress = edtCodCliForSubcontaCreditoKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 8
            TipoTexto = ttNumerico
          end
          object edtNomCliForSubcontaDebito: TEditFocus
            Left = 196
            Top = 61
            Width = 601
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ReadOnly = True
            TabOrder = 24
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtNomCliForSubcontaCredito: TEditFocus
            Left = 196
            Top = 142
            Width = 601
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ReadOnly = True
            TabOrder = 25
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object dbgBuscaConta: TDBGridCitel
            Left = 543
            Top = 25
            Width = 474
            Height = 185
            DataSource = dtsBusca
            Options = [dgEditing, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
            TabOrder = 23
            TitleFont.Charset = ANSI_CHARSET
            TitleFont.Color = clBlack
            TitleFont.Height = 14
            TitleFont.Name = 'Arial'
            TitleFont.Pitch = fpVariable
            TitleFont.Style = []
            Visible = False
            OnDblClick = dbgBuscaContaDblClick
            CorZebra = clMoneyGreen
            Zebra = False
            DestacarMouse = False
            Columns = <
              item
                Expanded = False
                FieldName = 'CODCON'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'CONRED'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'DESCON'
                Visible = True
              end>
          end
          object edtValor: TCurrencyEditFocus
            Left = 89
            Top = 196
            EditValue = 0.000000000000000000
            Properties.DisplayFormat = '0.00;-0.00'
            StyleFocused.Color = clInfoBk
            TabOrder = 11
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            Width = 107
          end
        end
        object GridCitel: TcxGridCitel
          Left = 1
          Top = 353
          Width = 1121
          Height = 154
          Align = alClient
          TabOrder = 1
          LookAndFeel.ScrollbarMode = sbmClassic
          object GridCitelTableView: TcxGridDBTableViewCitel
            OnKeyDown = GridCitelTableViewKeyDown
            Navigator.Buttons.CustomButtons = <>
            Navigator.Buttons.Delete.Enabled = False
            Navigator.Buttons.Delete.Visible = False
            DataController.DataSource = dstDetalhe
            DataController.Filter.Options = [fcoCaseInsensitive]
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            FilterRow.InfoText = 'Clique aqui para definir um filtro'
            FilterRow.ApplyChanges = fracDelayed
            OptionsCustomize.ColumnsQuickCustomization = True
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
            OptionsView.GroupByBox = False
            OptionsView.Indicator = True
            Zebra = True
            Destaque = False
            CorZebra = clMoneyGreen
            object GridCitelTableViewAUTOINCREM: TcxGridDBColumn
              Caption = 'Seq.'
              DataBinding.FieldName = 'AUTOINCREM'
              Width = 79
            end
            object GridCitelTableViewCON_CONDEB: TcxGridDBColumn
              Caption = 'Conta D'#233'bito'
              DataBinding.FieldName = 'CON_CONDEB'
              Width = 131
            end
            object GridCitelTableViewDES_CONDEB: TcxGridDBColumn
              Caption = 'Descr. Conta D'#233'bito'
              DataBinding.FieldName = 'DES_CONDEB'
              Width = 219
            end
            object GridCitelTableViewCON_CCUSTO: TcxGridDBColumn
              Caption = 'C. C. D'#233'bito'
              DataBinding.FieldName = 'CON_CCUSTO'
              Width = 100
            end
            object GridCitelTableViewDES_CCUSTO: TcxGridDBColumn
              Caption = 'Descr. C.C. D'#233'bito'
              DataBinding.FieldName = 'DES_CCUSTO'
              Width = 164
            end
            object GridCitelTableViewCON_CONCRE: TcxGridDBColumn
              Caption = 'Conta Cr'#233'dito'
              DataBinding.FieldName = 'CON_CONCRE'
              Width = 123
            end
            object GridCitelTableViewDES_CONCRE: TcxGridDBColumn
              Caption = 'Descr. Conta Cr'#233'dito'
              DataBinding.FieldName = 'DES_CONCRE'
              Width = 243
            end
            object GridCitelTableViewCON_CCUSCR: TcxGridDBColumn
              Caption = 'C. C. Cr'#233'd'
              DataBinding.FieldName = 'CON_CCUSCR'
              Width = 125
            end
            object GridCitelTableViewDES_CCUSCR: TcxGridDBColumn
              Caption = 'Descr. C.C.Cr'#233'dito'
              DataBinding.FieldName = 'DES_CCUSCR'
              Width = 251
            end
            object GridCitelTableViewCON_TIP_FC: TcxGridDBColumn
              Caption = 'Tipo Subconta [C/F]'
              DataBinding.FieldName = 'CON_TIP_FC'
              Width = 139
            end
            object GridCitelTableViewCON_CLIFOR: TcxGridDBColumn
              Caption = 'Subconta Cli/For'
              DataBinding.FieldName = 'CON_CLIFOR'
              Width = 130
            end
            object GridCitelTableViewCON_EMPLAN: TcxGridDBColumn
              Caption = 'Emp. Lan.'
              DataBinding.FieldName = 'CON_EMPLAN'
              Width = 106
            end
            object GridCitelTableViewCON_VALLAN: TcxGridDBColumn
              Caption = 'Valor'
              DataBinding.FieldName = 'CON_VALLAN'
              Width = 119
            end
            object GridCitelTableViewCON_HISPAD: TcxGridDBColumn
              Caption = 'Hist. Padr'#227'o'
              DataBinding.FieldName = 'CON_HISPAD'
              Width = 69
            end
            object GridCitelTableViewDES_HISPAD: TcxGridDBColumn
              Caption = 'Descr. Hist'#243'rico Padr'#227'o'
              DataBinding.FieldName = 'DES_HISPAD'
              Width = 175
            end
            object GridCitelTableViewCON_HISTOR: TcxGridDBColumn
              Caption = 'Complemento'
              DataBinding.FieldName = 'CON_HISTOR'
              Width = 283
            end
            object GridCitelTableViewCON_TIPLAN: TcxGridDBColumn
              Caption = 'Tipo Lanc.'
              DataBinding.FieldName = 'CON_TIPLAN'
              Width = 148
            end
            object GridCitelTableViewCON_PARMUL: TcxGridDBColumn
              Caption = 'C'#243'digo Partida Multipla'
              DataBinding.FieldName = 'CON_PARMUL'
            end
          end
          object GridCitelLevel1: TcxGridLevel
            GridView = GridCitelTableView
          end
        end
      end
    end
  end
  object dtsPerGer: TDataSource
    Left = 376
  end
  object dtsBusca: TDataSource
    AutoEdit = False
    Left = 428
    Top = 4
  end
  object dstDetalhe: TDataSource
    AutoEdit = False
    Left = 480
    Top = 8
  end
end
