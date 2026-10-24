inherited frmCadDefeitos: TfrmCadDefeitos
  Left = 319
  Top = 465
  Width = 576
  Height = 362
  Caption = 'Cadastro de Defeitos'
  OnDestroy = FormDestroy
  ExplicitWidth = 576
  ExplicitHeight = 362
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 292
    Width = 570
    Height = 25
    ExplicitTop = 292
    ExplicitWidth = 570
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 566
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 566
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 75
        ExplicitWidth = 75
      end
      inherited btnGravar: TBitBtnLocked
        Left = 75
        Width = 75
        ExplicitLeft = 75
        ExplicitWidth = 75
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 150
        Width = 75
        ExplicitLeft = 150
        ExplicitWidth = 75
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 225
        Width = 75
        ExplicitLeft = 225
        ExplicitWidth = 75
      end
      inherited btnCancela: TBitBtnLocked
        Left = 300
        Width = 75
        ExplicitLeft = 300
        ExplicitWidth = 75
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 375
        Width = 75
        ExplicitLeft = 375
        ExplicitWidth = 75
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 452
      Width = 67
      Height = 20
      ExplicitLeft = 452
      ExplicitWidth = 67
      ExplicitHeight = 20
    end
  end
  inherited pgcDados: TPageControl
    Width = 570
    Height = 292
    TabOrder = 3
    ExplicitWidth = 570
    ExplicitHeight = 292
    inherited tbsGeral: TTabSheet
      Caption = '&1 - Defeitos'
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 562
      ExplicitHeight = 260
      object pnlFundo: TPanel
        Left = 0
        Top = 0
        Width = 562
        Height = 260
        Align = alClient
        BevelOuter = bvNone
        Color = 16770261
        TabOrder = 0
        object Label2: TLabel
          Left = 11
          Top = 42
          Width = 52
          Height = 14
          Caption = 'Descri'#231#227'o:'
        end
        object Label1: TLabel
          Left = 26
          Top = 18
          Width = 36
          Height = 14
          Alignment = taRightJustify
          Caption = 'C'#243'digo:'
        end
        object dbeDescri: TDBEditFocus
          Tag = 99
          Left = 65
          Top = 38
          Width = 450
          Height = 22
          CharCase = ecUpperCase
          DataField = 'DFE_DESCRI'
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeCodigo: TDBEditFocus
          Tag = 99
          Left = 65
          Top = 14
          Width = 88
          Height = 22
          CharCase = ecUpperCase
          DataField = 'DFE_CODIGO'
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttNumerico
        end
      end
    end
    object tbsRelFab: TTabSheet
      Caption = 'Relacionamento com Fabricantes'
      Enabled = False
      ImageIndex = 1
      object pnlRelFab: TPanel
        Left = 0
        Top = 0
        Width = 562
        Height = 62
        Align = alTop
        ParentColor = True
        TabOrder = 0
        DesignSize = (
          562
          62)
        object lblAcessorio: TLabel
          Left = 9
          Top = 10
          Width = 54
          Height = 14
          Alignment = taRightJustify
          Caption = 'Fabricante:'
        end
        object lblDefeitos: TLabel
          Left = 20
          Top = 35
          Width = 43
          Height = 14
          Alignment = taRightJustify
          Caption = 'Defeitos:'
        end
        object btnCancelaRel: TBitBtnLocked
          Left = 463
          Top = 32
          Width = 95
          Height = 22
          Anchors = [akTop, akRight]
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
          OnClick = btnCancelaRelClick
        end
        object btnAdicionarRel: TBitBtnLocked
          Left = 463
          Top = 7
          Width = 95
          Height = 22
          Anchors = [akTop, akRight]
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
          OnClick = btnAdicionarRelClick
        end
        object cmbRelFab: TComboBoxFocus
          Left = 64
          Top = 7
          Width = 393
          Height = 22
          Style = csDropDownList
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 0
          OnChange = cmbRelFabChange
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
        object edtCodDfe: TEditFocus
          Tag = 99
          Left = 64
          Top = 32
          Width = 70
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 8
          TabOrder = 1
          OnKeyPress = edtCodDfeKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 8
          TipoTexto = ttNumerico
        end
        object edtDesDfe: TEditFocus
          Left = 139
          Top = 32
          Width = 318
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Anchors = [akLeft, akTop, akRight]
          CharCase = ecUpperCase
          Color = 16768952
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
      end
      object dbgGridDfeRel: TDBGridCitel
        Left = 0
        Top = 62
        Width = 562
        Height = 198
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
        OnKeyDown = dbgGridDfeRelKeyDown
        CorZebra = clMoneyGreen
        Zebra = False
        DestacarMouse = False
        Columns = <
          item
            Expanded = False
            FieldName = 'DESMAR'
            Title.Caption = 'Fabricante'
            Width = 126
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DFEFAB'
            Title.Caption = 'C'#243'd. Def.'
            Width = 62
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DESDFE'
            Title.Caption = 'Descri'#231#227'o'
            Width = 336
            Visible = True
          end>
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 317
    Width = 570
    ExplicitTop = 317
    ExplicitWidth = 570
    inherited pnlNomeForm: TPanel
      Left = 385
      Width = 185
      ExplicitLeft = 385
      ExplicitWidth = 185
    end
    inherited pnlInfo: TPanel
      Width = 385
      ExplicitWidth = 385
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 416
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 376
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 336
    Top = 0
  end
  object dtsDfeRel: TDataSource
    Left = 208
    Top = 236
  end
end
