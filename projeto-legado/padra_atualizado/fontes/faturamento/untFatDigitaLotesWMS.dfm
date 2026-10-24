inherited frmFatDigitaLotesWMS: TfrmFatDigitaLotesWMS
  Width = 750
  Height = 400
  BorderStyle = bsSizeable
  Caption = 'Informe os Lotes'
  ExplicitWidth = 750
  ExplicitHeight = 400
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 319
    Width = 734
    TabOrder = 1
    ExplicitTop = 319
    ExplicitWidth = 734
    object Bevel1: TBevel [0]
      Left = 561
      Top = 5
      Width = 1
      Height = 18
    end
    object Bevel2: TBevel [1]
      Left = 124
      Top = 5
      Width = 1
      Height = 18
    end
    inherited FlwBotoes: TFlowPanel
      Width = 653
      ExplicitWidth = 653
      inherited btnConfirma: TBitBtnLocked
        Width = 117
        Caption = '[ F10 ] Confirma'
        ExplicitWidth = 117
      end
      object btnLotIte: TBitBtnLocked
        Left = 117
        Top = 0
        Width = 148
        Height = 22
        Caption = '[ Alt + F6 ] Lotes do Item'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000100000008000000100000
          00170000001900000018000000120000000A0000000200000000000000000000
          00000000000000000000000000000000000403020117341B1476683528CE773D
          2DE8884332FF75392AE9622E22D13016107D0301011B00000005000000020000
          00090000000E0000000F00000012100807397F4738E3AE7F71FFBB9F94FF7458
          4DFF4E3023FF74584CFFB99D92FFA67467FF723729E40E060533000000088363
          57C0B58978FFB38776FFCCB4AAFF9F695AFFD9C2BBFFEAE0D9FF8D7162FF9C7F
          6FFF706159FF917667FF7C6154FFE1D4CDFFC8ACA2FF5F2D20CB0000000CB98F
          7EFFFBF5F1FFFAF2ECFFF1EDE9FFB58574FFF5EEEBFFF3E9E5FF755342FF907C
          71FF000000FF6B5D54FF72503EFFECE2DDFFDFD0CAFF7D3C2BF60000000CBE93
          81FFFBF6F3FFFAF3EEFFF5F1EEFFC09C8FFFE6D6D0FFF9F5F2FF9C8173FFEFE8
          CBFF938075FF9C7F6FFF917566FFF3ECE8FFD1BBB3FF622F23C80000000BC197
          86FFFBF7F4FFFAF4EFFFF9F4F1FFEAE1DEFFBC9384FFCDAC9FFFDCCAC3FFA287
          7AFF836352FFA2877AFFDAC7C0FFC19B8FFF763D2EE30E07052E0000000AC59C
          8BFFFCF8F6FFFBF5F1FFFBF4F0FFFAF7F3FFF2EFEDFFD5C2BBFFBD988AFFB68A
          7CFFB07C6AFFB18375FFB38A7CFFB6968BFF020101210000000400000009C9A0
          8FFFFCF9F6FFFBF5F2FFFBF5F2FFFBF6F2FFFBF5F2FFF8F5F3FFF5F1EFFFF1EE
          EDFFEFECEBFFF0EDEBFFF2EEECFFCDB1A7FF000000100000000000000008CCA4
          93FFFDF9F8FFFBF6F4FFFBF7F4FFFBF6F4FFFBF6F3FFFCF6F3FFFBF6F3FFFBF6
          F3FFFBF6F3FFFBF6F3FFFBF6F3FFBC907FFF0000000E0000000000000007C38A
          5BFFE4C299FFD3A26CFFD3A06AFFD39F68FFD29D65FFD19A64FFD19860FFD096
          5FFFCF945CFFCF935BFFCE915AFFB37240FF0000000D0000000000000007C58E
          5EFFEBCDA5FFDEB078FFDDAE76FFDDAD74FFDBAB72FFDBA971FFDAA76FFFD8A6
          6EFFD8A46BFFD6A26AFFD6A168FFB67744FF0000000C0000000000000006C690
          61FFECD0A7FFEBCDA5FFEACCA2FFEAC99EFFE8C79CFFE6C49AFFE6C296FFE5C0
          92FFE3BD8EFFE2B98BFFE0B788FFB97B49FF0000000B0000000000000003946C
          4AC0C79063FFC69062FFC58F61FFC58D5EFFC48C5DFFC38A5BFFC18859FFC087
          57FFBF8555FFBE8354FFBD8151FF8B5F3BC30000000700000000000000010000
          0003000000050000000500000006000000060000000700000007000000070000
          0008000000080000000800000008000000060000000200000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        TabOrder = 1
        OnClick = btnLotIteClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 655
      Top = 2
      Align = alRight
      ExplicitLeft = 655
      ExplicitTop = 2
    end
  end
  object pnlCabec: TPanel [2]
    Left = 0
    Top = 0
    Width = 734
    Height = 65
    Align = alTop
    BevelOuter = bvNone
    Enabled = False
    ParentColor = True
    TabOrder = 3
    object Label1: TLabel
      Left = 14
      Top = 38
      Width = 83
      Height = 14
      Alignment = taRightJustify
      Caption = 'Quantidade Total:'
    end
    object Label2: TLabel
      Left = 57
      Top = 15
      Width = 40
      Height = 14
      Alignment = taRightJustify
      Caption = 'Produto:'
    end
    object Label3: TLabel
      Left = 234
      Top = 38
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Situa'#231#227'o:'
    end
    object edtQtdIte: TEditFocus
      Left = 100
      Top = 32
      Width = 121
      Height = 22
      Alignment = taRightJustify
      Color = 16768952
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodIte: TEditFocus
      Left = 100
      Top = 9
      Width = 621
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtSituac: TEditFocus
      Left = 296
      Top = 32
      Width = 137
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object cxgItens: TcxGrid [3]
    Left = 0
    Top = 65
    Width = 734
    Height = 254
    Align = alClient
    TabOrder = 0
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgItensView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsItens
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Format = '#0.000'
          Kind = skSum
          FieldName = 'QTDITE'
          Column = cxgItensQTDITE
          DisplayText = 'Total transferido'
          VisibleForCustomization = False
        end>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.GoToNextCellOnEnter = True
      OptionsData.Deleting = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = ' '
      OptionsView.Footer = True
      OptionsView.GroupByBox = False
      object cxgItensNUMLOT: TcxGridDBColumn
        Caption = 'Lote'
        DataBinding.FieldName = 'NUMLOT'
        Options.Editing = False
        Width = 134
      end
      object cxgItensLOCFIS: TcxGridDBColumn
        Caption = 'Localiza'#231#227'o F'#237'sica'
        DataBinding.FieldName = 'LOCFIS'
        Options.Editing = False
        Width = 123
      end
      object cxgItensPICKIN: TcxGridDBColumn
        Caption = 'Picking?'
        DataBinding.FieldName = 'PICKIN'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 54
      end
      object cxgItensDTAVAL: TcxGridDBColumn
        Caption = 'Data Validade'
        DataBinding.FieldName = 'DTAVAL'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 99
      end
      object cxgItensSALDIS: TcxGridDBColumn
        Caption = 'Saldo Dispon'#237'vel'
        DataBinding.FieldName = 'SALDIS'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 100
      end
      object cxgItensQTDTOT: TcxGridDBColumn
        Caption = '(*) Total transferido'
        DataBinding.FieldName = 'QTDTOT'
        Visible = False
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 109
      end
      object cxgItensQTDITE: TcxGridDBColumn
        Caption = 'Quantidade'
        DataBinding.FieldName = 'QTDITE'
        HeaderAlignmentHorz = taRightJustify
        Width = 90
      end
      object cxgItensBROKER: TcxGridDBColumn
        Caption = 'Lote Broker'
        DataBinding.FieldName = 'BROKER'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        Properties.AutoSelect = False
        Properties.IncrementalSearch = False
        Properties.ReadOnly = True
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Options.Focusing = False
        Options.Sorting = False
        Width = 86
      end
    end
    object cxgItensLevel1: TcxGridLevel
      GridView = cxgItensView
    end
  end
  inherited pnlStatus: TPanel
    Top = 345
    Width = 734
    TabOrder = 2
    ExplicitTop = 345
    ExplicitWidth = 734
    inherited pnlNomeForm: TPanel
      Left = 563
      ExplicitLeft = 563
    end
    inherited pnlInfo: TPanel
      Width = 563
      ExplicitWidth = 563
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 120
    Top = 136
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 152
    Top = 136
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 88
    Top = 136
  end
  object dtsItens: TDataSource
    Left = 56
    Top = 136
  end
end
