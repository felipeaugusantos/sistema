inherited frmConsMovBanIgnorados: TfrmConsMovBanIgnorados
  Width = 664
  Height = 428
  BorderIcons = [biSystemMenu]
  Caption = 'Lan'#231'amentos Ignorados da Movimenta'#231#227'o Banc'#225'ria'
  Position = poMainFormCenter
  ExplicitWidth = 664
  ExplicitHeight = 428
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 355
    Width = 658
    ExplicitTop = 355
    ExplicitWidth = 658
    inherited FlwBotoes: TFlowPanel
      Width = 654
      ExplicitWidth = 654
      object btnConfirmar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 213
        Height = 22
        Caption = '[ F10 ] Recompor Lan'#231'amento'
        Constraints.MinWidth = 213
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000030000000E000000150000000C0000
          0002000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000200000012072B199C136940FF051E127A0000
          000C000000010000000000000000000000000000000000000000000000000000
          0000000000000000000200000010082D1B9A278B63FF3CB58BFF16623FF4020B
          063D000000060000000000000000000000000000000000000000000000000000
          0000000000020000000E082F1C972C9068FF45C097FF44BF96FF36A67DFF0C46
          2BCE000000150000000200000000000000000000000000000000000000000000
          00010000000C09321F9430966FFF56CAA4FF95E3C8FF7BD7B8FF48C39AFF2A8D
          65FF082B1A8A0000000C00000001000000000000000000000000000000000000
          00060A352190349B75FF7BDBBBFFACE9D3FF4EA07EFF6DB99AFF7DDABBFF4CC4
          9DFF1F7852FC03120B4800000007000000010000000000000000000000000000
          00084B8E60FF99E8CEFF90D0B7FF287F5BEF09281B680E422D9A6EBA9DFF75D9
          B7FF4ABE97FF196747E70209062B000000040000000000000000000000000000
          0003082016494D9063FF14573CB2020B0723000000070000000C135239B280CA
          AEFF71D8B8FF46B691FF135639CA000101140000000200000000000000000000
          0000000000030000000600000005000000020000000000000002010302121A63
          44C28CD3B9FF7ADDBEFF3FAA84FF0D432CA10000000D00000002000000000000
          0000000000000000000000000000000000000000000000000000000000020105
          03151B6748C484CFB3FF81E1C4FF38A27BFF0B34237D00000007000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000101030210175E42B27ECCAFFF97E9D0FF4E9265FF00000009000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000010002010B15573DA5509769FF0822184A00000004000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000100000004000000060000000300000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        TabOrder = 0
        OnClick = btnConfirmarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 575
      ExplicitLeft = 575
    end
  end
  inherited pnlStatus: TPanel
    Top = 383
    Width = 658
    ExplicitTop = 383
    ExplicitWidth = 658
    inherited pnlNomeForm: TPanel
      Left = 487
      ExplicitLeft = 487
    end
    inherited pnlInfo: TPanel
      Width = 487
      ExplicitWidth = 487
    end
  end
  object grdLancIgnorados: TcxGrid [2]
    Left = 0
    Top = 0
    Width = 658
    Height = 355
    Margins.Left = 0
    Margins.Top = 6
    Margins.Right = 0
    Margins.Bottom = 0
    Align = alClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clBtnText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    LockedStateImageOptions.AssignedValues = [lsiavFont]
    LockedStateImageOptions.Font.Charset = DEFAULT_CHARSET
    LockedStateImageOptions.Font.Color = clBlack
    LockedStateImageOptions.Font.Height = 14
    LockedStateImageOptions.Font.Name = 'Arial'
    LockedStateImageOptions.Font.Pitch = fpVariable
    LockedStateImageOptions.Font.Style = []
    LookAndFeel.ScrollbarMode = sbmClassic
    object grdLancIgnoradosDBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = grdLancIgnoradosDBTableView1CustomDrawCell
      DataController.KeyFieldNames = 'AUTOINCREM'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.DragHighlighting = False
      OptionsBehavior.DragScrolling = False
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsSelection.MultiSelect = True
      OptionsView.ShowEditButtons = gsebAlways
      OptionsView.GroupByBox = False
      object grdLanIgnDBAUTOINCREM: TcxGridDBColumn
        Caption = 'ChamaDetalhes'
        DataBinding.FieldName = 'AUTOINCREM'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        Properties.MaxLength = 20
        Properties.ViewStyle = vsButtonsOnly
        Properties.OnButtonClick = grdLanIgnDBAUTOINCREMPropertiesButtonClick
        MinWidth = 35
        Options.Filtering = False
        Options.ShowEditButtons = isebAlways
        Options.Grouping = False
        Options.HorzSizing = False
        Options.Moving = False
        Options.ShowCaption = False
        Options.Sorting = False
        Width = 35
      end
      object grdLanIgnDBCTB_DTALAN: TcxGridDBColumn
        Caption = 'Data'
        DataBinding.FieldName = 'CTB_DTALAN'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        HeaderGlyphAlignmentHorz = taCenter
        Options.Editing = False
        Width = 60
      end
      object grdLanIgnDBCTB_CODEMP: TcxGridDBColumn
        Caption = 'Empresa'
        DataBinding.FieldName = 'CTB_CODEMP'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        FooterAlignmentHorz = taCenter
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 55
      end
      object grdLanIgnDBCTB_CREDEB: TcxGridDBColumn
        Caption = 'Cr'#233'dito/D'#233'bito'
        DataBinding.FieldName = 'CTB_CREDEB'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 75
      end
      object grdLanIgnDBCTB_VALLAN: TcxGridDBColumn
        Caption = 'Valor'
        DataBinding.FieldName = 'CTB_VALLAN'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.Alignment.Horz = taRightJustify
        Options.Editing = False
        Width = 80
      end
      object grdLanIgnDBCTB_HIST01: TcxGridDBColumn
        Caption = 'Hist'#243'rico'
        DataBinding.FieldName = 'CTB_HIST01'
        Options.Editing = False
        Options.Focusing = False
        Width = 260
      end
      object grdLanIgnDBCTB_IGNORA: TcxGridDBColumn
        DataBinding.FieldName = 'CTB_IGNORA'
        Visible = False
        Options.Editing = False
      end
      object grdLanIgnDBCTB_PAGCON: TcxGridDBColumn
        DataBinding.FieldName = 'CTB_PAGCON'
        Visible = False
        Options.Editing = False
      end
      object grdLanIgnDBCTB_ORIGEM: TcxGridDBColumn
        DataBinding.FieldName = 'CTB_ORIGEM'
        Visible = False
        Options.Editing = False
        Width = 57
      end
      object grdLanIgnDBCTB_CODCTA: TcxGridDBColumn
        Caption = 'Pl.Conta'
        DataBinding.FieldName = 'CTB_CODCTA'
        Options.Editing = False
        Width = 70
      end
    end
    object grdLancIgnoradosLevel1: TcxGridLevel
      GridView = grdLancIgnoradosDBTableView1
    end
  end
end
