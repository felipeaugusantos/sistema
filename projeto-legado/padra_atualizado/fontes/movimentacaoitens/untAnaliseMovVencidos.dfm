inherited frmAnaliseMovVencidos: TfrmAnaliseMovVencidos
  Width = 869
  Height = 431
  BorderStyle = bsSingle
  Caption = 'Lotes que n'#227'o foram analisados'
  ExplicitWidth = 869
  ExplicitHeight = 431
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 359
    Width = 863
    ExplicitTop = 359
    ExplicitWidth = 863
    inherited btnSair: TBitBtnLocked
      Left = 780
      ExplicitLeft = 780
    end
  end
  object pnlCadAna: TPanel [2]
    Left = 0
    Top = 0
    Width = 863
    Height = 65
    Align = alTop
    BevelOuter = bvNone
    Enabled = False
    ParentColor = True
    TabOrder = 2
    object Label7: TLabel
      Left = 37
      Top = 14
      Width = 39
      Height = 14
      Alignment = taRightJustify
      Caption = 'An'#225'lise:'
    end
    object Label1: TLabel
      Left = 5
      Top = 37
      Width = 71
      Height = 14
      Alignment = taRightJustify
      Caption = 'Periodocidade:'
    end
    object edtCodAna: TEditFocus
      Left = 82
      Top = 11
      Width = 586
      Height = 23
      TabStop = False
      Alignment = taLeftJustify
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtPeriod: TEditFocus
      Left = 82
      Top = 34
      Width = 71
      Height = 23
      TabStop = False
      Alignment = taRightJustify
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
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
  object cxgLotes: TcxGrid [3]
    Left = 0
    Top = 65
    Width = 863
    Height = 227
    Align = alClient
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgLotesView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsLotes
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsCustomize.ColumnSorting = False
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.GroupByBox = False
      object cxgLotesDTACAD: TcxGridDBColumn
        Caption = 'Data de Cadastro'
        DataBinding.FieldName = 'DTACAD'
        HeaderAlignmentHorz = taCenter
        SortIndex = 0
        SortOrder = soAscending
        Width = 135
      end
      object cxgLotesCODORD: TcxGridDBColumn
        Caption = 'Lote'
        DataBinding.FieldName = 'CODORD'
        HeaderAlignmentHorz = taCenter
        SortIndex = 1
        SortOrder = soAscending
        Width = 95
      end
      object cxgLotesCODIGO: TcxGridDBColumn
        Caption = 'C'#243'digo da Amostra'
        DataBinding.FieldName = 'CODIGO'
        HeaderAlignmentHorz = taCenter
        Width = 122
      end
      object cxgLotesDTABAI: TcxGridDBColumn
        Caption = 'Data da Libera'#231#227'o'
        DataBinding.FieldName = 'DTABAI'
        HeaderAlignmentHorz = taCenter
        Width = 151
      end
      object cxgLotesDTAACO: TcxGridDBColumn
        Caption = 'Final. Acopanhamento'
        DataBinding.FieldName = 'DTAACO'
        FooterAlignmentHorz = taCenter
        HeaderAlignmentHorz = taCenter
        Width = 137
      end
      object cxgLotesSITUACAO: TcxGridDBColumn
        Caption = 'Situa'#231#227'o'
        DataBinding.FieldName = 'SITUACAO'
        HeaderAlignmentHorz = taCenter
        Width = 195
      end
    end
    object cxgLotesLevel1: TcxGridLevel
      GridView = cxgLotesView
    end
  end
  object mmoMsg: TMemo [4]
    Left = 0
    Top = 292
    Width = 863
    Height = 67
    TabStop = False
    Align = alBottom
    Color = clInfoBk
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    Lines.Strings = (
      ''
      
        '                               A periodicidade da An'#225'lise est'#225' v' +
        'encida.')
    ParentFont = False
    ReadOnly = True
    TabOrder = 4
  end
  inherited pnlStatus: TPanel
    Top = 387
    Width = 863
    ExplicitTop = 387
    ExplicitWidth = 863
    inherited pnlNomeForm: TPanel
      Left = 692
      ExplicitLeft = 692
    end
    inherited pnlInfo: TPanel
      Width = 692
      ExplicitWidth = 692
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 496
    Top = 96
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 608
    Top = 104
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 408
    Top = 112
  end
  object dtsLotes: TDataSource
    Left = 232
    Top = 144
  end
end
