inherited frmCopiaParametrosEmpresa: TfrmCopiaParametrosEmpresa
  Width = 448
  Height = 528
  Caption = 'Copia as colunas marcadas para as empresas selecionadas'
  ExplicitWidth = 448
  ExplicitHeight = 528
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 457
    Width = 442
    ExplicitTop = 457
    ExplicitWidth = 442
    inherited FlwBotoes: TFlowPanel
      Width = 361
      ExplicitWidth = 355
      inherited btnConfirma: TBitBtnLocked
        Align = alLeft
      end
      object btnMarcaTodos: TBitBtnLocked
        Left = 75
        Top = 0
        Width = 123
        Height = 22
        Align = alRight
        Caption = '[ F6 ] Marca Todos'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
          555555555555555555555555555555555555555555FF55555555555559055555
          55555555577FF5555555555599905555555555557777F5555555555599905555
          555555557777FF5555555559999905555555555777777F555555559999990555
          5555557777777FF5555557990599905555555777757777F55555790555599055
          55557775555777FF5555555555599905555555555557777F5555555555559905
          555555555555777FF5555555555559905555555555555777FF55555555555579
          05555555555555777FF5555555555557905555555555555777FF555555555555
          5990555555555555577755555555555555555555555555555555}
        NumGlyphs = 2
        TabOrder = 1
        OnClick = btnMarcaTodosClick
      end
      object btnDesmarcaTodos: TBitBtnLocked
        Left = 198
        Top = 0
        Width = 141
        Height = 22
        Align = alRight
        Caption = '[ F7 ] Desmarca Todos'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333FFFFF3333333333999993333333333F77777FFF333333999999999
          3333333777333777FF3333993333339993333377FF3333377FF3399993333339
          993337777FF3333377F3393999333333993337F777FF333337FF993399933333
          399377F3777FF333377F993339993333399377F33777FF33377F993333999333
          399377F333777FF3377F993333399933399377F3333777FF377F993333339993
          399377FF3333777FF7733993333339993933373FF3333777F7F3399933333399
          99333773FF3333777733339993333339933333773FFFFFF77333333999999999
          3333333777333777333333333999993333333333377777333333}
        NumGlyphs = 2
        TabOrder = 2
        OnClick = btnDesmarcaTodosClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 363
      Top = 2
      Align = alRight
      ExplicitLeft = 361
    end
  end
  inherited pnlStatus: TPanel
    Top = 483
    Width = 442
    ExplicitTop = 483
    ExplicitWidth = 442
    inherited pnlNomeForm: TPanel
      Left = 271
      ExplicitLeft = 271
    end
    inherited pnlInfo: TPanel
      Width = 271
      ExplicitWidth = 271
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 0
    Width = 442
    Height = 57
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
    object lblEmpresas: TLabel
      Left = 9
      Top = 16
      Width = 427
      Height = 14
      AutoSize = False
      Caption = 'Copia as colunas da empresa:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 9
      Top = 32
      Width = 210
      Height = 14
      Caption = 'para as demais empresas selecionas.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object Panel2: TPanel [4]
    Left = 0
    Top = 57
    Width = 442
    Height = 24
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Selecione as colunas que deseja copiar:'
    TabOrder = 4
  end
  object cxgColunas: TcxGrid [5]
    Left = 0
    Top = 81
    Width = 442
    Height = 376
    Align = alClient
    TabOrder = 5
    object cxvColunas: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object cxvColunasNOMGRU: TcxGridDBColumn
        Caption = 'Grupo'
        DataBinding.FieldName = 'NOMGRU'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Options.CellMerging = True
        Width = 196
      end
      object cxvColunasNOMCOL: TcxGridDBColumn
        Caption = 'Coluna'
        DataBinding.FieldName = 'NOMCOL'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 187
      end
      object cxvColunasCOPIAR: TcxGridDBColumn
        Caption = 'Copiar'
        DataBinding.FieldName = 'COPIAR'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ImmediatePost = True
        Properties.ValueChecked = 'S'
        Properties.ValueUnchecked = 'N'
        HeaderAlignmentHorz = taCenter
        Width = 75
      end
    end
    object cxgColunasLevel1: TcxGridLevel
      GridView = cxvColunas
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 288
    Top = 208
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 496
    Top = 224
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 160
    Top = 208
  end
end
