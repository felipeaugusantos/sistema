inherited frmResumoPedido: TfrmResumoPedido
  Width = 1024
  Height = 367
  BorderStyle = bsSizeable
  Caption = 'Selecione os Pedidos que ser'#227'o gerados'
  ExplicitWidth = 1024
  ExplicitHeight = 367
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 286
    Width = 1008
    TabOrder = 1
    ExplicitTop = 286
    ExplicitWidth = 1008
    inherited FlwBotoes: TFlowPanel
      Width = 1004
      ExplicitWidth = 1004
      inherited btnConfirma: TBitBtnLocked
        Width = 111
        Caption = '[ F10 ] Confirma'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000040000
          00130000001E0000002000000020000000200000002100000021000000210000
          002200000022000000220000002300000021000000160000000500000012281E
          16CB37291EFF463A31FFBD8150FFBC7E4DFFB97949FFB67646FFB37141FFB06D
          3DFFAD6839FFAB6535FF42362EFF3D3026FF241A13CE00000015000000193B2C
          21FF685C54FF483C34FFE8C28BFFE7C088FFE6BD85FFE5BB81FFE4B87CFFE3B5
          79FFE2B276FFE2B273FF443931FF51433AFF34261DFF0000001E000000183E2F
          24FF6C6057FF4A3F37FFD9B27DFFD8B07BFFD7AE77FFD7AB74FFD6A970FFD5A6
          6DFFD4A56AFFD4A268FF473B33FF5B4F47FF37291EFF0000001D000000164031
          26FF6F645CFF4C4038FFFFFFFFFFF7F1EBFFF7F0EBFFF7F0EBFFF7EFEBFFF6EF
          EAFFF6EFEAFFF6EFE9FF463B34FF5D5249FF3A2C21FF0000001B000000144434
          29FF73675FFF4F443CFFFFFFFFFFF8F2EDFFF8F1EDFFF7F1EDFFF7F0EDFFF8F1
          EBFFF7F0EBFFF7F0ECFF4A4037FF5F534BFF3D2E23FF00000019000000124637
          2CFF776B63FF50453DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF4E433BFF61544CFF403126FF0000001700000010493A
          2FFF796E66FF50453DFF61564EFF60564EFF60554DFF5F544CFF5E544CFF5E53
          4BFF5D524AFF5C5249FF5B5149FF61554DFF433429FF000000150000000E4C3D
          32FF7C706AFF674E44FF654B42FF634A41FF61473FFF5F473EFF5C443CFF5B43
          3AFF594139FF584038FF573F37FF63574FFF46362DFF000000130000000D4E3F
          35FF80746DFF6B5248FFF4ECE6FFE9DACEFFE9D8CDFFE9D8CCFFE9D8CBFFE8D7
          CAFFF3EAE2FFF3E9E2FF5A4139FF645850FF483A2FFF000000110000000B5142
          36FF827770FF70564DFFF9F5F2FFF4EAE4FFF1E6DEFFEBDCD2FFE9D9CCFF4E41
          3DFF60534CFFF3EAE3FF5D453CFF655951FF4C3D32FF0000000F000000095344
          39FF857A73FF755A50FFFAF6F3FFF5EDE7FFF4EDE6FFF4ECE6FFEFE2DAFF493D
          38FF5A4D46FFF4EBE4FF60483FFF655A52FF4F3F34FF0000000D000000075545
          3AFF887D76FF795E54FFFAF6F4FFF5EEE9FFF5EDE7FFF4EDE7FFF4ECE6FF473A
          36FF483D36FFE9D9CDFF644C43FF675A52FF514137FF0000000B000000065748
          3DFF898079FF7C6157FFFAF7F4FFFAF6F4FFFAF6F4FFFAF6F3FFFAF6F3FFFAF5
          F2FFF5EEE9FFF4ECE6FF695046FF82776FFF534439FF00000009000000034235
          2EC058493DFF7F645AFF998178FF967F75FF937A72FF8E786DFF8B7269FF866E
          64FF82695FFF7D645BFF6E544AFF56453BFF3F332BC200000005000000000000
          0002000000030000000400000004000000040000000400000005000000050000
          0005000000050000000500000006000000060000000400000001}
        NumGlyphs = 1
        ExplicitWidth = 111
      end
      object chkCnvEmb: TCheckBox
        Left = 111
        Top = 0
        Width = 214
        Height = 16
        Caption = 'Converter de unidade para embalagem?'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 928
      ExplicitLeft = 928
    end
  end
  inherited pnlStatus: TPanel
    Top = 312
    Width = 1008
    TabOrder = 2
    ExplicitTop = 312
    ExplicitWidth = 1008
    inherited pnlNomeForm: TPanel
      Left = 837
      ExplicitLeft = 837
    end
    inherited pnlInfo: TPanel
      Width = 837
      ExplicitWidth = 837
    end
  end
  object cxgFiliais: TcxGrid [2]
    Left = 0
    Top = 0
    Width = 1008
    Height = 225
    Align = alClient
    TabOrder = 0
    object cxvFiliais: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      OnCanFocusRecord = cxvFiliaisCanFocusRecord
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Format = ',0.00'
          Kind = skSum
          Column = cxvFiliaisVALCOM
        end>
      DataController.Summary.SummaryGroups = <>
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = ' '
      OptionsView.Footer = True
      OptionsView.GroupByBox = False
      object cxvFiliaisCODEMP: TcxGridDBColumn
        Caption = 'Empresa'
        DataBinding.FieldName = 'CODEMP'
        Visible = False
        GroupSummaryAlignment = taCenter
        HeaderAlignmentHorz = taCenter
        Width = 66
      end
      object cxvFiliaisGERARP: TcxGridDBColumn
        Caption = 'Gerar'
        DataBinding.FieldName = 'GERARP'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 'S'
        Properties.ValueUnchecked = 'N'
        HeaderAlignmentHorz = taCenter
        HeaderGlyphAlignmentHorz = taCenter
        Width = 65
      end
      object cxvFiliaisDESBAN: TcxGridDBColumn
        Caption = 'Bandeira'
        DataBinding.FieldName = 'DESBAN'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 70
      end
      object cxvFiliaisSIGEMP: TcxGridDBColumn
        Caption = 'Empresa'
        DataBinding.FieldName = 'SIGEMP'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 68
      end
      object cxvFiliaisEmpGer: TcxGridDBColumn
        Caption = 'Empresa para qual ser'#225' gerado o pedido'
        DataBinding.FieldName = 'EMPGER'
        PropertiesClassName = 'TcxLookupComboBoxProperties'
        Properties.DropDownListStyle = lsFixedList
        Properties.ImmediatePost = True
        Properties.KeyFieldNames = 'EMP_CODEMP'
        Properties.ListColumns = <
          item
            FieldName = 'EMP_NOMEMP'
          end>
        Properties.ListOptions.CaseInsensitive = True
        Properties.ListOptions.ShowHeader = False
        Width = 290
      end
      object cxvFiliaisVALMIN: TcxGridDBColumn
        Caption = 'Valor Pedido M'#237'nimo'
        DataBinding.FieldName = 'VALMIN'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 107
      end
      object cxvFiliaisVALCOM: TcxGridDBColumn
        Caption = 'Valor de Compra'
        DataBinding.FieldName = 'VALCOM'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 103
      end
      object cxvFiliaisNOMEMP: TcxGridDBColumn
        Caption = 'Nome da Empresa'
        DataBinding.FieldName = 'NOMEMP'
        Visible = False
        Width = 216
      end
      object cxvFiliaisTOTQTD: TcxGridDBColumn
        Caption = 'Qtde. Total'
        DataBinding.FieldName = 'TOTQTD'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.0000;-,0.0000'
        OnCustomDrawCell = cxvFiliaisTOTQTDCustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 85
      end
      object cxvFiliaisTOTKIL: TcxGridDBColumn
        Caption = 'Kilos Total'
        DataBinding.FieldName = 'TOTKIL'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.0000;-,0.0000'
        OnCustomDrawCell = cxvFiliaisTOTKILCustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 87
      end
      object cxvFiliaisTOTLIT: TcxGridDBColumn
        Caption = 'Litros Total'
        DataBinding.FieldName = 'TOTLIT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.0000;-,0.0000'
        OnCustomDrawCell = cxvFiliaisTOTLITCustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 82
      end
      object cxvFiliaisTOTMET: TcxGridDBColumn
        Caption = 'Metragem Total'
        DataBinding.FieldName = 'TOTMET'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.0000;-,0.0000'
        OnCustomDrawCell = cxvFiliaisTOTMETCustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 98
      end
      object cxvFiliaisDIVQTD: TcxGridDBColumn
        DataBinding.FieldName = 'DIVQTD'
        Visible = False
      end
      object cxvFiliaisDIVPES: TcxGridDBColumn
        DataBinding.FieldName = 'DIVPES'
        Visible = False
      end
      object cxvFiliaisDIVLIT: TcxGridDBColumn
        DataBinding.FieldName = 'DIVLIT'
        Visible = False
      end
      object cxvFiliaisDIVMET: TcxGridDBColumn
        DataBinding.FieldName = 'DIVMET'
        Visible = False
      end
      object cxvFiliaisPRA_MINQTD: TcxGridDBColumn
        DataBinding.FieldName = 'PRA_MINQTD'
        Visible = False
        Options.Editing = False
      end
      object cxvFiliaisPRA_MINMET: TcxGridDBColumn
        DataBinding.FieldName = 'PRA_MINMET'
        Visible = False
        Options.Editing = False
      end
      object cxvFiliaisPRA_MINLIT: TcxGridDBColumn
        DataBinding.FieldName = 'PRA_MINLIT'
        Visible = False
        Options.Editing = False
      end
      object cxvFiliaisPRA_MINPES: TcxGridDBColumn
        DataBinding.FieldName = 'PRA_MINPES'
        Visible = False
        Options.Editing = False
      end
    end
    object cxgFiliaisLevel1: TcxGridLevel
      GridView = cxvFiliais
    end
  end
  object pnlLegenda: TPanel [3]
    Left = 0
    Top = 225
    Width = 1008
    Height = 61
    Align = alBottom
    ParentColor = True
    TabOrder = 3
    Visible = False
    object lblLegenda: TLabel
      Left = 1
      Top = 1
      Width = 1006
      Height = 59
      Align = alClient
      Caption = 'lblLegenda'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'Consolas'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      ExplicitWidth = 70
      ExplicitHeight = 14
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 288
    Top = 64
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 40
    Top = 48
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 168
    Top = 56
  end
end
