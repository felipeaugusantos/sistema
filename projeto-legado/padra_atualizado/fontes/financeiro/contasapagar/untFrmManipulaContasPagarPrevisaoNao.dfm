inherited FrmManipulaContasPagarPrevisaoNao: TFrmManipulaContasPagarPrevisaoNao
  Width = 1122
  Height = 500
  Caption = 'Manipula'#231#227'o de Contas a Pagar'
  OnDestroy = FormDestroy
  ExplicitWidth = 1122
  ExplicitHeight = 500
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 429
    Width = 1116
    ExplicitTop = 429
    ExplicitWidth = 1116
    inherited FlwBotoes: TFlowPanel
      Left = 123
      Width = 991
      ExplicitLeft = 123
      ExplicitWidth = 991
      inherited btnConfirma: TBitBtnLocked
        Visible = False
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 1036
      ExplicitLeft = 1036
    end
    object btnConfirmar: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 121
      Height = 22
      Align = alLeft
      Caption = '&Confirmar'
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
      NumGlyphs = 2
      TabOrder = 2
      OnClick = btnConfirmarClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 455
    Width = 1116
    ExplicitTop = 455
    ExplicitWidth = 1116
    inherited pnlNomeForm: TPanel
      Left = 945
      ExplicitLeft = 945
    end
    inherited pnlInfo: TPanel
      Width = 945
      ExplicitWidth = 945
    end
  end
  object meInformativo: TMemo [2]
    Left = 0
    Top = 0
    Width = 1116
    Height = 51
    Align = alTop
    Enabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = 16
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object rgOperacoes: TRadioGroup [3]
    Left = 0
    Top = 51
    Width = 1116
    Height = 88
    Align = alTop
    Caption = 'Informe a opera'#231#227'o desejada:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = 16
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ItemIndex = 0
    Items.Strings = (
      'Manter a previs'#227'o sem alterar nada.'
      'Abater o valor desta duplicata, do valor da previs'#227'o.'
      'Excluir a previs'#227'o.')
    ParentFont = False
    TabOrder = 3
    OnClick = rgOperacoesClick
  end
  object cxgTitulosComPrevisaoSim: TcxGrid [4]
    Left = 0
    Top = 139
    Width = 1116
    Height = 290
    Align = alClient
    Enabled = False
    TabOrder = 4
    object cxgTitulosComPrevisaoSimDBTableView1: TcxGridDBTableView
      OnDblClick = cxgTitulosComPrevisaoSimDBTableView1DblClick
      OnKeyDown = cxgTitulosComPrevisaoSimDBTableView1KeyDown
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxgTitulosComPrevisaoSimDBTableView1CustomDrawCell
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsSelection.MultiSelect = True
      OptionsSelection.InvertSelect = False
      OptionsView.GroupByBox = False
      object cxgTitulosComPrevisaoSimMARDES: TcxGridDBColumn
        DataBinding.FieldName = 'MARDES'
        Visible = False
        Width = 33
        IsCaptionAssigned = True
      end
      object cxgTitulosComPrevisaoSimAUTOINCREM: TcxGridDBColumn
        DataBinding.FieldName = 'AUTOINCREM'
        Visible = False
        Width = 167
      end
      object cxgTitulosComPrevisaoSimCTP_NUMDUP: TcxGridDBColumn
        Caption = 'Duplicata'
        DataBinding.FieldName = 'CTP_NUMDUP'
        Width = 92
      end
      object cxgTitulosComPrevisaoSimCTP_CODEMP: TcxGridDBColumn
        Caption = 'Emp.'
        DataBinding.FieldName = 'CTP_CODEMP'
        Width = 31
      end
      object cxgTitulosComPrevisaoSimCTP_CODFOR: TcxGridDBColumn
        Caption = 'C'#243'd. Forn.'
        DataBinding.FieldName = 'CTP_CODFOR'
        Width = 55
      end
      object cxgTitulosComPrevisaoSimFOR_NOMFOR: TcxGridDBColumn
        Caption = 'Nome Forn.'
        DataBinding.FieldName = 'FOR_NOMFOR'
        Width = 240
      end
      object cxgTitulosComPrevisaoSimCTA_DESCTA: TcxGridDBColumn
        Caption = 'Plano de Contas'
        DataBinding.FieldName = 'CTA_DESCTA'
        Width = 160
      end
      object cxgTitulosComPrevisaoSimCTP_CODPOR: TcxGridDBColumn
        Caption = 'C'#243'd. Port.'
        DataBinding.FieldName = 'CTP_CODPOR'
        Width = 55
      end
      object cxgTitulosComPrevisaoSimCTP_NOMPOR: TcxGridDBColumn
        Caption = 'Portador'
        DataBinding.FieldName = 'POR_NOMPOR'
        Width = 240
      end
      object cxgTitulosComPrevisaoSimCTP_DTACAD: TcxGridDBColumn
        Caption = 'Cadastro'
        DataBinding.FieldName = 'CTP_DTACAD'
        Width = 65
      end
      object cxgTitulosComPrevisaoSimCTP_DTAVEN: TcxGridDBColumn
        Caption = 'Vencimento'
        DataBinding.FieldName = 'CTP_DTAVEN'
        Width = 70
      end
      object cxgTitulosComPrevisaoSimCTP_VALDUP: TcxGridDBColumn
        Caption = 'Valor Duplicata'
        DataBinding.FieldName = 'CTP_VALDUP'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00'
        Width = 100
      end
    end
    object cxgTitulosComPrevisaoSimLevel1: TcxGridLevel
      GridView = cxgTitulosComPrevisaoSimDBTableView1
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 392
    Top = 72
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 496
    Top = 72
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 608
    Top = 72
  end
  object dsTitulosComPrevisaoSim: TDataSource
    Left = 784
    Top = 72
  end
end
