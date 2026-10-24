object frmGridRelatorios: TfrmGridRelatorios
  Left = 0
  Top = 0
  Caption = 'Grid Relat'#243'rios'
  ClientHeight = 679
  ClientWidth = 1476
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pgcRelat: TPageControl
    Left = 0
    Top = 0
    Width = 1476
    Height = 638
    ActivePage = tbsGrid
    Align = alClient
    TabOrder = 0
    object tbsGrid: TTabSheet
      Caption = '1 - Relat'#243'rios'
      object Splitter1: TSplitter
        Left = 0
        Top = 316
        Width = 1468
        Height = 4
        Cursor = crVSplit
        Align = alBottom
        ExplicitTop = 317
        ExplicitWidth = 1360
      end
      object cxRelat: TcxGrid
        Left = 0
        Top = 0
        Width = 1468
        Height = 316
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxvRelat: TcxGridDBTableView
          OnKeyDown = cxvRelatKeyDown
          Navigator.Buttons.CustomButtons = <>
          OnCustomDrawCell = cxvRelatCustomDrawCell
          DataController.DataSource = dtsConsulta
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Click para definir o filtro'
          FilterRow.Visible = True
          FilterRow.ApplyChanges = fracDelayed
          OptionsView.GroupByBox = False
          object cxvRelatColumn8: TcxGridDBColumn
            Caption = 'Chave'
            DataBinding.FieldName = 'CHAVE_'
            Options.Editing = False
            Width = 50
          end
          object cxvRelatCODREL: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'CODREL'
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Width = 75
          end
          object cxvRelatColumn6: TcxGridDBColumn
            Caption = 'Vers'#227'o'
            DataBinding.FieldName = 'VERREL'
            GroupSummaryAlignment = taRightJustify
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Width = 63
          end
          object cxvRelatColumn9: TcxGridDBColumn
            Caption = 'Release'
            DataBinding.FieldName = 'RELREL'
            Options.Editing = False
          end
          object cxvRelatColumn2: TcxGridDBColumn
            Caption = 'Nome do Relat'#243'rio'
            DataBinding.FieldName = 'DESCRI'
            Options.Editing = False
            Width = 300
          end
          object cxvRelatColumn5: TcxGridDBColumn
            Caption = 'Descri'#231#227'o Complementar'
            DataBinding.FieldName = 'DESCMP'
            Options.Editing = False
            Width = 300
          end
          object cxvRelatColumn7: TcxGridDBColumn
            Caption = 'Arquivo'
            DataBinding.FieldName = 'ARQUIV'
            Options.Editing = False
            Width = 300
          end
          object cxvRelatColumn4: TcxGridDBColumn
            Caption = 'Menu'
            DataBinding.FieldName = 'CAPMEN'
            Options.Editing = False
            Width = 261
          end
          object cxvRelatColumn10: TcxGridDBColumn
            Caption = 'Exporta PAR_AUTOMA = '#39'S'#39
            DataBinding.FieldName = 'EXPAUT'
            Options.Editing = False
            Width = 153
          end
          object cxvRelatColumn1: TcxGridDBColumn
            Caption = 'Direito de Acesso anterior'
            DataBinding.FieldName = 'DIRANT'
            Options.Editing = False
            Width = 263
          end
          object cxvRelatColumn3: TcxGridDBColumn
            Caption = 'Impress'#227'o'
            DataBinding.FieldName = 'TIPIMP'
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Width = 65
          end
        end
        object cxRelatLevel1: TcxGridLevel
          GridView = cxvRelat
        end
      end
      object Panel2: TPanel
        Left = 0
        Top = 320
        Width = 1468
        Height = 290
        Align = alBottom
        BevelOuter = bvNone
        Caption = 'Panel2'
        TabOrder = 1
        object Splitter2: TSplitter
          Left = 785
          Top = 0
          Width = 4
          Height = 290
          ExplicitLeft = 737
        end
        object cxgCadItem: TcxGrid
          Left = 789
          Top = 0
          Width = 679
          Height = 290
          Align = alClient
          TabOrder = 0
          LookAndFeel.ScrollbarMode = sbmClassic
          object cxvCadTem: TcxGridDBTableView
            OnKeyDown = cxvCadTemKeyDown
            Navigator.Buttons.CustomButtons = <>
            OnCustomDrawCell = cxvCadTemCustomDrawCell
            DataController.DataSource = dtsCadTem
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            FilterRow.InfoText = 'Click para definir o filtro'
            FilterRow.Visible = True
            FilterRow.ApplyChanges = fracDelayed
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsView.GroupByBox = False
            object cxvCadTemCODIGO: TcxGridDBColumn
              Caption = 'C'#243'digo'
              DataBinding.FieldName = 'TEM_CODIGO'
              HeaderAlignmentHorz = taCenter
              Options.Editing = False
              Width = 70
            end
            object cxvCadTemDESCRI: TcxGridDBColumn
              Caption = 'Descri'#231#227'o (Templates)'
              DataBinding.FieldName = 'TEM_DESCRI'
              Options.Editing = False
              Width = 600
            end
            object cxvCadTemDesgru: TcxGridDBColumn
              Caption = 'Grupo'
              DataBinding.FieldName = 'TEM_DESGRU'
              Width = 250
            end
          end
          object cxgCadItemLevel1: TcxGridLevel
            GridView = cxvCadTem
          end
        end
        object cxgCadMod: TcxGrid
          Left = 0
          Top = 0
          Width = 785
          Height = 290
          Align = alLeft
          TabOrder = 1
          LookAndFeel.ScrollbarMode = sbmClassic
          object cxvCadMod: TcxGridDBTableView
            OnKeyDown = cxvCadModKeyDown
            Navigator.Buttons.CustomButtons = <>
            OnCustomDrawCell = cxvCadModCustomDrawCell
            DataController.DataSource = dtsCadMod
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            FilterRow.InfoText = 'Click para definir o filtro'
            FilterRow.Visible = True
            FilterRow.ApplyChanges = fracDelayed
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsView.GroupByBox = False
            object cxvCadModCODIGO: TcxGridDBColumn
              Caption = 'C'#243'digo'
              DataBinding.FieldName = 'MOD_CODMOD'
              HeaderAlignmentHorz = taCenter
              Options.Editing = False
              Width = 70
            end
            object cxvCadModDESCRICAO: TcxGridDBColumn
              Caption = 'Descri'#231#227'o (Modelos)'
              DataBinding.FieldName = 'MOD_DESCRI'
              Options.Editing = False
              Width = 600
            end
          end
          object cxGridCadModLevel1: TcxGridLevel
            GridView = cxvCadMod
          end
        end
      end
    end
    object tbsScript: TTabSheet
      Caption = '2 - Script'
      ImageIndex = 1
      object mmoScript: TMemo
        Left = 0
        Top = 0
        Width = 1468
        Height = 610
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssBoth
        TabOrder = 0
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 638
    Width = 1476
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      1476
      41)
    object btnSair: TBitBtnLocked
      Left = 1506
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Sair'
      ModalResult = 2
      TabOrder = 0
    end
    object pnlBotoes: TPanel
      Left = 968
      Top = 11
      Width = 409
      Height = 17
      Anchors = [akTop, akRight]
      BevelOuter = bvNone
      TabOrder = 6
      object Label1: TLabel
        Left = 0
        Top = 0
        Width = 409
        Height = 17
        Align = alClient
        Alignment = taCenter
        Caption = 
          '[ENTER] Marca/Desmarca    [F6] Marca Todos    [F7] Desmarca Todo' +
          's'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 387
        ExplicitHeight = 13
      end
    end
    object chkModoExporta: TCheckBox
      Left = 110
      Top = 10
      Width = 76
      Height = 17
      Caption = 'Exporta'#231#227'o'
      TabOrder = 2
      OnClick = chkModoExportaClick
    end
    object cmbExporta: TComboBox
      Left = 192
      Top = 8
      Width = 106
      Height = 21
      Style = csDropDownList
      Enabled = False
      ItemIndex = 0
      TabOrder = 3
      Text = 'Vers'#227'o/Release'
      Items.Strings = (
        'Vers'#227'o/Release'
        'Vers'#227'o'
        'Automatico')
    end
    object btnGerar: TBitBtnLocked
      Left = 16
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Gera Script'
      TabOrder = 1
      OnClick = btnGerarClick
    end
    object btnAtualizar: TBitBtnLocked
      Left = 1388
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Atualizar'
      TabOrder = 7
      OnClick = btnAtualizarClick
    end
    object chkRelPadrao: TCheckBox
      Left = 330
      Top = 10
      Width = 128
      Height = 17
      Caption = 'Relat'#243'rio Padr'#227'o'
      Checked = True
      State = cbChecked
      TabOrder = 4
      OnClick = chkModoExportaClick
    end
    object ckbSalvarCADVAL: TCheckBox
      Left = 458
      Top = 6
      Width = 128
      Height = 25
      Caption = 'Salvar CADVAL'
      TabOrder = 5
      OnClick = chkModoExportaClick
    end
  end
  object dtsConsulta: TDataSource
    Left = 652
    Top = 144
  end
  object dtsCadTem: TDataSource
    Left = 1036
    Top = 480
  end
  object dtsCadMod: TDataSource
    Left = 228
    Top = 440
  end
end
