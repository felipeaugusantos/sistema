inherited frmEscolhePisCofinsFrete: TfrmEscolhePisCofinsFrete
  Width = 754
  Height = 506
  BorderStyle = bsSizeable
  Caption = 'Selecione as Al'#237'quota de PIS '
  ExplicitWidth = 754
  ExplicitHeight = 506
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 424
    Width = 738
    Color = clSilver
    TabOrder = 1
    ExplicitTop = 424
    ExplicitWidth = 738
    inherited btnSair: TBitBtnLocked
      Left = 655
      TabOrder = 1
      ExplicitLeft = 655
    end
    object btnConfirma: TBitBtnLocked
      Left = 5
      Top = 3
      Width = 97
      Height = 22
      Caption = '&Confirma'
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      ModalResult = 1
      NumGlyphs = 2
      TabOrder = 0
    end
    object chkCopTodas: TCheckBox
      Left = 199
      Top = 6
      Width = 409
      Height = 17
      Caption = 'Copiar a al'#237'quota selecionada para todos os fretes com CFOP'
      Checked = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      State = cbChecked
      TabOrder = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 452
    Width = 738
    TabOrder = 2
    ExplicitTop = 452
    ExplicitWidth = 738
    inherited pnlNomeForm: TPanel
      Left = 567
      ExplicitLeft = 567
    end
    inherited pnlInfo: TPanel
      Width = 567
      ExplicitWidth = 567
    end
  end
  object cxGridCitel1: TcxGridCitel [3]
    Left = 0
    Top = 0
    Width = 738
    Height = 424
    Align = alClient
    TabOrder = 0
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgConsulta: TcxGridDBTableViewCitel
      OnKeyDown = cxgConsultaKeyDown
      Navigator.Buttons.CustomButtons = <>
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxgConsultaCLAFIS: TcxGridDBColumn
        Caption = 'CFOP'
        DataBinding.FieldName = 'CLAFIS'
        FooterAlignmentHorz = taCenter
        GroupSummaryAlignment = taCenter
        HeaderAlignmentHorz = taCenter
        Width = 60
      end
      object cxgConsultaColumn2: TcxGridDBColumn
        Caption = 'Abrevia'#231#227'o de PIS'
        DataBinding.FieldName = 'DESCRI'
        Width = 399
      end
      object cxgConsultaColumn3: TcxGridDBColumn
        Caption = 'CST'
        DataBinding.FieldName = 'APC_CSTENT'
        HeaderAlignmentHorz = taCenter
        Width = 60
      end
      object cxgConsultaColumn4: TcxGridDBColumn
        Caption = 'Base de C'#225'lculo (%)'
        DataBinding.FieldName = 'APC_BASENT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Width = 114
      end
      object cxgConsultaColumn5: TcxGridDBColumn
        Caption = 'Al'#237'quota (%)'
        DataBinding.FieldName = 'APC_ALQENT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Width = 73
      end
    end
    object cxGridCitel1Level1: TcxGridLevel
      GridView = cxgConsulta
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 536
    Top = 232
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 280
    Top = 296
  end
end
