inherited frmAltPrecoDuplicidades: TfrmAltPrecoDuplicidades
  Width = 739
  Height = 437
  BorderIcons = [biSystemMenu, biMinimize, biMaximize]
  Caption = 'Altera'#231#227'o de Pre'#231'o Individual - Itens com Duplicidades'
  Position = poScreenCenter
  ExplicitWidth = 739
  ExplicitHeight = 437
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 364
    Width = 733
    Height = 28
    Enabled = True
    Visible = True
    ExplicitTop = 364
    ExplicitWidth = 733
    ExplicitHeight = 28
    DesignSize = (
      733
      28)
    inherited FlwBotoes: TFlowPanel
      Width = 729
      Height = 24
      ExplicitTop = 2
      ExplicitWidth = 729
      ExplicitHeight = 24
    end
    inherited btnSair: TBitBtnLocked
      Left = 633
      Top = 3
      Width = 95
      ModalResult = 2
      TabOrder = 2
      ExplicitLeft = 633
      ExplicitTop = 3
      ExplicitWidth = 95
    end
    object btnConfirmaAlt: TBitBtnLocked
      Left = 4
      Top = 3
      Width = 95
      Height = 22
      Caption = '[ F10 ] Confirma'
      ModalResult = 1
      TabOrder = 1
      OnClick = btnConfirmaAltClick
    end
  end
  inherited pgcDados: TPageControl
    Top = 30
    Width = 733
    Height = 290
    ActivePage = nil
    ExplicitTop = 30
    ExplicitWidth = 733
    ExplicitHeight = 290
    inherited tbsGeral: TTabSheet
      TabVisible = False
      ExplicitLeft = 4
      ExplicitTop = 6
      ExplicitWidth = 725
      ExplicitHeight = 280
    end
  end
  object pnlHeader: TPanel [3]
    Left = 0
    Top = 0
    Width = 733
    Height = 30
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Itens com Duplicidades'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentBackground = False
    ParentColor = True
    ParentFont = False
    TabOrder = 3
  end
  inherited pnlStatus: TPanel
    Top = 392
    Width = 733
    ExplicitTop = 392
    ExplicitWidth = 733
    inherited pnlNomeForm: TPanel
      Left = 562
      ExplicitLeft = 562
    end
    inherited pnlInfo: TPanel
      Width = 562
      ExplicitWidth = 562
    end
  end
  object cxItens: TcxGrid [5]
    Left = 0
    Top = 30
    Width = 733
    Height = 290
    Align = alClient
    TabOrder = 5
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxItensTblv: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      FilterBox.CustomizeDialog = False
      OnCustomDrawCell = cxItensTblvCustomDrawCell
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados pra exibir'
      OptionsView.GroupByBox = False
      object cxItensITEAGR: TcxGridDBColumn
        Caption = 'ITENS IGUAIS'
        DataBinding.FieldName = 'ITEAGR'
        Visible = False
        Options.Editing = False
        Width = 76
      end
      object cxItensCodIte: TcxGridDBColumn
        Caption = 'C'#243'd. Item'
        DataBinding.FieldName = 'CODITE'
        FooterAlignmentHorz = taCenter
        GroupSummaryAlignment = taCenter
        Options.Editing = False
        Width = 65
      end
      object cxItensDescri: TcxGridDBColumn
        Caption = 'Descri'#231#227'o do Item'
        DataBinding.FieldName = 'DESITE'
        Options.Editing = False
        Width = 344
      end
      object cxItensCodFab: TcxGridDBColumn
        Caption = 'C'#243'd. F'#225'brica'
        DataBinding.FieldName = 'CODFAB'
        PropertiesClassName = 'TcxTextEditProperties'
        Width = 99
      end
      object cxItensCodBar: TcxGridDBColumn
        Caption = 'C'#243'd. Barras'
        DataBinding.FieldName = 'CODBAR'
        PropertiesClassName = 'TcxTextEditProperties'
        Width = 95
      end
      object cxItensCodBarEmb: TcxGridDBColumn
        Caption = 'C'#243'd. Barras Emb.'
        DataBinding.FieldName = 'BAREMB'
        PropertiesClassName = 'TcxTextEditProperties'
        Width = 100
      end
      object cxItensORIGEM: TcxGridDBColumn
        DataBinding.FieldName = 'ORIGEM'
        Visible = False
        HeaderGlyphAlignmentVert = vaTop
      end
    end
    object cxItenslvl: TcxGridLevel
      GridView = cxItensTblv
    end
  end
  object Panel1: TPanel [6]
    Left = 0
    Top = 320
    Width = 733
    Height = 44
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 6
    object shpInfo: TShape
      Left = 16
      Top = 8
      Width = 20
      Height = 20
    end
    object Label1: TLabel
      Left = 39
      Top = 12
      Width = 522
      Height = 14
      Caption = 
        'Os produtos que n'#227'o sofreram altera'#231#227'o global de pre'#231'os (que est' +
        #227'o em cinza) n'#227'o poder'#227'o ser alterados  '
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 416
    Top = 80
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 352
    Top = 80
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 216
    Top = 120
  end
  object dtsConsulta: TDataSource
    DataSet = frmAltPrecoIndividual.cdsDuplic
    Left = 384
    Top = 80
  end
end
