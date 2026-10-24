inherited frmCampoItegerPermiteEdicao: TfrmCampoItegerPermiteEdicao
  Width = 734
  Height = 712
  Caption = 'Composi'#231#227'o de Pre'#231'o Edit'#225'vel - Filial'
  Position = poMainFormCenter
  OnCloseQuery = FormCloseQuery
  ExplicitWidth = 734
  ExplicitHeight = 712
  PixelsPerInch = 96
  TextHeight = 14
  object lblEmpresa: TLabel [0]
    Left = 0
    Top = 0
    Width = 728
    Height = 14
    Align = alTop
    Caption = 'Empresa Selecionada:'
    ExplicitWidth = 107
  end
  inherited pnlBotoes: TPanel
    Top = 639
    Width = 728
    ExplicitTop = 639
    ExplicitWidth = 728
    inherited FlwBotoes: TFlowPanel
      Width = 724
      ExplicitWidth = 724
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 121
        Height = 23
        Caption = '[ F10 ] Confirma'
        Enabled = False
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
      object btnSelecionaEmpresa: TBitBtnLocked
        Left = 121
        Top = 0
        Width = 144
        Height = 23
        Caption = '[ F9 ] Seleciona Empresa'
        TabOrder = 1
        OnClick = btnSelecionaEmpresaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 645
      ExplicitLeft = 645
    end
  end
  inherited pnlStatus: TPanel
    Top = 667
    Width = 728
    ExplicitTop = 667
    ExplicitWidth = 728
    inherited pnlNomeForm: TPanel
      Left = 557
      ExplicitLeft = 557
    end
    inherited pnlInfo: TPanel
      Width = 557
      ExplicitWidth = 557
    end
  end
  object cxgDados: TcxGrid [3]
    Left = 0
    Top = 14
    Width = 728
    Height = 608
    Align = alClient
    TabOrder = 2
    object cxvDados: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsDados
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.GroupByBox = False
      object cxvDadosColumn1: TcxGridDBColumn
        Caption = 'Permite Edi'#231#227'o'
        DataBinding.FieldName = 'PRE_ALTERA'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ImmediatePost = True
        Properties.ValueChecked = '1'
        Properties.ValueUnchecked = '0'
        Width = 80
      end
      object cxvDadosColumn2: TcxGridDBColumn
        Caption = 'Campo'
        DataBinding.FieldName = 'PRE_DESCRI'
        Options.Editing = False
        Width = 461
      end
    end
    object cxlDados: TcxGridLevel
      GridView = cxvDados
    end
  end
  object pnlOpcaoMarcacao: TPanel [4]
    Left = 0
    Top = 622
    Width = 728
    Height = 17
    Align = alBottom
    Padding.Left = 5
    Padding.Right = 5
    TabOrder = 3
    Visible = False
    object lblDesmarcaTodos: TLabel
      Left = 106
      Top = 1
      Width = 125
      Height = 15
      Align = alLeft
      AutoSize = False
      Caption = 'Desmarcar Todos'
      Color = clHighlight
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsUnderline]
      ParentColor = False
      ParentFont = False
      OnClick = lblDesmarcaTodosClick
    end
    object lblMarcaTodos: TLabel
      Left = 6
      Top = 1
      Width = 100
      Height = 15
      Align = alLeft
      AutoSize = False
      Caption = 'Marcar Todos'
      Color = clHighlight
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsUnderline]
      ParentColor = False
      ParentFont = False
      OnClick = lblMarcaTodosClick
    end
    object lblInverte: TLabel
      Left = 231
      Top = 1
      Width = 100
      Height = 15
      Align = alLeft
      AutoSize = False
      Caption = 'Inverter Sele'#231#227'o'
      Color = clHighlight
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsUnderline]
      ParentColor = False
      ParentFont = False
      OnClick = lblInverteClick
      ExplicitLeft = 232
    end
  end
  object dtsDados: TDataSource
    Left = 352
    Top = 240
  end
end
