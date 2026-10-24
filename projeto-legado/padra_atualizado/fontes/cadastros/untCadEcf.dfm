inherited frmCadEcf: TfrmCadEcf
  Left = 242
  Top = 232
  Width = 614
  Height = 508
  Caption = 'Cadastro de impressoras fiscais'
  ExplicitWidth = 614
  ExplicitHeight = 508
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 438
    Width = 608
    Height = 25
    ExplicitTop = 438
    ExplicitWidth = 608
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 533
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 604
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 74
        ExplicitWidth = 74
      end
      inherited btnGravar: TBitBtnLocked
        Left = 74
        Width = 74
        ExplicitLeft = 74
        ExplicitWidth = 74
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 148
        Width = 75
        ExplicitLeft = 148
        ExplicitWidth = 75
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 223
        Width = 74
        ExplicitLeft = 223
        ExplicitWidth = 74
      end
      inherited btnCancela: TBitBtnLocked
        Left = 297
        Width = 74
        ExplicitLeft = 297
        ExplicitWidth = 74
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 371
        Width = 78
        ExplicitLeft = 371
        ExplicitWidth = 78
      end
      object btnCadInicial: TBitBtnLocked
        Left = 449
        Top = 0
        Width = 74
        Height = 20
        Caption = 'Cad. Inicial'
        TabOrder = 6
        OnClick = btnCadInicialClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 535
      Width = 71
      Height = 21
      Align = alRight
      ExplicitLeft = 534
      ExplicitWidth = 71
      ExplicitHeight = 20
    end
  end
  inherited pgcDados: TPageControl
    Width = 608
    Height = 438
    ExplicitWidth = 608
    ExplicitHeight = 438
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 600
      ExplicitHeight = 406
      object pnlMarMod: TPanel
        Left = 0
        Top = 0
        Width = 600
        Height = 149
        Align = alTop
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object Label1: TLabel
          Left = 65
          Top = 11
          Width = 36
          Height = 14
          Caption = 'C'#243'digo:'
        end
        object Label2: TLabel
          Left = 31
          Top = 36
          Width = 70
          Height = 14
          Caption = 'Marca/Modelo:'
        end
        object Label3: TLabel
          Left = 18
          Top = 57
          Width = 83
          Height = 14
          Caption = 'N'#250'mero de S'#233'rie:'
        end
        object Label9: TLabel
          Left = 6
          Top = 101
          Width = 95
          Height = 42
          Alignment = taRightJustify
          Caption = 'C'#243'digo Nacional de '#13#10'Identifica'#231#227'o de '#13#10'ECF (para PAF):'
        end
        object Label10: TLabel
          Left = 24
          Top = 79
          Width = 77
          Height = 14
          Caption = 'N'#250'mero do ECF:'
        end
        object dbeCodigo: TDBEditFocus
          Tag = 99
          Left = 105
          Top = 7
          Width = 50
          Height = 22
          DataField = 'ECF_CODECF'
          DataSource = dtsCadEcf
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttNumerico
        end
        object dbeModelo: TDBEditFocus
          Tag = 99
          Left = 105
          Top = 29
          Width = 255
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ECF_MODELO'
          DataSource = dtsCadEcf
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeNumSer: TDBEditFocus
          Tag = 99
          Left = 105
          Top = 52
          Width = 255
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ECF_NUMSER'
          DataSource = dtsCadEcf
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeCodNac: TDBEditFocus
          Tag = 99
          Left = 105
          Top = 109
          Width = 88
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ECF_CODNAC'
          DataSource = dtsCadEcf
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeNumUsu: TDBEditFocus
          Tag = 99
          Left = 105
          Top = 75
          Width = 88
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ECF_NUMUSU'
          DataSource = dtsCadEcf
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          TabOrder = 3
          OnKeyPress = dbeNumUsuKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttNumerico
        end
      end
      object Panel1: TPanel
        Left = 0
        Top = 149
        Width = 600
        Height = 84
        Align = alTop
        Color = 16770261
        ParentBackground = False
        TabOrder = 1
        object ColorLabel2: TColorLabel
          Left = 13
          Top = 11
          Width = 88
          Height = 14
          Caption = 'C'#243'd. Sub. Trib.(F):'
          CorDestaque = clRed
        end
        object ColorLabel3: TColorLabel
          Left = 34
          Top = 33
          Width = 67
          Height = 14
          Caption = 'C'#243'd. Isento(I):'
          CorDestaque = clRed
        end
        object ColorLabel4: TColorLabel
          Left = 15
          Top = 55
          Width = 86
          Height = 14
          Caption = 'C'#243'd n'#227'o Incid.(N):'
          CorDestaque = clRed
        end
        object Label7: TLabel
          Left = 189
          Top = 11
          Width = 67
          Height = 14
          Caption = 'C'#243'd./Aliquota:'
        end
        object Label21: TLabel
          Left = 201
          Top = 33
          Width = 54
          Height = 14
          Caption = 'Percentual:'
        end
        object ColorLabel5: TColorLabel
          Left = 305
          Top = 55
          Width = 55
          Height = 14
          Caption = '(S)im (N)'#227'o'
          CorDestaque = clRed
        end
        object Label4: TLabel
          Left = 215
          Top = 55
          Width = 40
          Height = 14
          Caption = 'Servi'#231'o:'
        end
        object ColorLabel6: TColorLabel
          Left = 305
          Top = 33
          Width = 10
          Height = 14
          Caption = '%'
          CorDestaque = clRed
        end
        object dbeCodStb: TDBEditFocus
          Tag = 99
          Left = 105
          Top = 7
          Width = 26
          Height = 22
          DataField = 'ECF_CODSTB'
          DataSource = dtsCadEcf
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeCodIse: TDBEditFocus
          Tag = 99
          Left = 105
          Top = 29
          Width = 26
          Height = 22
          DataField = 'ECF_CODISE'
          DataSource = dtsCadEcf
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeCodNin: TDBEditFocus
          Tag = 99
          Left = 105
          Top = 51
          Width = 26
          Height = 22
          DataField = 'ECF_CODNIN'
          DataSource = dtsCadEcf
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object edtCodAlq: TEditFocus
          Tag = 99
          Left = 259
          Top = 7
          Width = 101
          Height = 22
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 10
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtServic: TEditFocus
          Tag = 99
          Left = 259
          Top = 51
          Width = 43
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 1
          TabOrder = 5
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfabetico
        end
        object edtPerAlq: TEditFocus
          Tag = 99
          Left = 259
          Top = 29
          Width = 43
          Height = 22
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 6
          TabOrder = 4
          OnExit = edtPerAlqExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object btnConfirmaAlq: TBitBtnLocked
          Left = 481
          Top = 6
          Width = 111
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
          TabOrder = 6
          OnClick = btnConfirmaAlqClick
        end
        object btnCancelaAlq: TBitBtnLocked
          Left = 481
          Top = 31
          Width = 111
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
          TabOrder = 7
          OnClick = btnCancelaAlqClick
        end
        object btnAliquo: TBitBtnLocked
          Left = 481
          Top = 55
          Width = 111
          Height = 22
          Caption = 'A&l'#237'quotas'
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FF7A2D067A2D067A2D067A2D06FF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF7A2D06E9AD68
            E2751F7A2D06FF00FF0000000000000000000000000000000000000000000000
            00000000000000FF00FF7A2D0642C555F4CFA47A2D06FF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF7A2D067A2D06
            7A2D067A2D06FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF7A2D067A2D06
            7A2D067A2D06FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FF7A2D06E9AD68E2751F7A2D06FF00FF00000000000000
            0000000000000000000000000000000000000000000000FF00FF7A2D0642C555
            F4CFA47A2D06FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FF7A2D067A2D067A2D067A2D06FF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FF7A2D067A2D067A2D067A2D06FF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF7A2D06E9AD68
            E2751F7A2D06FF00FF0000000000000000000000000000000000000000000000
            00000000000000FF00FF7A2D0642C555F4CFA47A2D06FF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF7A2D067A2D06
            7A2D067A2D06FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
          TabOrder = 8
          OnClick = btnAliquoClick
        end
      end
      object Panel5: TPanel
        Left = 0
        Top = 233
        Width = 600
        Height = 173
        Align = alClient
        Color = 16770261
        ParentBackground = False
        TabOrder = 2
        object dbgAliquo: TDBGridCitel
          Left = 7
          Top = 6
          Width = 585
          Height = 157
          DataSource = dtsTabAlq
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgCancelOnExit]
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clBlack
          TitleFont.Height = 14
          TitleFont.Name = 'Arial'
          TitleFont.Pitch = fpVariable
          TitleFont.Style = []
          OnKeyDown = dbgAliquoKeyDown
          CorZebra = clMoneyGreen
          Zebra = False
          DestacarMouse = False
          Columns = <
            item
              Expanded = False
              FieldName = 'CODALQ'
              Title.Caption = 'C'#243'd./Aliq.'
              Width = 100
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PERALQ'
              Title.Caption = 'Perc./Alq.'
              Width = 100
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'SERVIC'
              Title.Caption = 'Servi'#231'o'
              Width = 100
              Visible = True
            end>
        end
      end
    end
    object tabModali: TTabSheet
      Caption = '&2 - Digita'#231#227'o de Modalidades'
      ImageIndex = 1
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 600
        Height = 406
        Align = alClient
        ParentBackground = False
        TabOrder = 0
        object Panel3: TPanel
          Left = 1
          Top = 1
          Width = 598
          Height = 113
          Align = alTop
          Color = 16770261
          ParentBackground = False
          TabOrder = 0
          object Label32: TLabel
            Left = 65
            Top = 18
            Width = 52
            Height = 14
            Alignment = taRightJustify
            Caption = 'Descri'#231#227'o:'
          end
          object Label33: TLabel
            Left = 81
            Top = 40
            Width = 36
            Height = 14
            Alignment = taRightJustify
            Caption = 'C'#243'digo:'
          end
          object Label34: TLabel
            Left = 53
            Top = 62
            Width = 64
            Height = 14
            Alignment = taRightJustify
            Caption = 'Identifica'#231#227'o:'
          end
          object Label5: TLabel
            Left = 13
            Top = 84
            Width = 104
            Height = 14
            Alignment = taRightJustify
            Caption = 'Imprime Vencimentos:'
          end
          object ColorLabel1: TColorLabel
            Left = 184
            Top = 84
            Width = 55
            Height = 14
            Caption = '(S)im (N)'#227'o'
            CorDestaque = clRed
          end
          object dbeIdenti: TDBLookupComboBoxFocus
            Left = 121
            Top = 58
            Width = 208
            Height = 22
            Color = clWhite
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            KeyField = 'TMP_CODIDE'
            ListField = 'TMP_DESIDE'
            ListSource = dtsEcfIde
            TabOrder = 2
            OnKeyDown = dbeIdentiKeyDown
            NormalColor = clWhite
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
          object edtDesMod: TEditFocus
            Tag = 99
            Left = 121
            Top = 14
            Width = 304
            Height = 22
            Alignment = taLeftJustify
            ImeName = 'Portugu'#234's (Brasil ABNT)'
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
          object edtCodMod: TEditFocus
            Tag = 99
            Left = 121
            Top = 36
            Width = 57
            Height = 22
            Alignment = taLeftJustify
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 2
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtInfAdi: TEditFocus
            Tag = 99
            Left = 121
            Top = 80
            Width = 57
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 1
            TabOrder = 3
            Text = 'N'
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 1
            TipoTexto = ttAlfabetico
          end
          object btnConfirmaMod: TBitBtnLocked
            Left = 441
            Top = 11
            Width = 111
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
            TabOrder = 4
            OnClick = btnConfirmaModClick
          end
          object btnCancelaMod: TBitBtnLocked
            Left = 441
            Top = 39
            Width = 111
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
            TabOrder = 5
            OnClick = btnCancelaModClick
          end
        end
        object Panel4: TPanel
          Left = 1
          Top = 114
          Width = 598
          Height = 291
          Align = alClient
          Color = 16770261
          ParentBackground = False
          TabOrder = 1
          object dbgModali: TDBGridCitel
            Left = 8
            Top = 8
            Width = 578
            Height = 271
            DataSource = dtsTabMod
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgCancelOnExit]
            ReadOnly = True
            TabOrder = 0
            TitleFont.Charset = ANSI_CHARSET
            TitleFont.Color = clBlack
            TitleFont.Height = 14
            TitleFont.Name = 'Arial'
            TitleFont.Pitch = fpVariable
            TitleFont.Style = []
            OnKeyDown = dbgModaliKeyDown
            CorZebra = clMoneyGreen
            Zebra = False
            DestacarMouse = False
            Columns = <
              item
                Expanded = False
                FieldName = 'CODMOD'
                Title.Caption = 'C'#243'digo'
                Width = 100
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'DESMOD'
                Title.Caption = 'Descri'#231#227'o'
                Width = 150
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'DESIDE'
                Title.Caption = 'Identifica'#231#227'o'
                Width = 100
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'INFADI'
                Title.Caption = 'Imp.Venc.'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'CODFPG'
                Title.Caption = 'Form. Pag.'
                Visible = True
              end>
          end
        end
      end
    end
    object TabSheet1: TTabSheet
      Caption = '&3 - Formas de Pagamento'
      ImageIndex = 2
      object Panel6: TPanel
        Left = 0
        Top = 0
        Width = 600
        Height = 406
        Align = alClient
        ParentBackground = False
        TabOrder = 0
        object pnlFpgEcf: TPanel
          Left = 1
          Top = 1
          Width = 598
          Height = 58
          Align = alTop
          Color = 16770261
          ParentBackground = False
          TabOrder = 0
          object Label8: TLabel
            Left = 20
            Top = 34
            Width = 93
            Height = 14
            Alignment = taRightJustify
            Caption = 'C'#243'digo Modalidade:'
          end
          object Label6: TLabel
            Left = 9
            Top = 11
            Width = 104
            Height = 14
            Alignment = taRightJustify
            Caption = 'Forma de Pagamento:'
          end
          object edtModFpg: TEditFocus
            Tag = 99
            Left = 121
            Top = 30
            Width = 46
            Height = 22
            Alignment = taLeftJustify
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 2
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtDesFpg: TEditFocus
            Left = 167
            Top = 7
            Width = 258
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
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
          object edtCodFpg: TEditFocus
            Tag = 99
            Left = 121
            Top = 7
            Width = 45
            Height = 22
            Alignment = taLeftJustify
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 3
            TabOrder = 0
            OnKeyPress = edtCodFpgKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 3
            TipoTexto = ttNumerico
          end
          object btnConfirmaFpg: TBitBtnLocked
            Left = 441
            Top = 7
            Width = 111
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
            TabOrder = 3
            OnClick = btnConfirmaFpgClick
          end
          object btnCancelaFpg: TBitBtnLocked
            Left = 441
            Top = 30
            Width = 111
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
            TabOrder = 4
            OnClick = btnCancelaFpgClick
          end
        end
        object Panel8: TPanel
          Left = 1
          Top = 59
          Width = 598
          Height = 346
          Align = alClient
          Color = 16770261
          ParentBackground = False
          TabOrder = 1
          object dbgFpgEcf: TDBGridCitel
            Left = 1
            Top = 1
            Width = 596
            Height = 344
            Align = alClient
            DataSource = dtsFpgEcf
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgCancelOnExit]
            ReadOnly = True
            TabOrder = 0
            TitleFont.Charset = ANSI_CHARSET
            TitleFont.Color = clBlack
            TitleFont.Height = 14
            TitleFont.Name = 'Arial'
            TitleFont.Pitch = fpVariable
            TitleFont.Style = []
            OnKeyDown = dbgFpgEcfKeyDown
            CorZebra = clMoneyGreen
            Zebra = False
            DestacarMouse = False
            Columns = <
              item
                Expanded = False
                FieldName = 'CODFPG'
                Title.Caption = 'Form. Pgto.'
                Width = 80
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'CODMOD'
                Title.Caption = 'Modalidade'
                Width = 80
                Visible = True
              end>
          end
        end
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 463
    Width = 608
    ExplicitTop = 463
    ExplicitWidth = 608
    inherited pnlNomeForm: TPanel
      Left = 450
      Width = 158
      ExplicitLeft = 450
      ExplicitWidth = 158
    end
    inherited pnlInfo: TPanel
      Width = 450
      ExplicitWidth = 450
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 400
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 368
  end
  object dtsEcfIde: TDataSource
    Left = 432
  end
  object dtsFpgEcf: TDataSource
    DataSet = cdsFpgEcf
    Left = 215
    Top = 232
  end
  object cdsFpgEcf: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 183
    Top = 232
    object cdsFpgEcfCODFPG: TStringField
      FieldName = 'CODFPG'
      Size = 3
    end
    object cdsFpgEcfCODMOD: TStringField
      FieldName = 'CODMOD'
      Size = 2
    end
  end
  object dtsTabAlq: TDataSource
    Left = 88
    Top = 232
  end
  object dtsTabMod: TDataSource
    Left = 119
    Top = 232
  end
  object dtsCadEcf: TDataSource
    Left = 151
    Top = 232
  end
end
