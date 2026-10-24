inherited frmCadAtributos: TfrmCadAtributos
  Width = 626
  Height = 385
  Caption = 'Cadastro de Atributos'
  ExplicitWidth = 626
  ExplicitHeight = 385
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 312
    Width = 620
    TabOrder = 1
    ExplicitTop = 312
    ExplicitWidth = 620
    inherited FlwBotoes: TFlowPanel
      Width = 533
      ExplicitWidth = 533
      inherited btnIncluir: TBitBtnLocked
        Width = 77
        Height = 22
        ExplicitWidth = 77
        ExplicitHeight = 22
      end
      inherited btnGravar: TBitBtnLocked
        Left = 77
        Width = 77
        Height = 22
        ExplicitLeft = 77
        ExplicitWidth = 77
        ExplicitHeight = 22
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 154
        Width = 77
        Height = 22
        ExplicitLeft = 154
        ExplicitWidth = 77
        ExplicitHeight = 22
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 231
        Width = 77
        Height = 22
        ExplicitLeft = 231
        ExplicitWidth = 77
        ExplicitHeight = 22
      end
      inherited btnCancela: TBitBtnLocked
        Left = 308
        Width = 77
        Height = 22
        ExplicitLeft = 308
        ExplicitWidth = 77
        ExplicitHeight = 22
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 385
        Width = 77
        Height = 22
        ExplicitLeft = 385
        ExplicitWidth = 77
        ExplicitHeight = 22
      end
    end
    inherited btnSair: TBitBtnLocked
      AlignWithMargins = True
      Left = 538
      Margins.Top = 0
      Margins.Bottom = 2
      Align = alRight
      ExplicitLeft = 538
    end
  end
  inherited pgcDados: TPageControl
    Width = 620
    Height = 312
    TabOrder = 3
    ExplicitWidth = 620
    ExplicitHeight = 312
    inherited tbsGeral: TTabSheet
      ExplicitWidth = 612
      ExplicitHeight = 280
    end
  end
  inherited pnlStatus: TPanel
    Top = 340
    Width = 620
    TabOrder = 2
    ExplicitTop = 340
    ExplicitWidth = 620
    inherited pnlNomeForm: TPanel
      Left = 423
      Width = 197
      ExplicitLeft = 423
      ExplicitWidth = 197
    end
    inherited pnlInfo: TPanel
      Width = 423
      ExplicitWidth = 423
    end
  end
  object pnlDados: TPanel [4]
    Left = 0
    Top = 0
    Width = 620
    Height = 312
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 28
      Top = 10
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label2: TLabel
      Left = 12
      Top = 34
      Width = 52
      Height = 14
      Caption = 'Descri'#231#227'o:'
    end
    object lblNroDec: TLabel
      Left = 12
      Top = 253
      Width = 86
      Height = 14
      Alignment = taRightJustify
      Caption = 'N'#250'mero Decimais:'
    end
    object Label3: TLabel
      Left = 31
      Top = 58
      Width = 33
      Height = 14
      Alignment = taRightJustify
      Caption = 'Grupo:'
    end
    object dbeCodigo: TDBEditFocus
      Tag = 99
      Left = 66
      Top = 6
      Width = 47
      Height = 22
      CharCase = ecUpperCase
      DataField = 'ATR_CODIGO'
      DataSource = dtsCadAtr
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbeDescri: TDBEditFocus
      Tag = 99
      Left = 66
      Top = 30
      Width = 543
      Height = 22
      DataField = 'ATR_DESCRI'
      DataSource = dtsCadAtr
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeTipAtr: TDBRadioGroup
      Left = 66
      Top = 94
      Width = 185
      Height = 143
      Caption = 'Tipo de Dados'
      DataField = 'ATR_TIPATR'
      DataSource = dtsCadAtr
      Items.Strings = (
        '1 - Caracteres alfanum'#233'ricos'
        '2 - N'#250'mero inteiro'
        '3 - N'#250'mero decimal'
        '4 - Data'
        '5 - Intervalo de valores inteiros'
        '6 - Intervalo de valores decimais'
        '7 - Lista de op'#231#245'es')
      TabOrder = 3
      Values.Strings = (
        '1'
        '2'
        '3'
        '4'
        '5'
        '6'
        '7')
      OnChange = dbeTipAtrChange
    end
    object grbListaOpcoes: TGroupBox
      Left = 257
      Top = 94
      Width = 259
      Height = 211
      Caption = 'Lista de op'#231#245'es'
      TabOrder = 4
      object cxgOpcoes: TcxGrid
        Left = 14
        Top = 20
        Width = 231
        Height = 165
        TabOrder = 0
        object cxvOpcoes: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          NewItemRow.InfoText = 'Clique aqui para adicionar uma nova op'#231#227'o'
          NewItemRow.Visible = True
          OptionsBehavior.FocusFirstCellOnNewRecord = True
          OptionsBehavior.GoToNextCellOnEnter = True
          OptionsBehavior.FocusCellOnCycle = True
          OptionsCustomize.ColumnSorting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = ' '
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          object cxvOpcoesDescricao: TcxGridDBColumn
            Caption = 'Descri'#231#227'o da Op'#231#245'es'
            DataBinding.FieldName = 'DESCRI'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.CharCase = ecUpperCase
            HeaderAlignmentHorz = taCenter
            SortIndex = 0
            SortOrder = soAscending
          end
        end
        object cxgOpcoesLevel1: TcxGridLevel
          GridView = cxvOpcoes
        end
      end
      object btnDelOpcao: TBitBtnLocked
        Left = 75
        Top = 188
        Width = 110
        Height = 20
        Caption = 'Excluir &op'#231#227'o'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF00006E00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E0000
          6EFF00FFFF00FFFF00FFFF00FFFF00FF00006E001DE80010DC00006EFF00FFFF
          00FFFF00FFFF00FF00006E0004E20008E700006EFF00FFFF00FFFF00FFFF00FF
          00006E001AE2001FEB0010D900006EFF00FFFF00FF00006E0005DF0009EB0003
          DB00006EFF00FFFF00FFFF00FFFF00FFFF00FF00006E001ADF0020EB0013DC00
          006E00006E0005E2000BEB0004DA00006EFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FF00006E001BDF0022EB0012E60008EA0009EB0004DF00006EFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E001BE300
          16EB0011EB000ADF00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FF00006E0021E7001EEB001AEB0017DF00006EFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E062DE30430EB00
          20E2001EE20027EB0019DF00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF00006E0C35E40E3CEB052BDC00006E00006E001FDC002AEB001CDF0000
          6EFF00FFFF00FFFF00FFFF00FFFF00FF00006E1442E41645EB092ED900006EFF
          00FFFF00FF00006E0020D9012CEB001FE200006EFF00FFFF00FFFF00FFFF00FF
          00006E1C4BE71037DB00006EFF00FFFF00FFFF00FFFF00FF00006E0022DC0027
          E400006EFF00FFFF00FFFF00FFFF00FFFF00FF00006E00006EFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FF00006E00006EFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 1
        OnClick = btnDelOpcaoClick
      end
    end
    object dbeNroDec: TDBEditFocus
      Tag = 99
      Left = 100
      Top = 249
      Width = 27
      Height = 22
      CharCase = ecUpperCase
      DataField = 'ATR_NRODEC'
      DataSource = dtsCadAtr
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object dbeCodGru: TDBEditFocus
      Tag = 99
      Left = 66
      Top = 54
      Width = 47
      Height = 22
      CharCase = ecUpperCase
      DataField = 'ATR_CODGRU'
      DataSource = dtsCadAtr
      TabOrder = 2
      OnEnter = dbeCodGruEnter
      OnExit = dbeCodGruExit
      OnKeyPress = dbeCodGruKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
      OnChamaCadastro = dbeCodGruChamaCadastro
    end
    object edtDesGru: TEditFocus
      Left = 115
      Top = 54
      Width = 494
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
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 608
    Top = 72
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 600
    Top = 128
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 568
    Top = 128
  end
  object dtsCadAtr: TDataSource
    Left = 408
    Top = 8
  end
end
