inherited frmDigRecursosProjeto: TfrmDigRecursosProjeto
  Width = 920
  Height = 600
  BorderIcons = [biSystemMenu, biMinimize, biMaximize]
  Caption = 'Digita'#231#227'o de Apontamentos de Recursos Alocados'
  OnDestroy = FormDestroy
  ExplicitWidth = 920
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 527
    Width = 914
    ExplicitTop = 527
    ExplicitWidth = 914
    inherited FlwBotoes: TFlowPanel
      Width = 828
      ExplicitTop = 2
      ExplicitWidth = 910
      inherited btnIncluir: TBitBtnLocked
        Width = 83
        ExplicitWidth = 83
      end
      inherited btnGravar: TBitBtnLocked
        Left = 83
        Width = 83
        ExplicitLeft = 83
        ExplicitWidth = 83
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 166
        Width = 83
        ExplicitLeft = 166
        ExplicitWidth = 83
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 249
        Width = 83
        ExplicitLeft = 249
        ExplicitWidth = 83
      end
      inherited btnCancela: TBitBtnLocked
        Left = 332
        Width = 83
        ExplicitLeft = 332
        ExplicitWidth = 83
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 415
        Width = 83
        ExplicitLeft = 415
        ExplicitWidth = 83
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 830
      Width = 82
      Height = 24
      Align = alRight
      ExplicitLeft = 819
      ExplicitWidth = 82
      ExplicitHeight = 20
    end
  end
  inherited pgcDados: TPageControl
    Width = 914
    Height = 527
    Visible = False
    ExplicitWidth = 914
    ExplicitHeight = 527
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 906
      ExplicitHeight = 495
    end
  end
  inherited pnlStatus: TPanel
    Top = 555
    Width = 914
    ExplicitTop = 555
    ExplicitWidth = 914
    inherited pnlNomeForm: TPanel
      Left = 727
      Width = 187
      ExplicitLeft = 727
      ExplicitWidth = 187
    end
    inherited pnlInfo: TPanel
      Width = 727
      ExplicitWidth = 727
    end
  end
  object pnlFundo: TPanel [4]
    Left = 0
    Top = 0
    Width = 914
    Height = 527
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 4
    object pnlLancamento: TPanel
      Left = 0
      Top = 63
      Width = 914
      Height = 464
      Align = alClient
      TabOrder = 1
      object pnlGrid: TPanel
        Left = 1
        Top = 129
        Width = 912
        Height = 334
        Align = alClient
        BevelOuter = bvNone
        Padding.Top = 5
        TabOrder = 1
        object cxgGridProDet: TcxGrid
          Left = 0
          Top = 5
          Width = 912
          Height = 329
          Align = alClient
          Enabled = False
          TabOrder = 0
          OnExit = cxgGridProDetExit
          LookAndFeel.ScrollbarMode = sbmClassic
          object cxgGridProDetView: TcxGridDBTableView
            OnKeyDown = cxgGridProDetViewKeyDown
            OnKeyPress = cxgGridProDetViewKeyPress
            OnKeyUp = cxgGridProDetViewKeyUp
            Navigator.Buttons.CustomButtons = <>
            OnCellClick = cxgGridProDetViewCellClick
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsData.CancelOnExit = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsView.NoDataToDisplayInfoText = '  '
            OptionsView.GroupByBox = False
            Preview.AutoHeight = False
            object cxgColCodRep: TcxGridDBColumn
              Caption = 'Recurso'
              DataBinding.FieldName = 'DET_CODREP'
              Options.Editing = False
              Width = 59
            end
            object cxgColDescri: TcxGridDBColumn
              Caption = 'Descri'#231#227'o'
              DataBinding.FieldName = 'DET_NOMREP'
              Options.Editing = False
              Width = 286
            end
            object cxgColDtaIni: TcxGridDBColumn
              Caption = 'Data Inicial'
              DataBinding.FieldName = 'DET_DTAINI'
              PropertiesClassName = 'TcxTextEditProperties'
            end
            object cxgColDtaFin: TcxGridDBColumn
              Caption = 'Data Final'
              DataBinding.FieldName = 'DET_DTAFIN'
              PropertiesClassName = 'TcxTextEditProperties'
            end
            object cxgColQtdHor: TcxGridDBColumn
              Caption = 'Hora(s)'
              DataBinding.FieldName = 'DET_QTDHOR'
              DateTimeGrouping = dtgByHour
              Options.AutoWidthSizable = False
              Width = 63
            end
            object cxgColKmIni: TcxGridDBColumn
              Caption = 'Km Inicial'
              DataBinding.FieldName = 'DET_KMTINI'
            end
            object cxgColKmFin: TcxGridDBColumn
              Caption = 'Km Final'
              DataBinding.FieldName = 'DET_KMTFIN'
            end
            object cxgColQuant: TcxGridDBColumn
              Caption = 'Quantidade'
              DataBinding.FieldName = 'DET_QUANTI'
            end
            object cxgColObserv: TcxGridDBColumn
              Caption = 'Observa'#231#227'o'
              DataBinding.FieldName = 'DET_OBSERV'
              Width = 155
            end
          end
          object cxgcxgGridProDet: TcxGridLevel
            GridView = cxgGridProDetView
          end
        end
      end
      object pnlCampos: TPanel
        Left = 1
        Top = 1
        Width = 912
        Height = 128
        Align = alTop
        BevelOuter = bvLowered
        TabOrder = 0
        object pnlCamposRecurso: TPanel
          Left = 1
          Top = 1
          Width = 415
          Height = 126
          Align = alLeft
          BevelOuter = bvNone
          TabOrder = 0
          object pnlRecurso: TPanel
            Left = 0
            Top = 0
            Width = 415
            Height = 29
            Align = alTop
            BevelOuter = bvNone
            Color = 16770261
            ParentBackground = False
            TabOrder = 0
            object lblCndPag: TLabel
              Left = 41
              Top = 10
              Width = 44
              Height = 14
              Alignment = taRightJustify
              Caption = 'Recurso:'
            end
            object shpRec: TShape
              Left = 86
              Top = 6
              Width = 5
              Height = 22
              Brush.Color = clGreen
            end
            object edtCodRep: TEditFocus
              Tag = 99
              Left = 92
              Top = 6
              Width = 63
              Height = 22
              Alignment = taLeftJustify
              CharCase = ecUpperCase
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 6
              TabOrder = 0
              OnEnter = edtCodRepEnter
              OnKeyPress = edtCodRepKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              TamCampo = 6
              TipoTexto = ttNumerico
            end
            object edtNomRep: TEditFocus
              Left = 157
              Top = 6
              Width = 237
              Height = 22
              TabStop = False
              Alignment = taLeftJustify
              Color = 16768952
              Enabled = False
              ImeName = 'Portugu'#234's (Brasil ABNT)'
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
            object Panel1: TPanel
              Left = 76
              Top = 60
              Width = 185
              Height = 41
              BevelOuter = bvNone
              Caption = 'Panel1'
              TabOrder = 2
            end
          end
          object pnlDataHora: TPanel
            Left = 0
            Top = 29
            Width = 415
            Height = 24
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 1
            object Label3: TLabel
              Left = 4
              Top = 5
              Width = 83
              Height = 14
              Alignment = taRightJustify
              Caption = 'Data/ Hora Inicial:'
            end
            object Label4: TLabel
              Left = 213
              Top = 6
              Width = 79
              Height = 14
              Alignment = taRightJustify
              Caption = 'Data/ Hora Final:'
            end
            object mskDtaIni: TMaskEditFocus
              Tag = 99
              Left = 92
              Top = 1
              Width = 63
              Height = 22
              EditMask = '99/99/9999;1;_'
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 10
              TabOrder = 0
              Text = '  /  /    '
              OnExit = mskDtaIniExit
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              ValidaData = True
            end
            object mskHorIni: TMaskEditFocus
              Tag = 99
              Left = 157
              Top = 1
              Width = 34
              Height = 22
              EditMask = '!99:99;1;_'
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 5
              TabOrder = 1
              Text = '  :  '
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              ValidaData = False
            end
            object mskDtaFin: TMaskEditFocus
              Tag = 99
              Left = 295
              Top = 1
              Width = 62
              Height = 22
              EditMask = '99/99/9999;1;_'
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 10
              TabOrder = 2
              Text = '  /  /    '
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              ValidaData = True
            end
            object mskHorFin: TMaskEditFocus
              Tag = 99
              Left = 360
              Top = 1
              Width = 34
              Height = 22
              EditMask = '!99:99;1;_'
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 5
              TabOrder = 3
              Text = '  :  '
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              ValidaData = False
            end
          end
          object pnlKm: TPanel
            Left = 0
            Top = 53
            Width = 415
            Height = 24
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 2
            Visible = False
            object Label5: TLabel
              Left = 39
              Top = 5
              Width = 47
              Height = 14
              Alignment = taRightJustify
              Caption = 'Km Inicial:'
            end
            object Label6: TLabel
              Left = 282
              Top = 6
              Width = 43
              Height = 14
              Alignment = taRightJustify
              Caption = 'Km Final:'
            end
            object edtKmIni: TEditFocus
              Tag = 99
              Left = 92
              Top = 1
              Width = 63
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
              ParentFont = False
              TabOrder = 0
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
              EditFormat = '#,##0'
            end
            object edtKmFin: TEditFocus
              Tag = 99
              Left = 328
              Top = 1
              Width = 66
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
              ParentFont = False
              TabOrder = 1
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
              EditFormat = '#,##0'
            end
          end
          object pnlQuantidade: TPanel
            Left = 0
            Top = 77
            Width = 415
            Height = 24
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 3
            Visible = False
            object Label7: TLabel
              Left = 289
              Top = 5
              Width = 36
              Height = 14
              Alignment = taRightJustify
              Caption = 'Di'#225'rias:'
            end
            object Label11: TLabel
              Left = 35
              Top = 7
              Width = 54
              Height = 14
              Alignment = taRightJustify
              Caption = 'Data Inicial:'
            end
            object Label12: TLabel
              Left = 165
              Top = 7
              Width = 50
              Height = 14
              Alignment = taRightJustify
              Caption = 'Data Final:'
            end
            object edtQuant: TEditFocus
              Tag = 99
              Left = 331
              Top = 1
              Width = 63
              Height = 22
              TabStop = False
              Alignment = taRightJustify
              CharCase = ecUpperCase
              Enabled = False
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
              TamCampo = 0
              TipoTexto = ttNumerico
              EditFormat = '#,##0'
            end
            object dtaIniDia: TMaskEditFocus
              Tag = 99
              Left = 92
              Top = 1
              Width = 63
              Height = 22
              EditMask = '99/99/9999;1;_'
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 10
              TabOrder = 0
              Text = '  /  /    '
              OnExit = mskDtaIniExit
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              ValidaData = True
            end
            object dtaFinDia: TMaskEditFocus
              Tag = 99
              Left = 218
              Top = 1
              Width = 62
              Height = 22
              EditMask = '99/99/9999;1;_'
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 10
              TabOrder = 1
              Text = '  /  /    '
              OnExit = dtaFinDiaExit
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              ValidaData = True
            end
          end
          object pnlObs: TPanel
            Left = 0
            Top = 100
            Width = 415
            Height = 26
            Align = alBottom
            BevelOuter = bvNone
            TabOrder = 4
            object Label10: TLabel
              Left = 23
              Top = 5
              Width = 63
              Height = 14
              Alignment = taRightJustify
              Caption = 'Observa'#231#227'o:'
            end
            object edtObs: TEditFocus
              Tag = 99
              Left = 92
              Top = 2
              Width = 302
              Height = 22
              Alignment = taLeftJustify
              CharCase = ecUpperCase
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 50
              TabOrder = 0
              OnEnter = edtCodRepEnter
              OnKeyPress = edtCodRepKeyPress
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
        object pnlBotoesRecurso: TPanel
          Left = 422
          Top = 5
          Width = 226
          Height = 47
          BevelOuter = bvNone
          TabOrder = 1
          object btnIncCli: TBitBtnLocked
            Left = 14
            Top = 3
            Width = 74
            Height = 22
            Caption = 'C&onfirmar'
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
            TabOrder = 0
            OnClick = btnIncCliClick
          end
          object btnCancelCli: TBitBtnLocked
            Left = 94
            Top = 3
            Width = 74
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
            TabOrder = 1
            OnClick = btnCancelCliClick
          end
        end
      end
    end
    object pnlDados: TPanel
      Left = 0
      Top = 0
      Width = 914
      Height = 63
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object Label1: TLabel
        Left = 11
        Top = 14
        Width = 36
        Height = 14
        Alignment = taRightJustify
        Caption = 'Projeto:'
      end
      object Label2: TLabel
        Left = 12
        Top = 38
        Width = 35
        Height = 14
        Alignment = taRightJustify
        Caption = 'Cliente:'
      end
      object Label8: TLabel
        Left = 361
        Top = 14
        Width = 50
        Height = 14
        Alignment = taRightJustify
        Caption = ' Cadastro:'
      end
      object Label9: TLabel
        Left = 362
        Top = 38
        Width = 49
        Height = 14
        Alignment = taRightJustify
        Caption = 'Operador:'
      end
      object edtDesPrj: TEditFocus
        Left = 114
        Top = 11
        Width = 237
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
      object edtNomCli: TEditFocus
        Left = 114
        Top = 35
        Width = 237
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
      object edtNomOpe: TEditFocus
        Left = 479
        Top = 35
        Width = 170
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
      object dbeCodPrj: TDBEditFocus
        Tag = 99
        Left = 49
        Top = 11
        Width = 63
        Height = 22
        CharCase = ecUpperCase
        DataField = 'GER_CODPRJ'
        DataSource = dtsTabela
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnKeyPress = dbeCodPrjKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TipoTexto = ttNumerico
      end
      object dbeCodCli: TDBEditFocus
        Tag = 99
        Left = 49
        Top = 35
        Width = 63
        Height = 22
        CharCase = ecUpperCase
        DataField = 'GER_CODCLI'
        DataSource = dtsTabela
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnKeyPress = dbeCodCliKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TipoTexto = ttNumerico
      end
      object dbeDtaCad: TDBEditFocus
        Left = 417
        Top = 11
        Width = 60
        Height = 22
        CharCase = ecUpperCase
        Color = 16768952
        DataField = 'GER_DTACAD'
        DataSource = dtsTabela
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TipoTexto = ttNumerico
      end
      object dbeCodOpe: TDBEditFocus
        Left = 417
        Top = 35
        Width = 60
        Height = 22
        CharCase = ecUpperCase
        Color = 16768952
        DataField = 'GER_CODOPE'
        DataSource = dtsTabela
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 5
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TipoTexto = ttNumerico
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 504
    Top = 120
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 472
    Top = 120
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 544
    Top = 124
  end
  object dtsTabela: TDataSource
    Left = 412
    Top = 108
  end
end
