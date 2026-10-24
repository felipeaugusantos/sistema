inherited frmCadFaixaFatVend: TfrmCadFaixaFatVend
  Width = 834
  Height = 450
  BorderIcons = [biSystemMenu]
  Caption = 'Cadastro de Faixas de Faturamento para Vendedores'
  Position = poMainFormCenter
  ExplicitWidth = 834
  ExplicitHeight = 450
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 377
    Width = 828
    Height = 28
    Enabled = True
    Visible = True
    ExplicitTop = 377
    ExplicitWidth = 828
    ExplicitHeight = 28
    inherited FlwBotoes: TFlowPanel
      Width = 824
      Height = 24
      ExplicitWidth = 824
      ExplicitHeight = 24
    end
    inherited btnSair: TBitBtnLocked
      Left = 747
      Top = 3
      ExplicitLeft = 747
      ExplicitTop = 3
    end
  end
  inherited pgcDados: TPageControl
    Width = 828
    Height = 377
    ExplicitWidth = 828
    ExplicitHeight = 377
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 820
      ExplicitHeight = 345
    end
  end
  object pnl1: TPanel [3]
    Left = 0
    Top = 0
    Width = 828
    Height = 377
    Align = alClient
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 3
  end
  object gridCadOpe: TcxGrid [4]
    Left = 0
    Top = 0
    Width = 828
    Height = 377
    Align = alClient
    TabOrder = 4
    LookAndFeel.ScrollbarMode = sbmClassic
    object gridCadOpeDBTableView1: TcxGridDBTableView
      OnKeyDown = gridCadOpeDBTableView1KeyDown
      OnKeyPress = gridCadOpeDBTableView1KeyPress
      Navigator.Buttons.CustomButtons = <>
      OnEditKeyDown = gridCadOpeDBTableView1EditKeyDown
      OnEditKeyPress = gridCadOpeDBTableView1EditKeyPress
      DataController.DataSource = dtsCadOpe
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.Inserting = False
      OptionsView.GroupByBox = False
      object gridDadosDBTableOPE_CODOPE: TcxGridDBColumn
        Caption = 'C'#243'd. Ven.'
        DataBinding.FieldName = 'OPE_CODOPE'
        Options.Editing = False
        Options.Focusing = False
        Styles.Header = cxStyle1
        Width = 65
      end
      object gridDadosDBTableOPE_NOMOPE: TcxGridDBColumn
        Caption = 'Nome Vendedor'
        DataBinding.FieldName = 'OPE_NOMOPE'
        Options.Editing = False
        Options.Focusing = False
        Styles.Header = cxStyle1
        Width = 350
      end
      object gridCadOpeDBTableOPE_INTEXT: TcxGridDBColumn
        Caption = 'Tipo do Operador'
        DataBinding.FieldName = 'OPE_INTEXT'
        Options.Editing = False
        Options.Focusing = False
        Styles.Header = cxStyle1
        Width = 129
      end
      object gridDadosDBTableOPE_SALFIX: TcxGridDBColumn
        Caption = 'Sal'#225'rio Fixo'
        DataBinding.FieldName = 'OPE_SALFIX'
        HeaderAlignmentHorz = taRightJustify
        Styles.Header = cxStyle1
        Width = 100
      end
      object gridDadosDBTableOPE_CODFAV: TcxGridDBColumn
        Caption = 'Faixa Fat.'
        DataBinding.FieldName = 'OPE_CODFAV'
        Styles.Header = cxStyle1
        Width = 60
      end
      object gridDadosDBTableOPE_PERADI: TcxGridDBColumn
        Caption = '% Adicional '
        DataBinding.FieldName = 'OPE_PERADI'
        HeaderAlignmentHorz = taRightJustify
        Styles.Header = cxStyle1
        Width = 100
      end
    end
    object gridCadOpeLevel1: TcxGridLevel
      GridView = gridCadOpeDBTableView1
    end
  end
  inherited pnlStatus: TPanel
    Top = 405
    Width = 828
    ExplicitTop = 405
    ExplicitWidth = 828
    inherited pnlNomeForm: TPanel
      Left = 657
      ExplicitLeft = 657
    end
    inherited pnlInfo: TPanel
      Width = 657
      ExplicitWidth = 657
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 360
    Top = 240
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 328
    Top = 240
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 392
    Top = 240
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
  end
  object qryCadOpe: TUniQuery
    Connection = frmModulo.Database
    Constraints = <>
    Left = 328
    Top = 208
  end
  object dtsCadOpe: TDataSource
    DataSet = qryCadOpe
    Left = 360
    Top = 208
  end
end
