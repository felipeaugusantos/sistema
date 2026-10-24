inherited frmSaldoTintas: TfrmSaldoTintas
  Left = 300
  Top = 181
  Width = 757
  Height = 452
  BorderIcons = [biSystemMenu]
  Caption = 'Saldo Insuficiente - Tintas'
  Position = poScreenCenter
  PrintScale = poNone
  ExplicitWidth = 757
  ExplicitHeight = 452
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 380
    Width = 751
    ExplicitTop = 380
    ExplicitWidth = 751
    inherited btnSair: TBitBtnLocked
      Left = 668
      ExplicitLeft = 668
    end
  end
  object dbgTintas: TcxGrid [2]
    Left = 0
    Top = 0
    Width = 751
    Height = 377
    Align = alClient
    TabOrder = 2
    LookAndFeel.Kind = lfOffice11
    LookAndFeel.ScrollbarMode = sbmClassic
    object dbgTintasDBTableView1: TcxGridDBTableView
      OnKeyPress = dbgTintasDBTableView1KeyPress
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = dbgTintasDBTableView1CustomDrawCell
      DataController.DataSource = dtsFormulas
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      object dbgTintasDBTableView1GRUPO: TcxGridDBColumn
        Caption = 'Tinta '
        DataBinding.FieldName = 'GRUPO'
        Visible = False
        BestFitMaxWidth = 600
        GroupIndex = 0
        MinWidth = 600
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 600
      end
      object dbgTintasDBTableView1COLORANTE: TcxGridDBColumn
        Caption = 'Colorante / Base'
        DataBinding.FieldName = 'COLORANTE'
        MinWidth = 470
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 470
      end
      object dbgTintasDBTableView1QUANTIDADE: TcxGridDBColumn
        Caption = 'Quantidade'
        DataBinding.FieldName = 'QUANTIDADE'
        MinWidth = 80
        Options.Editing = False
        Width = 80
      end
      object dbgTintasDBTableView1QUANTACUMU: TcxGridDBColumn
        Caption = 'Quant. Acumul.'
        DataBinding.FieldName = 'QUANTACUMU'
        MinWidth = 80
        Options.Editing = False
        Width = 80
      end
      object dbgTintasDBTableView1SALDO: TcxGridDBColumn
        Caption = 'Saldo'
        DataBinding.FieldName = 'SALDO'
        MinWidth = 80
        Options.Editing = False
        Width = 80
      end
      object dbgTintasDBTableView1TIPO: TcxGridDBColumn
        Caption = 'Tipo'
        DataBinding.FieldName = 'TIPO'
        Visible = False
        GroupIndex = 1
        MinWidth = 80
        Width = 80
      end
    end
    object dbgTintasLevel1: TcxGridLevel
      GridView = dbgTintasDBTableView1
    end
  end
  inherited pnlStatus: TPanel
    Top = 408
    Width = 751
    ExplicitTop = 408
    ExplicitWidth = 751
    inherited pnlNomeForm: TPanel
      Left = 580
      ExplicitLeft = 580
    end
    inherited pnlInfo: TPanel
      Width = 580
      ExplicitWidth = 580
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Top = 88
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 360
    Top = 88
  end
  object cdsFormulas: TUniClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'ID'
        DataType = ftInteger
      end
      item
        Name = 'DESCRICAO'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'COLORANTE'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'QUANTIDADE'
        DataType = ftFloat
      end
      item
        Name = 'QUANTACUMU'
        DataType = ftFloat
      end
      item
        Name = 'SALDO'
        DataType = ftFloat
      end
      item
        Name = 'GRUPO'
        DataType = ftString
        Size = 200
      end
      item
        Name = 'TIPO'
        DataType = ftString
        Size = 20
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 512
    Top = 128
  end
  object dtsFormulas: TDataSource
    AutoEdit = False
    DataSet = cdsFormulas
    Left = 312
    Top = 128
  end
  object cdsSemSaldo: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 80
    Top = 160
    object cdsSemSaldoIDTINTA: TIntegerField
      FieldName = 'IDTINTA'
    end
  end
end
