inherited frmCadMetaCompDepVend: TfrmCadMetaCompDepVend
  Width = 1024
  Height = 768
  Caption = 'Meta Composta Para Departamento do Vendedor'
  ExplicitTop = -248
  ExplicitWidth = 1024
  ExplicitHeight = 768
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 695
    Width = 1018
    TabOrder = 2
    ExplicitTop = 695
    ExplicitWidth = 1018
    inherited FlwBotoes: TFlowPanel
      Width = 1014
      ExplicitWidth = 1014
    end
    inherited btnSair: TBitBtnLocked
      Left = 937
      ExplicitLeft = 937
    end
  end
  inherited pnlStatus: TPanel
    Top = 723
    Width = 1018
    TabOrder = 3
    ExplicitTop = 723
    ExplicitWidth = 1018
    inherited pnlNomeForm: TPanel
      Left = 671
      ExplicitLeft = 671
    end
    inherited pnlInfo: TPanel
      Width = 671
      ExplicitWidth = 671
    end
  end
  inherited pgcDados: TPageControl
    Top = 103
    Width = 1018
    Height = 592
    ActivePage = tbsMeta5
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 1
    OnChange = pgcDadosChange
    ExplicitTop = 103
    ExplicitWidth = 1018
    ExplicitHeight = 592
    inherited tbsGeral: TTabSheet
      Caption = 'Meta &1 - Faixas de Faturamento do Departamento'
      ExplicitWidth = 1010
      ExplicitHeight = 560
      object Panel1: TPanel
        Left = 0
        Top = 41
        Width = 1010
        Height = 519
        Align = alClient
        TabOrder = 1
        object grdMeta1: TcxGridCitel
          Left = 1
          Top = 42
          Width = 1008
          Height = 476
          Align = alClient
          TabOrder = 1
          LookAndFeel.ScrollbarMode = sbmClassic
          object grdMeta1Tv: TcxGridDBTableViewCitel
            OnKeyDown = grdMeta1TvKeyDown
            Navigator.Buttons.CustomButtons = <>
            DataController.DataSource = dtsMT1
            DataController.Filter.Options = [fcoCaseInsensitive]
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            FilterRow.InfoText = 'Clique aqui para definir um filtro'
            FilterRow.ApplyChanges = fracDelayed
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
            OptionsView.GroupByBox = False
            Zebra = False
            Destaque = False
            CorZebra = clMoneyGreen
            object grdMeta1TvVALINI: TcxGridDBColumn
              DataBinding.FieldName = 'MT1_VALINI'
              Width = 120
            end
            object grdMeta1TvVALFIN: TcxGridDBColumn
              Caption = 'Valor Final'
              DataBinding.FieldName = 'MT1_VALFIN'
              Width = 120
            end
            object grdMeta1TvVALPRE: TcxGridDBColumn
              Caption = 'Valor Pr'#234'mio'
              DataBinding.FieldName = 'MT1_VALPRE'
              Width = 120
            end
          end
          object grdMeta1Lvl: TcxGridLevel
            GridView = grdMeta1Tv
          end
        end
        object Panel10: TPanel
          Left = 1
          Top = 1
          Width = 1008
          Height = 41
          Align = alTop
          TabOrder = 0
          object lblIniMt1: TLabel
            Left = 8
            Top = 15
            Width = 90
            Height = 14
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Valor Inicial:'
          end
          object lblFinMt1: TLabel
            Left = 170
            Top = 15
            Width = 90
            Height = 14
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Valor Final:'
          end
          object lblPreMt1: TLabel
            Left = 338
            Top = 15
            Width = 90
            Height = 14
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Valor Pr'#234'mio:'
          end
          object btnAdicionarMeta1: TBitBtnLocked
            Left = 508
            Top = 11
            Width = 75
            Height = 22
            Caption = '&Adicionar'
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
            OnClick = btnAdicionarMeta1Click
          end
          object btnCancelarMeta1: TBitBtnLocked
            Left = 582
            Top = 11
            Width = 75
            Height = 22
            Caption = 'Ca&ncelar'
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
            OnClick = btnCancelarMeta1Click
          end
          object edtValIniMT1: TEditFocus
            Tag = 99
            Left = 104
            Top = 11
            Width = 70
            Height = 22
            Alignment = taRightJustify
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 0
            Text = '0,00'
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtValFinMT1: TEditFocus
            Tag = 99
            Left = 267
            Top = 11
            Width = 70
            Height = 22
            Alignment = taRightJustify
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 1
            Text = '0,00'
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtValPreMT1: TEditFocus
            Tag = 99
            Left = 433
            Top = 11
            Width = 70
            Height = 22
            Alignment = taRightJustify
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 2
            Text = '0,00'
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
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 1010
        Height = 41
        Align = alTop
        TabOrder = 0
        object Label37: TLabel
          Left = 7
          Top = 13
          Width = 58
          Height = 14
          Alignment = taRightJustify
          Caption = 'Tipo Pr'#234'mio:'
        end
        object ColorLabel1: TColorLabel
          Left = 108
          Top = 13
          Width = 214
          Height = 14
          Caption = '(V)alor Fixo (P)ercentual Sobre Faturamento'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          CorDestaque = clRed
        end
        object edtTipPreMeta1: TDBEditFocus
          Tag = 99
          Left = 69
          Top = 10
          Width = 35
          Height = 22
          CharCase = ecUpperCase
          DataField = 'MDV_TPPRE1'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 0
          OnExit = edtTipPreMeta1Exit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
      end
    end
    object tbsMeta2: TTabSheet
      Caption = 'Meta &2 - Faixas de Devolu'#231#227'o'
      ImageIndex = 1
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 1010
        Height = 41
        Align = alTop
        TabOrder = 0
        object Label1: TLabel
          Left = 7
          Top = 13
          Width = 58
          Height = 14
          Alignment = taRightJustify
          Caption = 'Tipo Pr'#234'mio:'
        end
        object ColorLabel2: TColorLabel
          Left = 108
          Top = 13
          Width = 214
          Height = 14
          Caption = '(V)alor Fixo (P)ercentual Sobre Faturamento'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          CorDestaque = clRed
        end
        object edtTipPreMeta2: TDBEditFocus
          Tag = 99
          Left = 69
          Top = 10
          Width = 35
          Height = 22
          CharCase = ecUpperCase
          DataField = 'MDV_TPPRE2'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 0
          OnExit = edtTipPreMeta2Exit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object btnDocDev: TBitBtnLocked
          Left = 848
          Top = 10
          Width = 137
          Height = 25
          Caption = 'Documentos Devolu'#231#227'o'
          TabOrder = 1
          OnClick = btnDocDevClick
        end
      end
      object Panel4: TPanel
        Left = 0
        Top = 41
        Width = 1010
        Height = 519
        Align = alClient
        TabOrder = 1
        object grdMeta2: TcxGridCitel
          Left = 1
          Top = 42
          Width = 1008
          Height = 476
          Align = alClient
          TabOrder = 1
          LookAndFeel.ScrollbarMode = sbmClassic
          object grdMeta2Tv: TcxGridDBTableViewCitel
            OnKeyDown = grdMeta1TvKeyDown
            Navigator.Buttons.CustomButtons = <>
            DataController.DataSource = dtsMT2
            DataController.Filter.Options = [fcoCaseInsensitive]
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            FilterRow.InfoText = 'Clique aqui para definir um filtro'
            FilterRow.ApplyChanges = fracDelayed
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
            OptionsView.GroupByBox = False
            Zebra = False
            Destaque = False
            CorZebra = clMoneyGreen
            object grdMeta2TvVALINI: TcxGridDBColumn
              Caption = 'Percentual Inicial'
              DataBinding.FieldName = 'MT2_VALINI'
              Width = 120
            end
            object grdMeta2TvVALFIN: TcxGridDBColumn
              Caption = 'Percentual Final'
              DataBinding.FieldName = 'MT2_VALFIN'
              Width = 120
            end
            object grdMeta2TvVALPRE: TcxGridDBColumn
              Caption = 'Valor Pr'#234'mio'
              DataBinding.FieldName = 'MT2_VALPRE'
              Width = 120
            end
          end
          object grdMeta2Lvl: TcxGridLevel
            GridView = grdMeta2Tv
          end
        end
        object Panel11: TPanel
          Left = 1
          Top = 1
          Width = 1008
          Height = 41
          Align = alTop
          TabOrder = 0
          object lblIniMt2: TLabel
            Left = 8
            Top = 15
            Width = 90
            Height = 14
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Percentual Inicial:'
          end
          object lblFinMt2: TLabel
            Left = 171
            Top = 15
            Width = 90
            Height = 14
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Percentual Final:'
          end
          object lblPreMt2: TLabel
            Left = 338
            Top = 15
            Width = 90
            Height = 14
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Valor Pr'#234'mio:'
          end
          object btnAdicionarMeta2: TBitBtnLocked
            Left = 508
            Top = 11
            Width = 75
            Height = 22
            Caption = '&Adicionar'
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
            OnClick = btnAdicionarMeta2Click
          end
          object btnCancelarMeta2: TBitBtnLocked
            Left = 582
            Top = 11
            Width = 75
            Height = 22
            Caption = 'Ca&ncelar'
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
            OnClick = btnCancelarMeta2Click
          end
          object edtValIniMT2: TEditFocus
            Tag = 99
            Left = 104
            Top = 11
            Width = 70
            Height = 22
            Alignment = taRightJustify
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 0
            Text = '0,00'
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtValFinMT2: TEditFocus
            Tag = 99
            Left = 267
            Top = 11
            Width = 70
            Height = 22
            Alignment = taRightJustify
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 1
            Text = '0,00'
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtValPreMT2: TEditFocus
            Tag = 99
            Left = 433
            Top = 11
            Width = 70
            Height = 22
            Alignment = taRightJustify
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 2
            Text = '0,00'
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
    end
    object tbsMeta3: TTabSheet
      Caption = 'Meta &3 - Produtos Alvos'
      ImageIndex = 2
      object Panel5: TPanel
        Left = 0
        Top = 41
        Width = 1010
        Height = 519
        Align = alClient
        TabOrder = 1
        object grdMeta3: TcxGridCitel
          Left = 1
          Top = 1
          Width = 1008
          Height = 517
          Align = alClient
          TabOrder = 0
          LookAndFeel.ScrollbarMode = sbmClassic
          object grdMeta3Tv: TcxGridDBTableViewCitel
            OnKeyDown = grdMeta1TvKeyDown
            Navigator.Buttons.CustomButtons = <>
            DataController.DataSource = dtsMT3
            DataController.Filter.Options = [fcoCaseInsensitive]
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            FilterRow.InfoText = 'Clique aqui para definir um filtro'
            FilterRow.ApplyChanges = fracDelayed
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Inserting = False
            OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
            OptionsView.GroupByBox = False
            Zebra = False
            Destaque = False
            CorZebra = clMoneyGreen
            object grdMeta3TvCODITE: TcxGridDBColumn
              Caption = 'C'#243'digo'
              DataBinding.FieldName = 'MT3_CODITE'
              Options.Editing = False
              Width = 80
            end
            object grdMeta3TvDESITE: TcxGridDBColumn
              Caption = 'Descri'#231#227'o Item'
              DataBinding.FieldName = 'MT3_DESITE'
              Options.Editing = False
              Width = 400
            end
            object grdMeta3TvVALMET: TcxGridDBColumn
              Caption = 'Valor Meta'
              DataBinding.FieldName = 'MT3_VALMET'
              Width = 120
            end
            object grdMeta3TvVALPRE: TcxGridDBColumn
              Caption = 'Valor Pr'#234'mio'
              DataBinding.FieldName = 'MT3_VALPRE'
              Width = 120
            end
          end
          object grdMeta3Lvl: TcxGridLevel
            GridView = grdMeta3Tv
          end
        end
      end
      object Panel6: TPanel
        Left = 0
        Top = 0
        Width = 1010
        Height = 41
        Align = alTop
        TabOrder = 0
        object Label6: TLabel
          Left = 7
          Top = 13
          Width = 58
          Height = 14
          Alignment = taRightJustify
          Caption = 'Tipo Pr'#234'mio:'
        end
        object ColorLabel3: TColorLabel
          Left = 108
          Top = 13
          Width = 214
          Height = 14
          Caption = '(V)alor Fixo (P)ercentual Sobre Faturamento'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          CorDestaque = clRed
        end
        object edtTipPreMeta3: TDBEditFocus
          Tag = 99
          Left = 69
          Top = 10
          Width = 35
          Height = 22
          CharCase = ecUpperCase
          DataField = 'MDV_TPPRE3'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 0
          OnExit = edtTipPreMeta3Exit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object btnPesqProdutos: TBitBtnLocked
          Left = 872
          Top = 10
          Width = 109
          Height = 25
          Caption = 'Pesquisa Produtos'
          TabOrder = 1
          OnClick = btnPesqProdutosClick
        end
      end
    end
    object tbsMeta4: TTabSheet
      Caption = 'Meta &4 - Linha/Grupo de Produtos'
      ImageIndex = 3
      object Panel7: TPanel
        Left = 0
        Top = 41
        Width = 1010
        Height = 519
        Align = alClient
        TabOrder = 1
        object grdMeta4: TcxGridCitel
          Left = 1
          Top = 1
          Width = 1008
          Height = 517
          Align = alClient
          TabOrder = 0
          LookAndFeel.ScrollbarMode = sbmClassic
          object grdMeta4Tv: TcxGridDBTableViewCitel
            OnKeyDown = grdMeta1TvKeyDown
            Navigator.Buttons.CustomButtons = <>
            DataController.DataSource = dtsMT4
            DataController.Filter.Options = [fcoCaseInsensitive]
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            FilterRow.InfoText = 'Clique aqui para definir um filtro'
            FilterRow.ApplyChanges = fracDelayed
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Inserting = False
            OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
            OptionsView.GroupByBox = False
            Zebra = False
            Destaque = False
            CorZebra = clMoneyGreen
            object grdMeta4TvCODGRU: TcxGridDBColumn
              Caption = 'Linha/Grupo'
              DataBinding.FieldName = 'MT4_CODGRU'
              Options.Editing = False
              Width = 80
            end
            object grdMeta4TvDESGRU: TcxGridDBColumn
              Caption = 'Descri'#231#227'o Linha/Grupo'
              DataBinding.FieldName = 'MT4_DESGRU'
              Options.Editing = False
              Width = 140
            end
            object grdMeta4TvMED12M: TcxGridDBColumn
              Caption = 'M'#233'dia Venda 12 Meses'
              DataBinding.FieldName = 'MT4_MED12M'
              Options.Editing = False
              Width = 120
            end
            object grdMeta4TvMED03M: TcxGridDBColumn
              Caption = 'M'#233'dia Venda 3 Meses'
              DataBinding.FieldName = 'MT4_MED03M'
              Options.Editing = False
              Width = 120
            end
            object grdMeta4TvACU12M: TcxGridDBColumn
              Caption = '% Acumulado 12 Meses'
              DataBinding.FieldName = 'MT4_ACU12M'
              Options.Editing = False
              Width = 120
            end
            object grdMeta4TvACU03M: TcxGridDBColumn
              Caption = '% Acumulado 3 Meses'
              DataBinding.FieldName = 'MT4_ACU03M'
              Options.Editing = False
              Width = 120
            end
            object grdMeta4TvEVOLUC: TcxGridDBColumn
              Caption = '% Evolu'#231#227'o'
              DataBinding.FieldName = 'MT4_EVOLUC'
              Options.Editing = False
              Width = 80
            end
            object grdMeta4TvVALMET: TcxGridDBColumn
              Caption = 'Valor Meta'
              DataBinding.FieldName = 'MT4_VALMET'
              Width = 100
            end
            object grdMeta4TvVALPRE: TcxGridDBColumn
              Caption = 'Valor Pr'#234'mio'
              DataBinding.FieldName = 'MT4_VALPRE'
              Width = 100
            end
          end
          object grdMeta4Lvl: TcxGridLevel
            GridView = grdMeta4Tv
          end
        end
      end
      object Panel8: TPanel
        Left = 0
        Top = 0
        Width = 1010
        Height = 41
        Align = alTop
        TabOrder = 0
        object btnPesqLinGru: TBitBtnLocked
          Left = 856
          Top = 10
          Width = 125
          Height = 25
          Caption = 'Pesquisa Linha/Grupo'
          TabOrder = 0
          OnClick = btnPesqLinGruClick
        end
      end
    end
    object tbsMeta5: TTabSheet
      Caption = 'Meta &5 - Tickets'
      ImageIndex = 4
      object grdMT5Resumo: TcxGridCitel
        Left = 0
        Top = 0
        Width = 1010
        Height = 97
        Align = alTop
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        object grdMT5ResumoTv: TcxGridDBTableViewCitel
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dtsMT5Resumo
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
          OptionsView.GroupByBox = False
          Zebra = False
          Destaque = False
          CorZebra = clMoneyGreen
          object grdMT5ResumoTvPERIOD: TcxGridDBColumn
            Caption = 'Per'#237'odo'
            DataBinding.FieldName = 'PERIOD'
            Width = 100
          end
          object grdMT5ResumoTvTOTTIC: TcxGridDBColumn
            Caption = 'Qtde Total de Tickets'
            DataBinding.FieldName = 'TOTTIC'
            Width = 120
          end
          object grdMT5ResumoTvDIAUTI: TcxGridDBColumn
            Caption = 'Qtde Dias '#218'teis'
            DataBinding.FieldName = 'DIAUTI'
            Width = 90
          end
          object grdMT5ResumoTvTICDIA: TcxGridDBColumn
            Caption = 'Qtde M'#233'dia de Tickets por Dia'
            DataBinding.FieldName = 'TICDIA'
            Width = 160
          end
          object grdMT5ResumoTvTICMES: TcxGridDBColumn
            Caption = 'Qtde M'#233'dia de Tickets por M'#234's'
            DataBinding.FieldName = 'TICMES'
            Width = 160
          end
          object grdMT5ResumoTvUTIMES: TcxGridDBColumn
            Caption = 'Qtde Dias '#218'teis no M'#234's Atual'
            DataBinding.FieldName = 'UTIMES'
            Width = 160
          end
          object grdMT5ResumoTvSUGMES: TcxGridDBColumn
            Caption = 'Qtde Sugest'#227'o para M'#234's'
            DataBinding.FieldName = 'SUGMES'
            Width = 140
          end
        end
        object grdMT5ResumoLvl: TcxGridLevel
          GridView = grdMT5ResumoTv
        end
      end
      object grdMeta5: TcxGridCitel
        Left = 0
        Top = 133
        Width = 1010
        Height = 427
        Align = alClient
        TabOrder = 2
        LookAndFeel.ScrollbarMode = sbmClassic
        object grdMeta5Tv: TcxGridDBTableViewCitel
          OnKeyDown = grdMeta1TvKeyDown
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dtsMT5
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
          OptionsView.GroupByBox = False
          Zebra = False
          Destaque = False
          CorZebra = clMoneyGreen
          object grdMeta5TvQTDINI: TcxGridDBColumn
            Caption = 'Qtde Inicial Tickets'
            DataBinding.FieldName = 'MT5_QTDINI'
            Width = 120
          end
          object grdMeta5TvQTDFIN: TcxGridDBColumn
            Caption = 'Qtde Final Tickets'
            DataBinding.FieldName = 'MT5_QTDFIN'
            Width = 120
          end
          object grdMeta5TvVALPRE: TcxGridDBColumn
            Caption = 'Valor Pr'#234'mio'
            DataBinding.FieldName = 'MT5_VALPRE'
            Width = 120
          end
        end
        object grdMeta5Lvl: TcxGridLevel
          GridView = grdMeta5Tv
        end
      end
      object Panel9: TPanel
        Left = 0
        Top = 97
        Width = 1010
        Height = 36
        Align = alTop
        TabOrder = 1
        object Label2: TLabel
          Left = 8
          Top = 11
          Width = 94
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Qtde Inicial Tickets:'
        end
        object Label4: TLabel
          Left = 194
          Top = 11
          Width = 90
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Qtde Final Tickets:'
        end
        object Label5: TLabel
          Left = 358
          Top = 11
          Width = 90
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Valor Pr'#234'mio:'
        end
        object btnAdicionarMeta5: TBitBtnLocked
          Left = 532
          Top = 7
          Width = 75
          Height = 22
          Caption = '&Adicionar'
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
          OnClick = btnAdicionarMeta5Click
        end
        object btnCancelarMeta5: TBitBtnLocked
          Left = 606
          Top = 7
          Width = 75
          Height = 22
          Caption = 'Ca&ncelar'
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
          OnClick = btnCancelarMeta5Click
        end
        object edtQtdIniMt5: TEditFocus
          Tag = 99
          Left = 108
          Top = 7
          Width = 70
          Height = 22
          Alignment = taRightJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 0
          Text = '0'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0'
        end
        object edtQtdFinMt5: TEditFocus
          Tag = 99
          Left = 287
          Top = 7
          Width = 70
          Height = 22
          Alignment = taRightJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 1
          Text = '0'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0'
        end
        object edtValPreMt5: TEditFocus
          Tag = 99
          Left = 453
          Top = 7
          Width = 70
          Height = 22
          Alignment = taRightJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 2
          Text = '0,00'
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
  end
  object pnlDados: TPanel [3]
    Left = 0
    Top = 0
    Width = 1018
    Height = 103
    Align = alTop
    TabOrder = 0
    object lblMesAno: TLabel
      Left = 78
      Top = 31
      Width = 46
      Height = 14
      Caption = 'M'#234's/Ano:'
    end
    object lblCliDep: TLabel
      Left = 5
      Top = 54
      Width = 119
      Height = 14
      Alignment = taRightJustify
      Caption = 'Departamento Operador:'
    end
    object lblCodEmp: TLabel
      Left = 79
      Top = 77
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
    end
    object Label3: TLabel
      Left = 88
      Top = 7
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object edtNomDep: TEditFocus
      Left = 167
      Top = 49
      Width = 636
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
    object edtNomEmp: TEditFocus
      Left = 192
      Top = 72
      Width = 611
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
    object edtMesAno: TcxDBMaskEdit
      Tag = 99
      Left = 126
      Top = 26
      DataBinding.DataField = 'MDV_MESANO'
      DataBinding.DataSource = dtsTabela
      Properties.EditMask = '99/9999'
      TabOrder = 1
      Width = 87
    end
    object dbeCodMdv: TDBEditFocus
      Tag = 99
      Left = 126
      Top = 3
      Width = 87
      Height = 22
      CharCase = ecUpperCase
      DataField = 'MDV_CODMDV'
      DataSource = dtsTabela
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object edtCodDep: TDBEditFocus
      Tag = 99
      Left = 126
      Top = 49
      Width = 40
      Height = 22
      CharCase = ecUpperCase
      DataField = 'MDV_CODDEP'
      DataSource = dtsTabela
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 2
      OnExit = edtCodDepExit
      OnKeyPress = edtCodDepKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object edtCodEmp: TDBEditFocus
      Tag = 99
      Left = 126
      Top = 72
      Width = 65
      Height = 22
      CharCase = ecUpperCase
      DataField = 'MDV_CODEMP'
      DataSource = dtsTabela
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 4
      OnExit = edtCodEmpExit
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttAlfanumerico
    end
  end
  object cdsMT1: TUniClientDataSet
    Aggregates = <>
    IndexFieldNames = 'MT1_VALINI'
    Params = <>
    Left = 472
    Top = 340
    object cdsMT1AUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsMT1MT1_VALINI: TFloatField
      DisplayLabel = 'Valor Inicial'
      FieldName = 'MT1_VALINI'
      DisplayFormat = '#,##0.00'
    end
    object cdsMT1MT1_VALFIN: TFloatField
      FieldName = 'MT1_VALFIN'
      DisplayFormat = '#,##0.00'
    end
    object cdsMT1MT1_VALPRE: TFloatField
      FieldName = 'MT1_VALPRE'
      DisplayFormat = '#,##0.00'
    end
  end
  object dtsMT1: TDataSource
    DataSet = cdsMT1
    Left = 555
    Top = 340
  end
  object dtsTabela: TDataSource
    Left = 408
    Top = 16
  end
  object dtsMT2: TDataSource
    DataSet = cdsMT2
    Left = 555
    Top = 384
  end
  object cdsMT2: TUniClientDataSet
    Aggregates = <>
    IndexFieldNames = 'MT2_VALINI'
    Params = <>
    Left = 472
    Top = 384
    object cdsMT2AUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsMT2MT2_VALINI: TFloatField
      FieldName = 'MT2_VALINI'
      DisplayFormat = '##0.00 %'
    end
    object cdsMT2MT2_VALFIN: TFloatField
      FieldName = 'MT2_VALFIN'
      DisplayFormat = '##0.00 %'
    end
    object cdsMT2MT2_VALPRE: TFloatField
      FieldName = 'MT2_VALPRE'
      DisplayFormat = '#,##0.00'
    end
  end
  object cdsMT2DocsDev: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 472
    Top = 428
    object cdsMT2DocsDevSELECIONADO: TBooleanField
      FieldName = 'SELECIONADO'
    end
    object cdsMT2DocsDevDEV_NUMDOC: TStringField
      FieldName = 'DEV_NUMDOC'
      Size = 12
    end
    object cdsMT2DocsDevDEV_ESPDOC: TStringField
      FieldName = 'DEV_ESPDOC'
      Size = 2
    end
    object cdsMT2DocsDevDEV_CODEMP: TStringField
      FieldName = 'DEV_CODEMP'
      Size = 3
    end
    object cdsMT2DocsDevDEV_DOCUME: TStringField
      FieldName = 'DEV_DOCUME'
    end
    object cdsMT2DocsDevDEV_CLIENTE: TStringField
      FieldName = 'DEV_CLIENTE'
      Size = 70
    end
    object cdsMT2DocsDevDEV_DTAEMI: TDateField
      FieldName = 'DEV_DTAEMI'
    end
    object cdsMT2DocsDevDEV_VALDOC: TFloatField
      FieldName = 'DEV_VALDOC'
      DisplayFormat = '#,##0.00'
    end
  end
  object dtsMT2DocsDev: TDataSource
    DataSet = cdsMT2DocsDev
    Left = 555
    Top = 428
  end
  object cdsMT3: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 472
    Top = 472
    object cdsMT3AUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsMT3MT3_CODITE: TStringField
      FieldName = 'MT3_CODITE'
      Size = 5
    end
    object cdsMT3MT3_DESITE: TStringField
      FieldName = 'MT3_DESITE'
      Size = 70
    end
    object cdsMT3MT3_VALMET: TFloatField
      FieldName = 'MT3_VALMET'
      DisplayFormat = '#,##0.00'
    end
    object cdsMT3MT3_VALPRE: TFloatField
      FieldName = 'MT3_VALPRE'
      DisplayFormat = '#,##0.00'
    end
  end
  object dtsMT3: TDataSource
    DataSet = cdsMT3
    Left = 555
    Top = 472
  end
  object cdsMT4: TUniClientDataSet
    Aggregates = <>
    Params = <>
    BeforePost = cdsMT4BeforePost
    Left = 472
    Top = 520
    object cdsMT4AUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsMT4MT4_CODGRU: TStringField
      FieldName = 'MT4_CODGRU'
      Size = 6
    end
    object cdsMT4MT4_DESGRU: TStringField
      FieldName = 'MT4_DESGRU'
      Size = 70
    end
    object cdsMT4MT4_MED12M: TFloatField
      FieldName = 'MT4_MED12M'
      DisplayFormat = '#,##0.00'
    end
    object cdsMT4MT4_MED03M: TFloatField
      FieldName = 'MT4_MED03M'
      DisplayFormat = '#,##0.00'
    end
    object cdsMT4MT4_ACU12M: TFloatField
      FieldName = 'MT4_ACU12M'
      DisplayFormat = '#,##0.00 %'
    end
    object cdsMT4MT4_ACU03M: TFloatField
      FieldName = 'MT4_ACU03M'
      DisplayFormat = '#,##0.00 %'
    end
    object cdsMT4MT4_EVOLUC: TFloatField
      FieldName = 'MT4_EVOLUC'
      DisplayFormat = '#,##0.00 %'
    end
    object cdsMT4MT4_VALMET: TFloatField
      FieldName = 'MT4_VALMET'
      DisplayFormat = '#,##0.00'
    end
    object cdsMT4MT4_VALPRE: TFloatField
      FieldName = 'MT4_VALPRE'
      DisplayFormat = '#,##0.00'
    end
  end
  object dtsMT4: TDataSource
    DataSet = cdsMT4
    Left = 555
    Top = 520
  end
  object cdsMT5Resumo: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 472
    Top = 568
    object cdsMT5ResumoPERIOD: TStringField
      FieldName = 'PERIOD'
    end
    object cdsMT5ResumoTOTTIC: TFloatField
      FieldName = 'TOTTIC'
    end
    object cdsMT5ResumoDIAUTI: TFloatField
      FieldName = 'DIAUTI'
    end
    object cdsMT5ResumoTICDIA: TFloatField
      FieldName = 'TICDIA'
      DisplayFormat = '#,##0.00'
    end
    object cdsMt5ResumoTICMES: TFloatField
      FieldName = 'TICMES'
      DisplayFormat = '#,##0.00'
    end
    object cdsMT5ResumoUTIMES: TIntegerField
      FieldName = 'UTIMES'
    end
    object cdsMT5ResumoSUGMES: TFloatField
      FieldName = 'SUGMES'
      DisplayFormat = '#,##0.00'
    end
  end
  object dtsMT5Resumo: TDataSource
    DataSet = cdsMT5Resumo
    Left = 556
    Top = 568
  end
  object cdsMT5: TUniClientDataSet
    Aggregates = <>
    IndexFieldNames = 'MT5_QTDINI'
    Params = <>
    Left = 472
    Top = 616
    object cdsMT5AUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsMT5MT5_QTDINI: TFloatField
      FieldName = 'MT5_QTDINI'
      DisplayFormat = '##0'
    end
    object cdsMt5Mt5_QTDFIN: TFloatField
      FieldName = 'MT5_QTDFIN'
      DisplayFormat = '##0'
    end
    object cdsMT5MT5_VALPRE: TFloatField
      FieldName = 'MT5_VALPRE'
      DisplayFormat = '#,##0.00'
    end
  end
  object dtsMT5: TDataSource
    DataSet = cdsMT5
    Left = 555
    Top = 616
  end
end
