inherited frmCtrDocBaixa: TfrmCtrDocBaixa
  Width = 1067
  Height = 625
  Caption = 'Detalhes de Documentos da Baixa'
  Position = poMainFormCenter
  ExplicitWidth = 1067
  ExplicitHeight = 625
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 552
    Width = 1061
    ExplicitTop = 552
    ExplicitWidth = 1061
    inherited FlwBotoes: TFlowPanel
      Width = 1057
      ExplicitWidth = 1057
      object lblTotal: TLabel
        Left = 0
        Top = 0
        Width = 133
        Height = 22
        Alignment = taRightJustify
        Caption = 'Total Recebido:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindow
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object edtValorTotal: TEditFocus
        Left = 133
        Top = 0
        Width = 117
        Height = 24
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 978
      ExplicitLeft = 978
    end
  end
  inherited pnlStatus: TPanel
    Top = 580
    Width = 1061
    ExplicitTop = 580
    ExplicitWidth = 1061
    inherited pnlNomeForm: TPanel
      Left = 890
      ExplicitLeft = 890
    end
    inherited pnlInfo: TPanel
      Width = 890
      ExplicitWidth = 890
    end
  end
  object dbgDuplicatas: TcxGrid [2]
    Left = 0
    Top = 0
    Width = 1061
    Height = 552
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object dbgDuplicatasDBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = dbgDuplicatasDBTableView1CustomDrawCell
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.NoDataToDisplayInfoText = '<Sem dados para exibir>'
      OptionsView.ScrollBars = ssVertical
      OptionsView.GroupByBox = False
      object dbgDuplicatasCODCLI: TcxGridDBColumn
        Caption = 'C'#243'd. Cli.'
        DataBinding.FieldName = 'CODCLI'
        Width = 55
      end
      object dbgDuplicatasCLIENTE: TcxGridDBColumn
        Caption = 'Cliente'
        DataBinding.FieldName = 'CLIENTE'
        Width = 178
      end
      object dbgDuplicatasCODFOR: TcxGridDBColumn
        Caption = 'C'#243'd. For.'
        DataBinding.FieldName = 'CODFOR'
        Visible = False
        Width = 56
      end
      object dbgDuplicatasFORNECEDOR: TcxGridDBColumn
        Caption = 'Fornecedor'
        DataBinding.FieldName = 'FORNECEDOR'
        Visible = False
        Options.AutoWidthSizable = False
        Width = 197
      end
      object dbgDuplicatasNUMDUP: TcxGridDBColumn
        Caption = 'Duplicata'
        DataBinding.FieldName = 'NUMDUP'
        Width = 84
      end
      object dbgDuplicatasESPDOC: TcxGridDBColumn
        Caption = 'Esp'#233'cie'
        DataBinding.FieldName = 'ESPDOC'
        Width = 50
      end
      object dbgDuplicatasPARCEL: TcxGridDBColumn
        Caption = 'Parcela'
        DataBinding.FieldName = 'PARCEL'
        Width = 44
      end
      object dbgDuplicatasSEQBAI: TcxGridDBColumn
        Caption = 'Seq. Baixa'
        DataBinding.FieldName = 'SEQBAI'
        Width = 61
      end
      object dbgDuplicatasEMPRESA: TcxGridDBColumn
        Caption = 'Empresa'
        DataBinding.FieldName = 'EMPRESA'
        Width = 121
      end
      object dbgDuplicatasDTACAD: TcxGridDBColumn
        Caption = 'Dt. Cadastro'
        DataBinding.FieldName = 'DTACAD'
        Width = 80
      end
      object dbgDuplicatasDTAVEN: TcxGridDBColumn
        Caption = 'Dt. Vencimento'
        DataBinding.FieldName = 'DTAVEN'
        Width = 80
      end
      object dbgDuplicatasPORTADOR: TcxGridDBColumn
        Caption = 'Protador'
        DataBinding.FieldName = 'PORTADOR'
        Width = 108
      end
      object dbgDuplicatasNOSNUM: TcxGridDBColumn
        Caption = 'Nosso N'#250'mero'
        DataBinding.FieldName = 'NOSNUM'
        Width = 79
      end
      object dbgDuplicatasVALOR_: TcxGridDBColumn
        Caption = 'Valor Recebido'
        DataBinding.FieldName = 'VALOR_'
        HeaderAlignmentHorz = taRightJustify
        HeaderGlyphAlignmentHorz = taRightJustify
        Width = 97
      end
    end
    object dbgDuplicatasLevel1: TcxGridLevel
      GridView = dbgDuplicatasDBTableView1
    end
  end
end
