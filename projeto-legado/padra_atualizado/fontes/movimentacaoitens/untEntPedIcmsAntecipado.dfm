inherited frmEntPedIcmsAntecipado: TfrmEntPedIcmsAntecipado
  Width = 800
  Height = 554
  BorderStyle = bsSizeable
  Caption = 'Informe os produtos que ter'#227'o ICMS Antecipado'
  ExplicitWidth = 800
  ExplicitHeight = 554
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 471
    Width = 784
    ExplicitTop = 471
    ExplicitWidth = 784
    inherited btnSair: TBitBtnLocked
      Left = 703
      ExplicitLeft = 703
    end
    inherited btnConfirma: TBitBtnLocked
      Left = 3
      Width = 113
      Caption = '[ F10 ] Confirma'
      ModalResult = 0
      ExplicitLeft = 3
      ExplicitWidth = 113
    end
  end
  object cxgItens: TcxGrid [2]
    Left = 0
    Top = 0
    Width = 784
    Height = 459
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgItensView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = ' '
      OptionsView.GroupByBox = False
      object cxgItensCODITE: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'ENT_CODITE'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 55
      end
      object cxgItensDESITE: TcxGridDBColumn
        Caption = 'Descri'#231#227'o do Item'
        DataBinding.FieldName = 'ENT_DESITE'
        Options.Editing = False
        Width = 237
      end
      object cxgItensREFERE: TcxGridDBColumn
        Caption = 'Refer'#234'ncia'
        DataBinding.FieldName = 'ENT_REFERE'
        Options.Editing = False
        Width = 83
      end
      object cxgItensUNIDAD: TcxGridDBColumn
        Caption = 'Unidade'
        DataBinding.FieldName = 'ENT_SIGUNI'
        Options.Editing = False
        Width = 45
      end
      object cxgItensCODCST: TcxGridDBColumn
        Caption = 'Sit.Tribut'#225'ria'
        DataBinding.FieldName = 'ENT_CODFIS'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 80
      end
      object cxgItensANTPRO: TcxGridDBColumn
        Caption = 'ICMS Antecipado'
        DataBinding.FieldName = 'ENT_ANTPRO'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ImmediatePost = True
        Properties.ValueChecked = 'S'
        Properties.ValueUnchecked = 'N'
        HeaderAlignmentHorz = taCenter
        Width = 95
      end
      object cxgItensANTFRE: TcxGridDBColumn
        Caption = 'ICMS Antecipado sobre o Frete'
        DataBinding.FieldName = 'ENT_ANTFRE'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ImmediatePost = True
        Properties.ValueChecked = 'S'
        Properties.ValueUnchecked = 'N'
        HeaderAlignmentHorz = taCenter
        Width = 168
      end
    end
    object cxgItensLevel1: TcxGridLevel
      GridView = cxgItensView
    end
  end
  object prbProgresso: TProgressBar [3]
    Left = 0
    Top = 459
    Width = 784
    Height = 12
    Align = alBottom
    Smooth = True
    TabOrder = 3
    Visible = False
  end
  inherited pnlStatus: TPanel
    Top = 499
    Width = 784
    ExplicitTop = 499
    ExplicitWidth = 784
    inherited pnlNomeForm: TPanel
      Left = 613
      ExplicitLeft = 613
    end
    inherited pnlInfo: TPanel
      Width = 613
      ExplicitWidth = 613
    end
  end
end
