inherited frmCadSitProduto: TfrmCadSitProduto
  Height = 449
  BorderStyle = bsSizeable
  Caption = 'Cadastro de Situa'#231#227'o de  Produtos'
  ExplicitHeight = 449
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 368
    Width = 473
    ExplicitTop = 368
    ExplicitWidth = 473
    inherited FlwBotoes: TFlowPanel
      Width = 392
      ExplicitTop = 2
      ExplicitWidth = 392
    end
    inherited btnSair: TBitBtnLocked
      Left = 394
      Top = 2
      Align = alRight
      Visible = False
      ExplicitLeft = 394
      ExplicitTop = 2
    end
  end
  object pnlCampos: TPanel [2]
    Left = 0
    Top = 0
    Width = 473
    Height = 103
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 2
    object Label1: TLabel
      Left = 63
      Top = 19
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label2: TLabel
      Left = 47
      Top = 42
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object Label3: TLabel
      Left = 19
      Top = 65
      Width = 80
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cor da Situa'#231#227'o:'
    end
    object shpSitCor: TShape
      Left = 103
      Top = 62
      Width = 248
      Height = 20
      Pen.Style = psClear
    end
    object dbeCodSit: TDBEditFocus
      Left = 102
      Top = 16
      Width = 47
      Height = 22
      TabStop = False
      DataField = 'SIT_CODIGO'
      Enabled = False
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object dbnNavigator: TDBNavigator
      Left = 0
      Top = 83
      Width = 473
      Height = 20
      Align = alBottom
      Flat = True
      ConfirmDelete = False
      TabOrder = 2
      OnClick = dbnNavigatorClick
      ExplicitTop = 93
    end
    object dbeDescri: TDBEditFocus
      Tag = 99
      Left = 102
      Top = 39
      Width = 363
      Height = 22
      CharCase = ecUpperCase
      DataField = 'SIT_DESCRI'
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object btnEscolheCores: TBitBtnLocked
      Left = 352
      Top = 62
      Width = 113
      Height = 20
      Caption = 'Escolher cores'
      Enabled = False
      TabOrder = 3
      OnClick = btnEscolheCoresClick
    end
    object chkPASCMP: TDBCheckBox
      Left = 322
      Top = 19
      Width = 150
      Height = 17
      Caption = 'Exibir na Pasta de Compra'
      DataField = 'SIT_PASCMP'
      TabOrder = 4
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
  end
  object cxgSitPro: TcxGrid [3]
    Left = 0
    Top = 103
    Width = 473
    Height = 265
    Align = alClient
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    ExplicitTop = 113
    ExplicitHeight = 255
    object cxgSitProView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      Navigator.Buttons.First.Visible = False
      Navigator.Buttons.PriorPage.Visible = False
      Navigator.Buttons.Prior.Visible = False
      Navigator.Buttons.Next.Visible = False
      Navigator.Buttons.NextPage.Visible = False
      Navigator.Buttons.Last.Visible = False
      Navigator.Buttons.Append.Visible = False
      Navigator.Buttons.Delete.Visible = True
      Navigator.Buttons.Edit.Visible = True
      Navigator.Buttons.Post.Visible = True
      Navigator.Buttons.Cancel.Visible = True
      Navigator.Buttons.Refresh.Visible = False
      Navigator.Buttons.SaveBookmark.Visible = False
      Navigator.Buttons.GotoBookmark.Visible = False
      Navigator.Buttons.Filter.Visible = False
      OnCustomDrawCell = cxgSitProViewCustomDrawCell
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = ' '
      OptionsView.GroupByBox = False
      object cxgSitProViewColumn1: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'SIT_CODIGO'
        Options.Editing = False
        Width = 44
      end
      object cxgSitProViewColumn2: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'SIT_DESCRI'
        Options.Editing = False
        Width = 250
      end
      object cxgSitProViewColumn3: TcxGridDBColumn
        Caption = 'Cor'
        DataBinding.FieldName = 'SIT_CORSIT'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 168
      end
    end
    object cxgSitProLevel1: TcxGridLevel
      GridView = cxgSitProView
    end
  end
  inherited pnlStatus: TPanel
    Top = 394
    Width = 473
    ExplicitTop = 394
    ExplicitWidth = 473
    inherited pnlNomeForm: TPanel
      Left = 302
      ExplicitLeft = 302
    end
    inherited pnlInfo: TPanel
      Width = 302
      ExplicitWidth = 302
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 416
    Top = 48
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 416
  end
  object ColorDialog: TColorDialog
    Left = 176
    Top = 224
  end
end
