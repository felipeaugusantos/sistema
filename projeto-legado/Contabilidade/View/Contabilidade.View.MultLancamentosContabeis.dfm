inherited frmMultLancamentosContabeis: TfrmMultLancamentosContabeis
  Left = 326
  Top = 371
  Width = 700
  Height = 500
  BorderIcons = [biSystemMenu]
  Caption = 'Inclus'#227'o de Lan'#231'amentos de Partida M'#250'ltipla'
  Position = poScreenCenter
  OnDestroy = FormDestroy
  ExplicitTop = -108
  ExplicitWidth = 700
  ExplicitHeight = 500
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 426
    Width = 694
    Height = 26
    TabOrder = 1
    ExplicitTop = 429
    ExplicitWidth = 694
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 616
      Height = 22
      ExplicitLeft = 3
      ExplicitTop = 2
      ExplicitWidth = 616
      ExplicitHeight = 22
      object btnConfirmar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 95
        Height = 22
        Caption = '&Confirmar'
        Enabled = False
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
        OnClick = btnConfirmarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 618
      Top = 2
      Width = 74
      Align = alRight
      ExplicitLeft = 618
      ExplicitTop = 2
      ExplicitWidth = 74
    end
  end
  inherited pnlStatus: TPanel
    Top = 452
    Width = 694
    Height = 19
    TabOrder = 3
    ExplicitTop = 452
    ExplicitWidth = 694
    ExplicitHeight = 19
    inherited pnlNomeForm: TPanel
      Left = 523
      Height = 19
      TabOrder = 1
      ExplicitLeft = 523
    end
    inherited pnlInfo: TPanel
      Width = 523
      Height = 19
      TabOrder = 0
      ExplicitWidth = 523
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 694
    Height = 426
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 0
    ExplicitHeight = 429
    object pnlDados: TPanel
      Left = 2
      Top = 2
      Width = 690
      Height = 422
      Align = alClient
      TabOrder = 0
      ExplicitHeight = 425
      object pnlAddReg: TPanel
        Left = 1
        Top = 1
        Width = 688
        Height = 420
        Align = alClient
        Color = 16770261
        TabOrder = 0
        ExplicitHeight = 423
        object cxgDados: TcxGridCitel
          Left = 1
          Top = 92
          Width = 686
          Height = 312
          Align = alClient
          TabOrder = 1
          ExplicitHeight = 330
          object cxgDadosTableView: TcxGridDBTableViewCitel
            OnKeyDown = cxgDadosTableViewKeyDown
            Navigator.Buttons.CustomButtons = <>
            OnCellClick = cxgDadosTableViewCellClick
            DataController.DataSource = dtsDados
            DataController.Filter.Options = [fcoCaseInsensitive]
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            FilterRow.InfoText = 'Clique aqui para definir um filtro'
            FilterRow.ApplyChanges = fracDelayed
            OptionsBehavior.GoToNextCellOnEnter = True
            OptionsData.Deleting = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
            OptionsView.ColumnAutoWidth = True
            OptionsView.GroupByBox = False
            Zebra = False
            Destaque = False
            CorZebra = clMoneyGreen
            object cxgDadosTableViewCOD_DESVAL: TcxGridDBColumn
              Caption = 'Tipo'
              DataBinding.FieldName = 'DESTPL'
              Options.Editing = False
              Width = 76
            end
            object cxgDadosTableViewCOD_CONDEB: TcxGridDBColumn
              Caption = 'C'#243'digo Conta'
              DataBinding.FieldName = 'CONMSK'
              Width = 145
            end
            object cxgDadosTableViewCONTA_DEBITO: TcxGridDBColumn
              Caption = 'Conta'
              DataBinding.FieldName = 'DESCRI'
              Options.Editing = False
              Width = 159
            end
            object cxgDadosTableViewCONTA_CREDITO: TcxGridDBColumn
              Caption = 'Hist'#243'rico'
              DataBinding.FieldName = 'DESHIS'
              Options.Editing = False
              Width = 215
            end
            object cxgDadosTableViewVALLAN: TcxGridDBColumn
              Caption = 'Valor'
              DataBinding.FieldName = 'VALLAN'
              Width = 89
            end
          end
          object cxgDadosLevel1: TcxGridLevel
            GridView = cxgDadosTableView
          end
        end
        object pnlDadosDigitacao: TPanel
          Left = 1
          Top = 1
          Width = 686
          Height = 91
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object Label24: TLabel
            Left = 71
            Top = 11
            Width = 23
            Height = 14
            Alignment = taRightJustify
            Caption = 'Tipo:'
          end
          object Label1: TLabel
            Left = 63
            Top = 39
            Width = 31
            Height = 14
            Caption = 'Conta:'
          end
          object Label2: TLabel
            Left = 270
            Top = 12
            Width = 28
            Height = 14
            Caption = 'Valor:'
          end
          object Label8: TLabel
            Left = 49
            Top = 68
            Width = 45
            Height = 14
            Caption = 'Hist'#243'rico:'
          end
          object mskConta: TMaskEditFocus
            Left = 100
            Top = 35
            Width = 150
            Height = 22
            TabOrder = 2
            Text = ''
            OnExit = mskContaExit
            OnKeyPress = mskContaKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            ValidaData = False
          end
          object edtTipoLancamento: TComboBoxFocus
            Left = 100
            Top = 7
            Width = 150
            Height = 22
            Style = csDropDownList
            TabOrder = 0
            Items.Strings = (
              'D'#233'bito'
              'Cr'#233'dito')
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
          object btnAddReg: TBitBtnLocked
            Left = 533
            Top = 60
            Width = 28
            Height = 24
            Hint = 'Adicionar Conta!'
            Caption = '+'
            ParentShowHint = False
            ShowHint = True
            TabOrder = 6
            OnClick = btnAddRegClick
          end
          object edtDesConta: TEditFocus
            Left = 260
            Top = 35
            Width = 265
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
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
          object edtValor: TCurrencyEditFocus
            Left = 304
            Top = 7
            EditValue = 0.000000000000000000
            Properties.DisplayFormat = '0.00;-0.00'
            StyleFocused.Color = clInfoBk
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            Width = 107
          end
          object edtDesHisCre: TEditFocus
            Left = 132
            Top = 61
            Width = 393
            Height = 22
            Alignment = taLeftJustify
            Enabled = False
            TabOrder = 5
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtHisPad: TEditFocus
            Tag = 99
            Left = 100
            Top = 61
            Width = 30
            Height = 22
            Alignment = taLeftJustify
            MaxLength = 9
            TabOrder = 4
            OnExit = edtHisPadExit
            OnKeyPress = edtHisPadKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 9
            TipoTexto = ttAlfanumerico
          end
        end
        object pnlValores: TPanel
          Left = 1
          Top = 404
          Width = 686
          Height = 15
          Align = alBottom
          BevelOuter = bvNone
          Color = clGray
          Font.Charset = ANSI_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 2
          ExplicitTop = 408
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 640
    Top = 224
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 384
    Top = 128
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 432
    Top = 128
  end
  object dtsDados: TDataSource
    Left = 590
    Top = 160
  end
end
